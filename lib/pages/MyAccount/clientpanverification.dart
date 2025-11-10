import 'dart:math';
import 'package:flutter/material.dart';

class PANVerificationPage extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const PANVerificationPage({super.key, this.userData});

  @override
  State<PANVerificationPage> createState() => _PANVerificationPageState();
}

class _PANVerificationPageState extends State<PANVerificationPage> {
  final TextEditingController panController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? generatedOtp;
  String message = '';
  Color messageColor = Colors.black;
  bool otpSent = false;

  final Color primaryRed = const Color(0xFF900603);

  void sendOtp() {
    if (panController.text.length == 10) {
      generatedOtp = (100000 + Random().nextInt(900000)).toString();
      otpSent = true;
      message = 'Test OTP sent: $generatedOtp';
      messageColor = Colors.blue;
    } else {
      message = 'Please enter a valid 10-character PAN number.';
      messageColor = Colors.red;
    }
    setState(() {});
  }

  void verifyOtp() {
    if (otpController.text == generatedOtp && otpController.text.isNotEmpty) {
      message = '✅ PAN Verified Successfully!';
      messageColor = Colors.green;
      setState(() {});
      Future.delayed(const Duration(seconds: 1), () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PAN Verification Complete!')),
        );
        Navigator.pushNamed(context, '/videoKYC', arguments: widget.userData);
      });
    } else {
      message = '❌ Incorrect OTP. Please try again.';
      messageColor = Colors.red;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
   // final userData = widget.userData ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: 600,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🏦 Logo
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.account_balance, color: primaryRed, size: 50),
                ),
                const SizedBox(height: 15),

                // Title
                Text(
                  "NeoBank Account Open",
                  style: TextStyle(
                    color: primaryRed,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Complete your account setup in easy steps",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 25),

                // 🧩 Progress Bar
                _buildProgressIndicator(currentStep: 3),
                const SizedBox(height: 30),

                // Section Title
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PAN Verification",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 20),

                // PAN Input
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PAN Number",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: panController,
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: "Enter your PAN Number",
                    counterText: "",
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryRed, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                if (!otpSent)
                  ElevatedButton(
                    onPressed: sendOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Send OTP',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),

                if (otpSent) ...[
                  const SizedBox(height: 10),
                  TextField(
                    controller: otpController,
                    decoration: const InputDecoration(
                      labelText: 'Enter OTP',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  if (message.isNotEmpty)
                    Text(
                      message,
                      style: TextStyle(color: messageColor, fontSize: 14),
                    ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryRed,
                            side: BorderSide(color: primaryRed, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('← Back'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: verifyOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryRed,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Next →'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🧭 Progress Bar Widget (Step 3 Active)
  Widget _buildProgressIndicator({int currentStep = 3}) {
    Color active = primaryRed;
    Color inactive = Colors.grey.shade300;

    Widget buildStep(int step, String label) {
      bool isCompleted = step < currentStep;
      bool isActive = step == currentStep;

      Color circleColor = isActive || isCompleted ? active : inactive;
      Color textColor = isActive || isCompleted ? active : Colors.grey;

      return Column(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: circleColor,
            child: Text(
              "$step",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      );
    }

    Widget buildLine(bool isActive) {
      return Expanded(
        child: Container(
          height: 3,
          color: isActive ? active : inactive,
        ),
      );
    }

    return Row(
      children: [
        buildStep(1, "Personal"),
        buildLine(currentStep > 1),
        buildStep(2, "Aadhar"),
        buildLine(currentStep > 2),
        buildStep(3, "PAN"),
        buildLine(currentStep > 3),
        buildStep(4, "Video KYC"),
      ],
    );
  }
}
