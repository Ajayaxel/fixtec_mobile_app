import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const Color backgroundColor = Color(0xFFF5F6FB);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Top container with dark teal background and rounded bottom corners
          Container(
            decoration: BoxDecoration(
              color: Color(0xff00343D),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Column(
                    children: [
                      // App bar with back button and title
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).maybePop(),
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Help & Support',
                              style: textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Content section with greeting and speech bubbles
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Left-aligned text column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hey 👋',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'How can we help?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // Speech bubbles positioned on the right
                            Positioned(
                              right: 0,
                              top: -30,
                              child: Image.asset(
                                "assets/helpandsupport/questionicon.png",
                                width: 120,
                                height: 124,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Lower section with search bar
          Expanded(
            child: Container(
              color: backgroundColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffDBDADF)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "All Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  // Category list
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _buildCategoryItem(
                          icon: Icons.book_outlined,
                          iconColor: Color(0xFF2196F3), // Blue
                          title: "Booking a Service",
                        ),
                        SizedBox(height: 12),
                        _buildCategoryItem(
                          icon: Icons.person_outline,
                          iconColor: Color(0xFF9C27B0), // Purple
                          title: "Account & Profile",
                        ),
                        SizedBox(height: 12),
                        _buildCategoryItem(
                          icon: Icons.account_balance_wallet_outlined,
                          iconColor: Color(0xFFFFC107), // Yellow
                          title: "Payments, Wallet & Rewards",
                        ),
                        SizedBox(height: 12),
                        _buildCategoryItem(
                          icon: Icons.feedback_outlined,
                          iconColor: Color(0xFF2196F3), // Blue
                          title: "Feedback & Complaints",
                        ),
                        SizedBox(height: 12),
                        _buildCategoryItem(
                          icon: Icons.verified_user_outlined,
                          iconColor: Color(0xFF4CAF50), // Green
                          title: "Safety & Trust",
                        ),
                        SizedBox(height: 12),
                        _buildCategoryItem(
                          icon: Icons.phone_outlined,
                          iconColor: Color(0xFFE91E63), // Pink
                          title: "Contact Us",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required Color iconColor,
    required String title,
  }) {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff717171),
                  ),
                ),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 24),
          ],
        ),
      ),
    );
  }
}
