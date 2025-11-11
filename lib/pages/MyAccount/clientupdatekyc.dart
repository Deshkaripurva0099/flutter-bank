import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:camera_camera/camera_camera.dart';

class UpdateKYC extends StatefulWidget {
  const UpdateKYC({super.key});

  @override
  State<UpdateKYC> createState() => _UpdateKYCState();
}

class _UpdateKYCState extends State<UpdateKYC> {
  int step = 1;
  String choice = "customerId";
  String customerId = "";
  String panNumber = "";
  String accountNumber = "";
  String verificationAnswer = "";
  String otp = "";
  String? photoPath;
  bool success = false;
  String error = "";
  int captchaNum1 = 0;
  int captchaNum2 = 0;

  final SignatureController _sigController = SignatureController(penStrokeWidth: 2, penColor: Colors.black);

  @override
  void initState() {
    super.initState();
    _generateCaptcha();
  }

  void _generateCaptcha() {
    setState(() {
      captchaNum1 = (1 + (10 * (UniqueKey().hashCode % 9)).abs());
      captchaNum2 = (1 + (10 * (UniqueKey().hashCode % 9)).abs());
    });
  }

  String getSelectedValue() {
    switch (choice) {
      case "customerId":
        return customerId;
      case "panNumber":
        return panNumber;
      default:
        return accountNumber;
    }
  }

  void handleStep1Submit() {
    if (getSelectedValue().isEmpty) {
      setState(() => error = "Please enter a value.");
      return;
    }
    if (int.tryParse(verificationAnswer) != captchaNum1 * captchaNum2) {
      setState(() {
        error = "Captcha answer is incorrect.";
        verificationAnswer = "";
      });
      _generateCaptcha();
      return;
    }
    setState(() {
      error = "";
      step = 2;
    });
  }

  void handleStep2Submit() {
    if (otp != "123456") {
      setState(() => error = "Incorrect OTP.");
      return;
    }
    setState(() {
      error = "";
      step = 3;
    });
  }

  void handleFinalSubmit() async {
    if (photoPath == null) {
      setState(() => error = "Please capture a photo.");
      return;
    }
    if (_sigController.isEmpty) {
      setState(() => error = "Please draw your signature.");
      return;
    }
    setState(() {
      error = "";
      success = true;
    });
  }

  void resetForm() {
    setState(() {
      step = 1;
      choice = "customerId";
      customerId = "";
      panNumber = "";
      accountNumber = "";
      verificationAnswer = "";
      otp = "";
      photoPath = null;
      success = false;
      error = "";
      _sigController.clear();
    });
    _generateCaptcha();
  }

  Future<void> capturePhoto() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraCamera(
          onFile: (file) {
            setState(() => photoPath = file.path);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 900,
          height: 600,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration( 
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            color: Colors.white,
          ),
          child: Row(
            children: [
              // 🔴 Left Branding
              Expanded(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF900603),
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/neobank-white.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.account_balance, 
                              color: Colors.white,
                              size: 40
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text("Neo Bank KYC",
                      textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 8),
                      const Text("Securely complete your account verification",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white70)),
                    ],
                  ),
                ),
              ),

              // ⚪ Right Form
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: success
                      ? _buildSuccess()
                      : step == 1
                          ? _buildStep1()
                          : step == 2
                              ? _buildStep2()
                              : _buildStep3(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Step 1 UI
  Widget _buildStep1() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF900603), width: 2),
              ),
              child: const Text("← Back", style: TextStyle(color: Color(0xFF900603))),
            ),
          ),
          const Text("KYC Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF900603))),
          const SizedBox(height: 20),
          
          // Radio Options
          for (var type in ["customerId", "panNumber", "accountNumber"])
            RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                type == "customerId"
                    ? "Customer ID"
                    : type == "panNumber"
                        ? "PAN Number"
                        : "Account Number",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              value: type,
              groupValue: choice,
              onChanged: (val) => setState(() => choice = val!),
            ),
          
          const SizedBox(height: 10),
          
          // Input Field
          TextField(
            decoration: InputDecoration(
              hintText: "Enter your ${choice == "customerId" ? "Customer ID" : choice == "panNumber" ? "PAN Number" : "Account Number"}",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF900603), width: 2.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            onChanged: (val) {
              setState(() {
                if (choice == "customerId") customerId = val;
                if (choice == "panNumber") panNumber = val;
                if (choice == "accountNumber") accountNumber = val;
              });
            },
          ),
          
          const SizedBox(height: 20),
          
          // Captcha Section
          Text("What is the value of $captchaNum1 × $captchaNum2?",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          
          // Captcha Input Field
          TextField(
            decoration: InputDecoration(
              hintText: "Enter Answer",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF900603), width: 2.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            onChanged: (val) => verificationAnswer = val,
          ),
          
          if (error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 14)),
            ),
          
          const SizedBox(height: 20),
          
          // Verify Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: handleStep1Submit,
              child: const Text("Verify & Send OTP", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Step 2 UI - WITH NEAT AND CLEAN BUTTONS
  Widget _buildStep2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Enter OTP",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF900603))),
          const SizedBox(height: 15),
          
          // OTP Input Field
          TextField(
            decoration: InputDecoration(
              hintText: "Enter OTP (Use 123456)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF900603), width: 2.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            onChanged: (val) => otp = val,
          ),
          
          const SizedBox(height: 20),
          
          // Buttons Row - NEAT AND CLEAN
          Row(
            children: [
              // Resend OTP Button
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF900603),
                      width: 1.5,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("OTP resent: 123456"),
                        duration: Duration(seconds: 2),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF900603),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Resend OTP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Cancel Button
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  child: TextButton(
                    onPressed: resetForm,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          if (error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                error, 
                style: const TextStyle(color: Colors.red, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          
          const SizedBox(height: 25),
          
          // Verify OTP Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              onPressed: handleStep2Submit,
              child: const Text(
                "Verify OTP", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Step 3 UI
  Widget _buildStep3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Capture Photo & Signature",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF900603))),
          const SizedBox(height: 20),
          
          const Text("Take Photo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          
          photoPath == null
              ? SizedBox(
                  width: double.infinity,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1.5,
                      ),
                    ),
                    child: TextButton.icon(
                      onPressed: capturePhoto,
                      icon: const Icon(Icons.camera_alt, size: 20),
                      label: const Text(
                        "Capture Photo",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(photoPath!), 
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
          
          const SizedBox(height: 25),
          
          const Text("Draw Signature", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400, width: 1.0),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[50],
            ),
            height: 120,
            width: double.infinity,
            child: Signature(controller: _sigController, backgroundColor: const Color.fromRGBO(250, 250, 250, 1)),
          ),
          
          const SizedBox(height: 10),
          
          SizedBox(
            width: double.infinity,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
              child: TextButton(
                onPressed: () => _sigController.clear(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Clear Signature",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          
          if (error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 14)),
            ),
          
          const SizedBox(height: 25),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              onPressed: handleFinalSubmit,
              child: const Text(
                "Submit KYC", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Success Screen
  Widget _buildSuccess() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 80),
          const SizedBox(height: 15),
          const Text("KYC Completed Successfully!",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 10),
          const Text("Your KYC verification has been completed successfully.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 25),
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1.5,
              ),
            ),
            child: TextButton(
              onPressed: resetForm,
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Start New KYC",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}