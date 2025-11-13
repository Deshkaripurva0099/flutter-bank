import 'package:flutter/material.dart';

// lib/pages/add_goal_page.dart
// Conversion of AddGoal.jsx + AddGoal.css → Flutter (pixel-identical, stateless, responsive)

class AddGoalPage extends StatelessWidget {
  const AddGoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth < 992;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header - corresponds to .add-goal-header in React
            Container(
              width: double.infinity,
              color: const Color(0xFF950606),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: isMobile ? 16 : 24,
                    top: isMobile ? 10 : 0,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        '← Back',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.track_changes,
                          color: Color(0xFFFFD580), size: 28),
                      SizedBox(height: 5),
                      Text(
                        'Add Investment Goal',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Set up a new financial goal to track your progress',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main Section - corresponds to .add-goal-container
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Flex(
                direction: isTablet ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column - goal form (.form-column)
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 15),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: const [
                            Icon(Icons.track_changes,
                                color: Color(0xFFFFD580)),
                            SizedBox(width: 6),
                            Text(
                              'Goal Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          ]),
                          const SizedBox(height: 5),
                          const Text(
                            'Provide information about your investment goal',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 13),
                          ),
                          const SizedBox(height: 15),

                          // Form fields (.form-group)
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildTextField('Goal Name *',
                                  'e.g., Dream House Down Payment'),
                              _buildTextField('Target Amount (₹) *',
                                  'e.g., 2000000',
                                  keyboardType: TextInputType.number),
                              _buildTextField('Current Amount (₹)', 'e.g., 50000',
                                  keyboardType: TextInputType.number),
                              _buildTextField('Target Date *', 'Select Date',
                                  keyboardType: TextInputType.datetime),
                              _buildTextField('Monthly Contribution (₹)',
                                  'e.g., 10000',
                                  keyboardType: TextInputType.number),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Form buttons (.form-buttons)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFF0F0F0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF900603),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Goal Saved (Demo)')),
                                  );
                                },
                                child: const Text('Save Goal',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  // Right column - side info (.info-column)
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        _infoCard(
                          '📊 Goal Summary',
                          'Preview of your investment goal.',
                        ),
                        const SizedBox(height: 12),
                        _infoCard('💡 Investment Tips',
                            '• Start early to benefit from compound interest\n• Review and adjust your goals regularly\n• Diversify your investment portfolio\n• Consider tax-saving investment options'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TextField builder (matches .form-group .input)
  static Widget _buildTextField(String label, String hint,
      {TextInputType keyboardType = TextInputType.text}) {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 4),
          TextField(
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFCCCCCC))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFCCCCCC))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF900603))),
            ),
          ),
        ],
      ),
    );
  }

  // Info Card (matches .info-card)
  static Widget _infoCard(String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 6),
          Text(desc,
              style: const TextStyle(fontSize: 13, color: Colors.black54)),
        ],
      ),
    );
  }
}

