import 'package:flutter/material.dart';
import 'pan_verification_form.dart';

class AadharVerificationForm extends StatefulWidget {
  const AadharVerificationForm({super.key});

  @override
  State<AadharVerificationForm> createState() => _AadharVerificationFormState();
}

class _AadharVerificationFormState extends State<AadharVerificationForm> {
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;

  bool _isAadharValid() {
    return _aadharController.text.trim().length == 12;
  }

  bool _isOtpValid() {
    return _otpController.text.trim().isNotEmpty;
  }

  @override
  void dispose() {
    _aadharController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/neobank_logo.png', // Assuming a logo asset exists
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "NeoBank Account Open",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 148, 12, 3),
                    ),
                  ),
                  const Text(
                    "Complete your account setup in easy steps",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStepIndicator(1, "Personal", false),
                        _buildConnector(true), // Active for step 1-2
                        _buildStepIndicator(2, "Aadhar", true),
                        _buildConnector(false),
                        _buildStepIndicator(3, "PAN", false),
                        _buildConnector(false),
                        _buildStepIndicator(4, "Video KYC", false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Aadhar Verification",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    "Aadhar Number",
                    "Enter your 12-digit Aadhar Number",
                    _aadharController,
                    onChanged: (value) => setState(() {}),
                  ),
                  const SizedBox(height: 20),
                  if (_isAadharValid())
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _otpSent = true;
                        });
                        // Handle Send OTP
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 148, 12, 3),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Send OTP"),
                    ),
                  if (_otpSent) ...[
                    const SizedBox(height: 20),
                    _buildTextField(
                      "OTP",
                      "Enter the OTP",
                      _otpController,
                      onChanged: (value) => setState(() {}),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Handle Resend OTP
                          },
                          child: const Text("Resend OTP"),
                        ),
                        ElevatedButton(
                          onPressed: _isOtpValid()
                              ? () {
                                  // Handle Verify OTP
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              148,
                              12,
                              3,
                            ),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text("Verify OTP"),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Back"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            148,
                            12,
                            3,
                          ),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _otpSent && _isOtpValid()
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PanVerificationForm(),
                                  ),
                                );
                              }
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Next"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            148,
                            12,
                            3,
                          ),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int step, String title, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive
              ? const Color.fromARGB(255, 148, 12, 3)
              : Colors.grey.shade300,
          child: Text(
            '$step',
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(bool isActive) {
    return Container(
      width: 20,
      height: 2,
      color: isActive
          ? const Color.fromARGB(255, 148, 12, 3)
          : Colors.grey.shade300,
    );
  }
}
