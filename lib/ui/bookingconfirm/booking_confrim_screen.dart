import 'package:fixteck/const/themes/app_themes.dart';
import 'package:flutter/material.dart';

class BookingConfrimScreen extends StatefulWidget {
  final String serviceName;
  final String serviceType;
  final DateTime? scheduledDate;
  final String? scheduledTime;
  final String? addressName;
  final String? buildingName;
  final String? fullAddress;
  final String? phoneNumber;
  final String? serviceInformation;

  const BookingConfrimScreen({
    super.key,
    this.serviceName = 'Plumbing',
    this.serviceType = 'PLUMBER',
    this.scheduledDate,
    this.scheduledTime,
    this.addressName = 'Shafi Muhammed',
    this.buildingName = 'Roohi Villas',
    this.fullAddress = 'CC-18/1375, Jalal Nagar, Karama 234561, Dubai',
    this.phoneNumber = '11223344556',
    this.serviceInformation = 'Plumbing',
  });

  @override
  State<BookingConfrimScreen> createState() => _BookingConfrimScreenState();
}

class _BookingConfrimScreenState extends State<BookingConfrimScreen> {
  String? _selectedPaymentMode; // 'cash' or 'online'
  bool _termsAccepted = false;
  bool _redeemCoinsSelected = false;
  bool _promoCodeSelected = false;

  String _formatDate(DateTime date) {
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

    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year;
    final weekday = weekdays[date.weekday - 1];

    return '$day $month $year, $weekday';
  }

  String _formatTime(DateTime date) {
    int hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';

    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour -= 12;
    }

    final hourStr = hour.toString().padLeft(2, '0');
    return '$hourStr:$minute $period';
  }

  String get _displayDate {
    if (widget.scheduledDate != null) {
      return _formatDate(widget.scheduledDate!);
    }
    return '28 Oct 2025, Tue';
  }

  String get _displayTime {
    if (widget.scheduledTime != null) {
      return widget.scheduledTime!;
    } else if (widget.scheduledDate != null) {
      // Calculate time range (2 hours slot)
      final startTime = _formatTime(widget.scheduledDate!);
      final endDateTime = widget.scheduledDate!.add(const Duration(hours: 2));
      final endTime = _formatTime(endDateTime);
      return '$startTime - $endTime';
    }
    return '10:00 AM - 12:00 PM';
  }

  @override
  void initState() {
    super.initState();
    // Default to cash on delivery
    _selectedPaymentMode = 'cash';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          widget.serviceName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SERVICE DETAILS Card
            _buildServiceDetailsCard(),
            const SizedBox(height: 16),

            // ADDRESS Card
            _buildAddressCard(),
            const SizedBox(height: 16),

            // REDEEM COINS & PROMO CODE Card
            _buildRedeemPromoCard(),
            const SizedBox(height: 24),

            // SELECT PAYMENT MODE Section
            _buildPaymentModeSection(),
            const SizedBox(height: 24),

            // Terms & Conditions
            _buildTermsAndConditions(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SERVICE DETAILS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Service Name', widget.serviceType),
          const SizedBox(height: 12),
          _buildDetailRow('Scheduled Date', _displayDate),
          const SizedBox(height: 12),
          _buildDetailRow('Scheduled Time', _displayTime),
          const SizedBox(height: 12),
          _buildDetailRow('Service Information', widget.serviceInformation ?? 'Plumbing'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ADDRESS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.addressName ?? 'Shafi Muhammed',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.buildingName ?? 'Roohi Villas',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.fullAddress ?? 'CC-18/1375, Jalal Nagar, Karama 234561, Dubai',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.phoneNumber ?? '11223344556',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRedeemPromoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // REDEEM COINS Option
          _buildRedeemPromoOption(
            title: 'REDEEM COINS',
            subtitle: 'Rewards Balance: 0',
            icon: Icons.monetization_on,
            isSelected: _redeemCoinsSelected,
            onTap: () {
              setState(() {
                _redeemCoinsSelected = !_redeemCoinsSelected;
                if (_redeemCoinsSelected) {
                  _promoCodeSelected = false;
                }
              });
            },
          ),
          const SizedBox(height: 16),
          // PROMO CODE Option
          _buildRedeemPromoOption(
            title: 'PROMO CODE',
            subtitle: 'Click here to see discount coupons',
            icon: Icons.local_offer,
            isSelected: _promoCodeSelected,
            onTap: () {
              setState(() {
                _promoCodeSelected = !_promoCodeSelected;
                if (_promoCodeSelected) {
                  _redeemCoinsSelected = false;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRedeemPromoOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          // Radio Button
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppThemes.bgBtnColor : Colors.grey[400]!,
                width: 2,
              ),
              color: isSelected ? AppThemes.bgBtnColor : Colors.transparent,
            ),
            child: isSelected
                ? const Center(
                    child: Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          // Icon
          Icon(icon, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Arrow Icon
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentModeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SELECT PAYMENT MODE',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        // Cash on Delivery
        _buildPaymentModeButton(
          title: 'CASH ON DELIVERY',
          isSelected: _selectedPaymentMode == 'cash',
          onTap: () {
            setState(() {
              _selectedPaymentMode = 'cash';
            });
          },
        ),
        const SizedBox(height: 12),
        // Pay Online
        _buildPaymentModeButton(
          title: 'PAY ONLINE',
          isSelected: _selectedPaymentMode == 'online',
          onTap: () {
            setState(() {
              _selectedPaymentMode = 'online';
            });
          },
        ),
      ],
    );
  }

  Widget _buildPaymentModeButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF122C31), // Dark teal (0%)
              Color(0xFF378997), // Light teal (100%)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Colors.white, width: 2)
              : null,
        ),
        child: Row(
          children: [
            // Radio Button
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected ? Colors.white : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.white70,
                ),
              ),
            ),
            // Arrow Icon
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _termsAccepted = !_termsAccepted;
            });
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: _termsAccepted ? AppThemes.bgBtnColor : Colors.grey[400]!,
                width: 2,
              ),
              color: _termsAccepted ? AppThemes.bgBtnColor : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: _termsAccepted
                ? const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
              children: [
                const TextSpan(text: 'By continuing, I agree to fixtek '),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to terms & conditions page
                      // TODO: Implement navigation
                    },
                    child: const Text(
                      'TERMS & CONDITIONS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
