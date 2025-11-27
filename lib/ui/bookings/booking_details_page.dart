import 'package:fixteck/const/fixtec_btn.dart';
import 'package:fixteck/const/themes/app_themes.dart';
import 'package:fixteck/ui/bookings/select_date_time_page.dart';
import 'package:flutter/material.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  bool _showCallButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildOrderInfoCard(),
            const SizedBox(height: 16),
            _buildActionButtonsCard(),
            const SizedBox(height: 16),
            _buildOrderDetailsCard(),
          ],
        ),
      ),
      bottomNavigationBar: _showCallButton
          ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
              child: FixtecBtn(
                onPressed: () {},
                bgColor: AppThemes.bgBtnColor,
                textColor: AppThemes.textBtnColor,
                child: Text("Call Now"),
              ),
            )
          : null,
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow('Order ID', '233446788R123TU'),
          const SizedBox(height: 8),
          _buildInfoRow('Service', 'PLUMBER'),
          const SizedBox(height: 8),
          _buildInfoRow('Status', 'Open'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtonsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            Icons.phone_outlined,
            onTap: () {
              setState(() {
                _showCallButton = !_showCallButton;
              });
            },
          ),
          _buildActionButton(
            Icons.access_time,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SelectDateAndTimePage(),
                ),
              );
            },
          ),
          _buildActionButton(Icons.cancel_outlined),
          _buildActionButton(Icons.chat_bubble_outline),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        // decoration: BoxDecoration(
        //   shape: BoxShape.circle,
        //   border: Border.all(color: Colors.grey.shade300),
        // ),
        child: Icon(icon, color: const Color(0xFF003B4D), size: 28),
      ),
    );
  }

  Widget _buildOrderDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.grey, size: 20),
              const SizedBox(width: 12),
              const Text(
                '2025 - 10-28 10:00 AM - 12:00 PM',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'CC-18/1375, Jalal Nagar, Karama 234561, Dubai',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
