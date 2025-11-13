import 'package:flutter/material.dart';
import 'aadhar_screen_style.dart';
import 'pan_screen.dart';

class AadharScreen extends StatefulWidget {
  final Function(String step)? setCurrentStep;
  final Function(Map<String, dynamic> data)? updateUserData;

  const AadharScreen({super.key, this.setCurrentStep, this.updateUserData});

  @override
  State<AadharScreen> createState() => _AadharScreenState();
}

class _AadharScreenState extends State<AadharScreen> {
  final TextEditingController _aadharController = TextEditingController();
  List<String> otp = List.filled(6, '');
  bool otpSent = false;

  void handleAadharSubmit() {
    setState(() {
      otpSent = true;
    });
  }

  void handleOtpChange(int index, String value) {
    if (value.length <= 1 && RegExp(r'^\d*$').hasMatch(value)) {
      setState(() {
        otp[index] = value;
      });
      if (value.isNotEmpty && index < 5) {
        FocusScope.of(context).nextFocus();
      }
    }
  }

  void handleVerify() {
    widget.updateUserData?.call({'aadharNumber': _aadharController.text});
    // Navigate to PANScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PANScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AadharScreenStyle.containerGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: AadharScreenStyle.containerPadding,
            child: Stack(
              children: [
                // ===================== Back Button =====================
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Text("←", style: AadharScreenStyle.backButtonArrow),
                    label: Text(
                      "Back",
                      style: AadharScreenStyle.backButtonText,
                    ),
                  ),
                ),

                // ===================== Card =====================
                Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: AadharScreenStyle.cardMaxWidth,
                    ),
                    padding: AadharScreenStyle.cardPadding,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: AadharScreenStyle.cardDecoration,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ===================== Icon =====================
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF900603),
                            ),
                            child: Text(
                              "🆔",
                              style: TextStyle(
                                fontSize: AadharScreenStyle.iconFontSize,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // ===================== Header =====================
                          Text(
                            "Verify Aadhar",
                            style: AadharScreenStyle.headerTitle,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Enter your 12-digit Aadhar number",
                            style: AadharScreenStyle.headerSubtitle,
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: AadharScreenStyle.formGap),

                          // ===================== Form / OTP =====================
                          if (!otpSent) ...[
                            // ---------- Aadhar Form ----------
                            TextField(
                              controller: _aadharController,
                              keyboardType: TextInputType.number,
                              maxLength: 12,
                              decoration: AadharScreenStyle.inputDecoration
                                  .copyWith(
                                    labelText: "Aadhar Number",
                                    hintText: "XXXX XXXX XXXX",
                                  ),
                            ),

                            const SizedBox(height: 16),

                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: AadharScreenStyle.infoBoxDecoration,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "🔒 ",
                                    style: AadharScreenStyle.infoIcon,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Your Aadhar details are encrypted and securely stored. We comply with all UIDAI regulations.",
                                      style: AadharScreenStyle.infoText,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: AadharScreenStyle.formGap),

                            ElevatedButton.icon(
                              onPressed: handleAadharSubmit,
                              style: AadharScreenStyle.primaryButtonStyle,
                              icon: const Text("Send OTP"),
                              label: Text(
                                "→",
                                style: AadharScreenStyle.arrowIcon,
                              ),
                            ),
                          ] else ...[
                            // ---------- OTP Verification ----------
                            Text(
                              "Enter 6-digit OTP sent to your registered mobile",
                              style: AadharScreenStyle.headerSubtitle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                6,
                                (index) => Container(
                                  width: 45,
                                  decoration:
                                      AadharScreenStyle.otpInputDecoration,
                                  child: TextField(
                                    onChanged: (val) =>
                                        handleOtpChange(index, val),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                    ),
                                    style: AadharScreenStyle.otpInputText,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: AadharScreenStyle.formGap),

                            ElevatedButton.icon(
                              onPressed: otp.any((d) => d.isEmpty)
                                  ? null
                                  : handleVerify,
                              style: AadharScreenStyle.primaryButtonStyle,
                              icon: const Text("Verify & Continue"),
                              label: Text(
                                "→",
                                style: AadharScreenStyle.arrowIcon,
                              ),
                            ),

                            const SizedBox(height: 12),

                            TextButton(
                              onPressed: () {
                                setState(() {
                                  otpSent = false;
                                  otp = List.filled(6, '');
                                });
                              },
                              child: Text(
                                "Resend OTP",
                                style: AadharScreenStyle.resendButton,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
