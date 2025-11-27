import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:fixteck/const/fixtec_btn.dart';
import 'package:fixteck/const/themes/app_themes.dart';
import 'package:fixteck/ui/bookings/service/service_page.dart';
import 'package:flutter/material.dart';

class SelectDateAndTimePage extends StatefulWidget {
  const SelectDateAndTimePage({super.key});

  @override
  State<SelectDateAndTimePage> createState() => _SelectDateAndTimePageState();
}

class _SelectDateAndTimePageState extends State<SelectDateAndTimePage> {
  DateTime _selectedDate = DateTime.now();
  int _selectedTimeSlotIndex = 0;

  final List<String> _timeSlots = [
    '02:00 PM\n04:00 PM',
    '04:00 PM\n06:00 PM',
    '06:00 PM\n08:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Select Date & Time',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildDateSelector(),
          const SizedBox(height: 24),
          _buildTimeSlotSelector(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
        child: FixtecBtn(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ServicePage()),
            );
          },
          bgColor: AppThemes.bgBtnColor,
          textColor: AppThemes.textBtnColor,
          child: const Text("Reschedule"),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: DatePicker(
        DateTime.now(),
        height: 80,
        initialSelectedDate: _selectedDate,
        selectionColor: const Color(0xFFD9D9D9),
        selectedTextColor: const Color(0xFF003B4D),
        dateTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
        dayTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
        monthTextStyle: const TextStyle(
          fontSize: 0,
          fontWeight: FontWeight.w500,
          color: Colors.transparent,
        ),
        deactivatedColor: Colors.white,
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  Widget _buildTimeSlotSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_timeSlots.length, (index) {
          final isSelected = index == _selectedTimeSlotIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeSlotIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0), // Light grey for unselected
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(color: const Color(0xFF003B4D), width: 1)
                    : null,
              ),
              child: Text(
                _timeSlots[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
