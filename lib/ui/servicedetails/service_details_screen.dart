import 'package:fixteck/ui/servicedetails/widgets/service_selection_bottom_sheet.dart';
import 'package:fixteck/ui/widgets/promo_card.dart';
import 'package:flutter/material.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String serviceName;
  
  const ServiceDetailsScreen({super.key, this.serviceName = 'Plumbing'});

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
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=800&q=80',
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
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),
                // Back Button
                Positioned(
                  top: 50,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                // Title Text
                Positioned(
                  bottom: 30,
                  left: 24,
                  right: 24,
                  child: Text(
                    'Affordable repairs\nat home door...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),

            // Service Name and Rating
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.black87, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '4.8 (1.5M bookings)',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Promotional Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PromoCard(text: 'Save 10% on every order'),
                const SizedBox(width: 12),
                PromoCard(text: 'Save 10% on every order'),
              ],
            ),
            SizedBox(height: 30),
            Divider(thickness: 5, height: 5),
            SizedBox(height: 30),

            // Service Categories Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
                children: [
                  ...[
                    {
                      'title': 'Toilet',
                      'image':
                          'https://images.unsplash.com/photo-1595515106969-1ce29566ff1c?w=400&q=80',
                    },
                    {
                      'title': 'Bath & Shower',
                      'image':
                          'https://images.unsplash.com/photo-1620626011761-996317b8d101?w=400&q=80',
                    },
                    {
                      'title': 'Tap & mixer',
                      'image':
                          'https://images.unsplash.com/photo-1585421514738-01798e348b17?w=400&q=80',
                    },
                    {
                      'title': 'Drainage &\nBlockage',
                      'image':
                          'https://images.unsplash.com/photo-1581094271901-8022df4466f9?w=400&q=80',
                    },
                    {
                      'title': 'Bath\naccessories',
                      'image':
                          'https://images.unsplash.com/photo-1620626011761-996317b8d101?w=400&q=80',
                    },
                    {
                      'title': 'Basin & sink',
                      'image':
                          'https://images.unsplash.com/photo-1581094271901-8022df4466f9?w=400&q=80',
                    },
                    {
                      'title': 'Tap & mixer',
                      'image':
                          'https://images.unsplash.com/photo-1585421514738-01798e348b17?w=400&q=80',
                    },
                    {
                      'title': 'Drainage &\nBlockage',
                      'image':
                          'https://images.unsplash.com/photo-1581094271901-8022df4466f9?w=400&q=80',
                    },
                  ].map((category) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => ServiceSelectionBottomSheet(
                            title: category['title']!,
                          ),
                        );
                      },
                      child: _ServiceCategoryCard(
                        image: category['image']!,
                        title: category['title']!,
                      ),
                    );
                  }),
                ],
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ServiceCategoryCard extends StatelessWidget {
  final String image;
  final String title;

  const _ServiceCategoryCard({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
