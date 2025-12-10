import 'package:fixteck/const/fixtec_btn.dart';
import 'package:fixteck/const/themes/app_themes.dart';
import 'package:fixteck/ui/bookingconfirm/booking_confrim_screen.dart';
import 'package:fixteck/ui/bookings/select_address_page.dart';
import 'package:fixteck/ui/bookings/select_date_time_page.dart';
import 'package:fixteck/ui/widgets/promo_card.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  DateTime? _selectedDateTime;
  String _addressName = 'Shafi Muhammed';
  String _buildingName = 'Roohi Villas';
  String _fullAddress = 'CC-18/1375, Jalal Nagar, Karama 234561, Dubai';
  String _phoneNumber = '11223344556';

  String _formatDateTime(DateTime dateTime) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final day = dateTime.day.toString().padLeft(2, '0');
    final month = months[dateTime.month - 1];
    final year = dateTime.year;
    final weekday = weekdays[dateTime.weekday - 1];
    
    int hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    
    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour -= 12;
    }
    
    final hourStr = hour.toString().padLeft(2, '0');
    
    return '$day $month $year, $weekday $hourStr:$minute $period';
  }

  String _formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    
    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour -= 12;
    }
    
    final hourStr = hour.toString().padLeft(2, '0');
    return '$hourStr:$minute $period';
  }

  String get _displayDateTime {
    if (_selectedDateTime != null) {
      return _formatDateTime(_selectedDateTime!);
    }
    return '27 Oct 2025, Mon 03:45 PM'; // Default value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Section
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 16,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                const Positioned(
                  bottom: 60,
                  left: 20,
                  child: Text(
                    'Affordable repairs\nat home door...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),

            // Service Info Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Plumbing',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.black,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '4.8 (1.5M bookings)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Earliest',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Mon, 12:30 PM',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Promotional Cards
                  Row(
                    children: [
                      PromoCard(text: 'Save 10% on every order'),
                      const SizedBox(width: 12),
                      PromoCard(text: 'Save 10% on every order'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _divider(),
                  const SizedBox(height: 25),

                  // Service Required On
                  Text(
                    'Service required on',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff0A2342),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push<Map<String, dynamic>>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectDateAndTimePage(
                            initialDate: _selectedDateTime,
                          ),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          _selectedDateTime = result['dateTime'] as DateTime;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _displayDateTime,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Service Required At
                  Text(
                    'Service required at',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff0A2342),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A3A3A),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$_addressName\n$_buildingName\n$_fullAddress  $_phoneNumber',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SelectAddressPage(),
                              ),
                            );
                            // Update address if returned from SelectAddressPage
                            if (result != null && result is Map<String, dynamic>) {
                              setState(() {
                                _addressName = result['name'] ?? _addressName;
                                _buildingName = result['building'] ?? _buildingName;
                                _fullAddress = result['address'] ?? _fullAddress;
                                _phoneNumber = result['phone'] ?? _phoneNumber;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.edit_outlined, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Service Information Section
                  const Text(
                    'SERVICE INFORMATION',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Details of your requirement',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Enter here',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Bullet Points Section
                  _buildBulletPoint(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
                  ),
                  const SizedBox(height: 18),
                  _buildBulletPoint(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
                  ),
                  const SizedBox(height: 30),

                  // Expandable Sections
                  _buildExpandableSection('RATE CHART'),
                  const SizedBox(height: 1),
                  _buildExpandableSection('TERMS & CONDITIONS'),
                  const SizedBox(height: 1),
                  _buildExpandableSection('HOW IT WORKS'),
                  const SizedBox(height: 1),
                  _buildExpandableSection('FAQ'),
                  const SizedBox(height: 1),
                  _buildExpandableSection('REVIEWS'),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: FixtecBtn(
          onPressed: () {
            // Calculate time range for display
            String? timeRange;
            if (_selectedDateTime != null) {
              final startTime = _formatTime(_selectedDateTime!);
              final endDateTime = _selectedDateTime!.add(const Duration(hours: 2));
              final endTime = _formatTime(endDateTime);
              timeRange = '$startTime - $endTime';
            }
            
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingConfrimScreen(
                  serviceName: 'Plumbing',
                  serviceType: 'PLUMBER',
                  scheduledDate: _selectedDateTime,
                  scheduledTime: timeRange,
                  addressName: _addressName,
                  buildingName: _buildingName,
                  fullAddress: _fullAddress,
                  phoneNumber: _phoneNumber,
                  serviceInformation: 'Plumbing',
                ),
              ),
            );
          },
          bgColor: AppThemes.bgBtnColor,
          textColor: AppThemes.textBtnColor,
          child: const Text("Continue Booking"),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.settings, size: 20, color: Colors.black),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[800],
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableSection(String title) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
            size: 28,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _divider() {
  return const Divider(color: Color(0xffE0E0E0), thickness: 5);
}
