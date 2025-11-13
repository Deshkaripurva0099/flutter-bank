import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signupscreen_style.dart'; // ✅ Import style file
import 'aadhar_screen.dart'; // Import AadharScreen

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  String fullName = '';
  String email = '';
  String mobileNumber = '';

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint(
        'Form Data: { fullName: $fullName, email: $email, mobileNumber: $mobileNumber }',
      );
      // Navigate to AadharScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AadharScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: SignupScreenStyle.containerGradient,
        ),
        child: Column(
          children: [
            // 🔹 Back Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white;
                          }
                          return const Color(0xFF900603);
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.black;
                          }
                          return Colors.white;
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('← Back'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    // 🔹 Card
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 400),
                      decoration: SignupScreenStyle.cardDecoration,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header
                          Column(
                            children: [
                              Text(
                                "Create Account",
                                style: SignupScreenStyle.titleText.copyWith(
                                  fontSize:
                                      SignupScreenStyle.responsiveTitleFont(
                                        screenWidth,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Enter your details to get started",
                                style: SignupScreenStyle.subtitleText.copyWith(
                                  fontSize:
                                      SignupScreenStyle.responsiveSubtitleFont(
                                        screenWidth,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // =================== Form ===================
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Full Name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Full Name",
                                      style: SignupScreenStyle.labelText,
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Z\s]'),
                                        ),
                                      ],
                                      decoration: SignupScreenStyle
                                          .inputDecoration
                                          .copyWith(
                                            hintText: "Enter your full name",
                                          ),
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'Required';
                                        }
                                        if (!RegExp(
                                          r'^[a-zA-Z\s]+$',
                                        ).hasMatch(v)) {
                                          return 'Only letters and spaces allowed';
                                        }
                                        return null;
                                      },
                                      onSaved: (v) => fullName = v ?? '',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Email
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Email Address",
                                      style: SignupScreenStyle.labelText,
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      decoration: SignupScreenStyle
                                          .inputDecoration
                                          .copyWith(
                                            hintText: "your.email@example.com",
                                          ),
                                      validator: (v) => v == null || v.isEmpty
                                          ? 'Required'
                                          : null,
                                      onSaved: (v) => email = v ?? '',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Mobile Number
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Mobile Number",
                                      style: SignupScreenStyle.labelText,
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      keyboardType: TextInputType.phone,
                                      maxLength: 10,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: SignupScreenStyle
                                          .inputDecoration
                                          .copyWith(hintText: "+91 XXXXXXXXXX"),
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'Required';
                                        }
                                        if (v.length != 10) {
                                          return 'Mobile number must be exactly 10 digits';
                                        }
                                        return null;
                                      },
                                      onSaved: (v) => mobileNumber = v ?? '',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // Continue Button
                                ElevatedButton(
                                  onPressed: handleSubmit,
                                  style: SignupScreenStyle.continueButton,
                                  child: const Text("Continue →"),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            "By continuing, you agree to our Terms of Service and Privacy Policy",
                            textAlign: TextAlign.center,
                            style: SignupScreenStyle.termsText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
