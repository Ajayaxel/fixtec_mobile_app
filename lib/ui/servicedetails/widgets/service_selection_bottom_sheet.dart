import 'package:fixteck/ui/bookings/booking_details_page.dart';
import 'package:fixteck/ui/bookings/bookings_page.dart';
import 'package:fixteck/ui/bookings/service/service_page.dart';
import 'package:fixteck/ui/servicedetails/widgets/uplod_issue_section.dart';
import 'package:flutter/material.dart';
import 'package:fixteck/ui/servicedetails/widgets/faq_item.dart';
import 'package:fixteck/ui/servicedetails/widgets/process_step.dart';
import 'package:fixteck/ui/servicedetails/widgets/product_card.dart';
import 'package:fixteck/ui/servicedetails/widgets/review_card.dart';
import 'package:fixteck/ui/servicedetails/widgets/technician_feature.dart';
import 'package:fixteck/const/fixtec_btn.dart';
import 'package:fixteck/const/themes/app_themes.dart';

class ServiceSelectionBottomSheet extends StatefulWidget {
  final String title;

  const ServiceSelectionBottomSheet({super.key, required this.title});

  @override
  State<ServiceSelectionBottomSheet> createState() =>
      _ServiceSelectionBottomSheetState();
}

class _ServiceSelectionBottomSheetState
    extends State<ServiceSelectionBottomSheet> {
  final Map<int, int> _cartItems = {}; // productIndex -> quantity
  final int _productPrice = 15; // AED 15 per product

  void _addToCart(int index) {
    setState(() {
      _cartItems[index] = 1;
    });
  }

  void _incrementQuantity(int index) {
    setState(() {
      _cartItems[index] = (_cartItems[index] ?? 0) + 1;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_cartItems[index] != null && _cartItems[index]! > 1) {
        _cartItems[index] = _cartItems[index]! - 1;
      } else {
        _cartItems.remove(index);
      }
    });
  }

  int get _totalItems {
    return _cartItems.values.fold(0, (sum, quantity) => sum + quantity);
  }

  int get _totalPrice {
    return _cartItems.values.fold(
        0, (sum, quantity) => sum + (quantity * _productPrice));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: _cartItems.isNotEmpty ? 100 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, size: 18, color: Colors.black54),
                              SizedBox(width: 4),
                              Text(
                                '4.8 (15K reviews)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 1, height: 1),
                    SizedBox(height: 20),

                    // Product List
                    SizedBox(
                      height: 260,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            quantity: _cartItems[index] ?? 0,
                            onAdd: () => _addToCart(index),
                            onIncrement: () => _incrementQuantity(index),
                            onDecrement: () => _decrementQuantity(index),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 8, color: Colors.grey[100]),
                    SizedBox(height: 20),

                    // Our Process
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Our process',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          ProcessStep(
                            number: '1',
                            title: 'Lorem Ipsum is simply',
                            description:
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
                            isLast: false,
                          ),
                          ProcessStep(
                            number: '2',
                            title: 'Lorem Ipsum is simply',
                            description:
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
                            isLast: false,
                          ),
                          ProcessStep(
                            number: '3',
                            title: 'Lorem Ipsum is simply',
                            description:
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
                            isLast: false,
                          ),
                          ProcessStep(
                            number: '4',
                            title: 'Lorem Ipsum is simply',
                            description:
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 8, color: Colors.grey[100]),
                    SizedBox(height: 20),

                    // Upload your issue
                    UploadIssue(),
                    SizedBox(height: 20),
                    Divider(thickness: 8, color: Colors.grey[100]),
                    SizedBox(height: 20),

                    // Top technicians
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top technicians',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    TechnicianFeature(
                                      text: 'Lorem Ipsum is simply dummy',
                                    ),
                                    SizedBox(height: 16),
                                    TechnicianFeature(
                                      text:
                                          'Lorem Ipsum is simply dummy text of the printing',
                                    ),
                                    SizedBox(height: 16),
                                    TechnicianFeature(
                                      text:
                                          'Lorem Ipsum is simply dummy text of the printing',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              Container(
                                width: 120,
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/service/detailsbootmsheetman.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 8, color: Colors.grey[100]),
                    SizedBox(height: 20),

                    // FAQ's
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FAQ\'s',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          FAQItem(
                            text:
                                'Lorem Ipsum has been the industry\'s standard dummy text ever since',
                          ),
                          FAQItem(
                            text:
                                'Lorem Ipsum has been the industry\'s standard dummy text ever since',
                          ),
                          FAQItem(
                            text:
                                'Lorem Ipsum has been the industry\'s standard dummy text ever since',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 8, color: Colors.grey[100]),
                    SizedBox(height: 20),

                    // All reviews
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'All reviews',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 176,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 16),
                              itemBuilder: (context, index) {
                                return ReviewCard();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              // Bottom Cart Section
              if (_cartItems.isNotEmpty)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                _totalItems.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'AED $_totalPrice',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 2,
                            child: FixtecBtn(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ServicePage()));
                              },
                              bgColor: AppThemes.bgBtnColor,
                              textColor: AppThemes.textBtnColor,
                              child: Text('Continue'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 20, color: Colors.black),
                  ),
                ),
              ),
              // Drag Handle (Optional but good for UX)
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
