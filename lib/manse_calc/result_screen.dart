import 'package:flutter/material.dart';

import 'model/saju_model.dart';

/// 🌟 ManseResultScrren: Displays detailed Saju data.
class ManseResultScrren extends StatelessWidget {
  final SajuModel sajuData;

  const ManseResultScrren({
    super.key,
    required this.sajuData,
  }); // Added formatting and const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("사주 결과"), // Added const
        centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Added const
        child: Center( // Center the content in the body
          child: SingleChildScrollView( // Make the content scrollable
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center column content vertically
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
              children: [
                // Display each pillar with a clear label and formatting
                _buildPillarText("연주", sajuData.yearZhu),
                const SizedBox(height: 8), // Added const for spacing
                _buildPillarText("월주", sajuData.monthZhu),
                const SizedBox(height: 8), // Added const for spacing
                _buildPillarText("일주", sajuData.dayZhu),
                const SizedBox(height: 8), // Added const for spacing
                _buildPillarText("시주", sajuData.hourZhu),
                const SizedBox(height: 24), // Increased spacing before description

                const Text( // Added const
                  "사주 설명:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline, // Add underline to title
                  ),
                ),
                const SizedBox(height: 8), // Added const for spacing
                Text(
                  sajuData.description,
                  style: const TextStyle(fontSize: 16, height: 1.5), // Added const and line height
                  textAlign: TextAlign.justify, // Justify the description text
                ),
                const SizedBox(height: 24), // Increased spacing before button

                Center( // Center the button
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12), // Added padding
                      textStyle: const TextStyle(fontSize: 16), // Added text style
                    ),
                    child: const Text("닫기"), // Added const
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text widgets for each pillar
  Widget _buildPillarText(String label, String value) {
    return Text(
      "$label: $value",
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}