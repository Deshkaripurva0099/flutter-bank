import 'package:flutter/material.dart';
import 'panscreen_style.dart';
import 'account_type_screen.dart';

class PANScreen extends StatefulWidget {
  final Function(String step)? setCurrentStep;
  final Function(Map<String, dynamic> data)? updateUserData;

  const PANScreen({super.key, this.setCurrentStep, this.updateUserData});

  @override
  State<PANScreen> createState() => _PANScreenState();
}

class _PANScreenState extends State<PANScreen> {
  final TextEditingController _panController = TextEditingController();

  void handleSubmit() {
    widget.updateUserData?.call({
      'panNumber': _panController.text.toUpperCase(),
    });
    // Navigate to AccountTypeScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AccountTypeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ===================== Container =====================
        decoration: BoxDecoration(gradient: PANScreenStyle.containerGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                // ===================== Back Button =====================
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Text("←", style: PANScreenStyle.backArrowStyle),
                    label: Text(
                      "Back",
                      style: PANScreenStyle.backButtonTextStyle,
                    ),
                  ),
                ),

                // ===================== Card =====================
                Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 32,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: PANScreenStyle.cardBoxDecoration,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ===================== Icon =====================
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Text("📄", style: PANScreenStyle.iconStyle),
                          ),

                          // ===================== Header =====================
                          Container(
                            margin: const EdgeInsets.only(bottom: 32),
                            child: Column(
                              children: [
                                Text(
                                  "Verify PAN",
                                  style: PANScreenStyle.titleStyle,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Enter your PAN card number",
                                  style: PANScreenStyle.subtitleStyle,
                                ),
                              ],
                            ),
                          ),

                          // ===================== Form =====================
                          Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ---------- Input ----------
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "PAN Number",
                                      style: PANScreenStyle.labelStyle,
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: _panController,
                                      keyboardType: TextInputType.text,
                                      maxLength: 10,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      style: PANScreenStyle.inputTextStyle,
                                      decoration: PANScreenStyle.inputDecoration
                                          .copyWith(
                                            counterText: "",
                                            hintText: "ABCDE1234F",
                                            hintStyle: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 16,
                                            ),
                                          ),
                                      onChanged: (value) {
                                        _panController.text = value
                                            .toUpperCase();
                                        _panController.selection =
                                            TextSelection.fromPosition(
                                              TextPosition(
                                                offset:
                                                    _panController.text.length,
                                              ),
                                            );
                                      },
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Format: 5 letters, 4 numbers, 1 letter",
                                      style: PANScreenStyle.formatNoteStyle,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                // ---------- Info Box ----------
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: PANScreenStyle.infoBoxDecoration,
                                  child: Text(
                                    "We'll verify your PAN details with Income Tax Department records",
                                    style: PANScreenStyle.infoTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // ---------- Verify Button ----------
                                ElevatedButton.icon(
                                  onPressed: handleSubmit,
                                  style: PANScreenStyle.verifyButtonStyle,
                                  icon: Text(
                                    "Verify PAN",
                                    style: PANScreenStyle.verifyButtonTextStyle,
                                  ),
                                  label: Text(
                                    "→",
                                    style: PANScreenStyle.arrowIconStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
