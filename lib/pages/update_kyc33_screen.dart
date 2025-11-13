import 'package:flutter/material.dart';
import 'dart:async';
import 'update_kyc33_style.dart';

class UpdateKYC33Screen extends StatefulWidget {
  final String? customerId;

  const UpdateKYC33Screen({super.key, this.customerId});

  @override
  State<UpdateKYC33Screen> createState() => _UpdateKYC33ScreenState();
}

class _UpdateKYC33ScreenState extends State<UpdateKYC33Screen>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  String customerId = '';
  String otp = '';
  bool isOTPSent = false;
  bool isVideoRecorded = false;
  bool isPhotoUploaded = false;
  bool isSignatureDone = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
    if (widget.customerId != null) {
      customerId = widget.customerId!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
      _controller.forward(from: 0);
    }
  }

  void prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _controller.forward(from: 0);
    }
  }

  Widget buildStepContent() {
    switch (_currentStep) {
      case 0:
        return buildCustomerIDStep();
      case 1:
        return buildOTPStep();
      case 2:
        return buildVideoKYCScreen();
      case 3:
        return buildPhotoSignatureStep();
      default:
        return const SizedBox();
    }
  }

  Widget buildCustomerIDStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Enter Customer ID", style: UpdateKYC33Style.titleStyle),
        const SizedBox(height: 16),
        TextField(
          controller: TextEditingController(text: customerId),
          decoration: InputDecoration(
            hintText: 'Enter your customer ID',
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (val) => setState(() => customerId = val),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: customerId.isNotEmpty ? nextStep : null,
          style: UpdateKYC33Style.primaryButtonStyle,
          child: const Text("Send OTP"),
        ),
      ],
    );
  }

  Widget buildOTPStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Enter OTP", style: UpdateKYC33Style.titleStyle),
        const SizedBox(height: 16),
        TextField(
          controller: _otpController,
          decoration: InputDecoration(
            hintText: 'Enter OTP',
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (val) => setState(() => otp = val),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: otp.isNotEmpty ? nextStep : null,
          style: UpdateKYC33Style.primaryButtonStyle,
          child: const Text("Verify OTP"),
        ),
      ],
    );
  }

  Widget buildVideoKYCScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Video KYC", style: UpdateKYC33Style.titleStyle),
        const SizedBox(height: 24),
        Container(
          height: 200,
          width: double.infinity,
          decoration: UpdateKYC33Style.videoBoxDecoration,
          child: const Center(
            child: Icon(Icons.videocam, color: Colors.white70, size: 50),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            setState(() => isVideoRecorded = true);
            nextStep();
          },
          style: UpdateKYC33Style.primaryButtonStyle,
          child: const Text("Record Video"),
        ),
      ],
    );
  }

  Widget buildPhotoSignatureStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Upload Photo & Signature",
          style: UpdateKYC33Style.titleStyle,
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            setState(() => isPhotoUploaded = true);
          },
          icon: const Icon(Icons.photo_camera),
          label: const Text("Upload Photo"),
          style: UpdateKYC33Style.primaryButtonStyle,
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            setState(() => isSignatureDone = true);
          },
          icon: const Icon(Icons.edit),
          label: const Text("Add Signature"),
          style: UpdateKYC33Style.primaryButtonStyle,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: (isPhotoUploaded && isSignatureDone) ? () {} : null,
          style: UpdateKYC33Style.primaryButtonStyle,
          child: const Text("Submit KYC"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f172a),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: UpdateKYC33Style.backgroundGradient,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: UpdateKYC33Style.cardDecoration,
                    padding: UpdateKYC33Style.cardPadding,
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Text(
                                "←",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              label: const Text(
                                "Back",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Step ${_currentStep + 1} of 4",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        buildStepContent(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
