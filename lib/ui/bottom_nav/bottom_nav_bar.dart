import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 320;
    final isSmallScreen = screenWidth < 360;
    final isMediumScreen = screenWidth < 400;
    
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF3F9FA),
        borderRadius: const BorderRadius.all(
         Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: isVerySmallScreen ? 65 : (isSmallScreen ? 70 : 80),
          padding: EdgeInsets.symmetric(
            horizontal: isVerySmallScreen ? 8 : (isSmallScreen ? 12 : 20),
            vertical: isVerySmallScreen ? 4 : (isSmallScreen ? 6 : 8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
                isSelected: widget.currentIndex == 0,
                isVerySmallScreen: isVerySmallScreen,
                isSmallScreen: isSmallScreen,
                isMediumScreen: isMediumScreen,
              ),
              _buildNavItem(
                icon: Icons.receipt_long,
                label: 'Bookings',
                index: 1,
                isSelected: widget.currentIndex == 1,
                isVerySmallScreen: isVerySmallScreen,
                isSmallScreen: isSmallScreen,
                isMediumScreen: isMediumScreen,
              ),
              _buildNavItem(
                icon: Icons.person,
                label: 'Account',
                index: 2,
                isSelected: widget.currentIndex == 2,
                isVerySmallScreen: isVerySmallScreen,
                isSmallScreen: isSmallScreen,
                isMediumScreen: isMediumScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    required bool isVerySmallScreen,
    required bool isSmallScreen,
    required bool isMediumScreen,
  }) {
    return Flexible(
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        child: Container(
          constraints: BoxConstraints(
            minWidth: 0,
            maxWidth: double.infinity,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isVerySmallScreen ? 4 : (isSmallScreen ? 6 : 8),
            vertical: isVerySmallScreen ? 4 : (isSmallScreen ? 5 : 6),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: isVerySmallScreen ? 2 : (isSmallScreen ? 3 : 4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Color(0xff00343D) : Color(0xff777988),
                size: isVerySmallScreen ? 18 : (isSmallScreen ? 20 : 24),
              ),
              SizedBox(height: isVerySmallScreen ? 1 : (isSmallScreen ? 2 : 4)),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.manrope(
                    fontSize: isVerySmallScreen ? 9 : (isSmallScreen ? 10 : 12),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Color(0xff00343D) : Color(0xff777988),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

