// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:neobank/widgets/layout.dart';
import 'package:neobank/widgets/topbar.dart';
import 'package:signature/signature.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateKYCPage extends StatefulWidget {
  const UpdateKYCPage({super.key});

  @override
  State<UpdateKYCPage> createState() => _UpdateKYCPageState();
}

class _UpdateKYCPageState extends State<UpdateKYCPage> {
  int step = 1;
  String choice = "customerId";
  String customerId = "";
  String panNumber = "";
  String accountNumber = "";
  String verificationAnswer = "";
  String otp = "";
  File? photo;
  String error = "";
  bool success = false;

  int captchaNum1 = 0;
  int captchaNum2 = 0;

  final SignatureController sigController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    generateCaptcha();
  }

  void generateCaptcha() {
    setState(() {
      captchaNum1 =
          (1 + (9 * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000))
              .toInt();
      captchaNum2 =
          (1 + (9 * (DateTime.now().millisecondsSinceEpoch % 500) / 500))
              .toInt();
    });
  }

  String getSelectedValue() {
    if (choice == "customerId") return customerId;
    if (choice == "panNumber") return panNumber;
    return accountNumber;
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
      generateCaptcha();
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

  Future<void> pickPhoto() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        photo = File(image.path);
      });
    }
  }

  void handleFinalSubmit() async {
    if (photo == null) {
      setState(() => error = "Please capture a photo.");
      return;
    }
    if (sigController.isEmpty) {
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
      photo = null;
      sigController.clear();
      error = "";
      success = false;
      generateCaptcha();
    });
  }

  @override
  Widget build(BuildContext context) {
    final leftPanel = Container(
      color: const Color(0xFF900603),
      padding: const EdgeInsets.all(40),
      width: MediaQuery.of(context).size.width > 768
          ? MediaQuery.of(context).size.width * 0.35
          : double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png', height: 80),
          const SizedBox(height: 20),
          const Text(
            "Neo Bank KYC",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            "Securely complete your account verification in simple steps",
            style: TextStyle(color: Colors.white70, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    final rightPanel = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: !success
              ? Column(
                  children: [
                    // Back button
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: OutlinedButton(
                    //     onPressed: () => Navigator.pop(context),
                    //     style: OutlinedButton.styleFrom(
                    //       foregroundColor: const Color(0xFF900603),
                    //       side: const BorderSide(color: Color(0xFF900603)),
                    //     ),
                    //     child: const Text("← Back"),
                    //   ),
                    // ),
                    const SizedBox(height: 20),

                    if (step == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "KYC Verification",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF900603),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              RadioListTile(
                                title: const Text("Customer ID"),
                                value: "customerId",
                                groupValue: choice,
                                onChanged: (val) =>
                                    setState(() => choice = val.toString()),
                              ),
                              RadioListTile(
                                title: const Text("PAN Number"),
                                value: "panNumber",
                                groupValue: choice,
                                onChanged: (val) =>
                                    setState(() => choice = val.toString()),
                              ),
                              RadioListTile(
                                title: const Text("Account Number"),
                                value: "accountNumber",
                                groupValue: choice,
                                onChanged: (val) =>
                                    setState(() => choice = val.toString()),
                              ),
                            ],
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText:
                                  "Enter your ${choice == 'customerId'
                                      ? 'Customer ID'
                                      : choice == 'panNumber'
                                      ? 'PAN Number'
                                      : 'Account Number'}",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (val) {
                              if (choice == "customerId") customerId = val;
                              if (choice == "panNumber") panNumber = val;
                              if (choice == "accountNumber") {
                                accountNumber = val;
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "What is the value of $captchaNum1 × $captchaNum2?",
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Answer",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (val) => verificationAnswer = val,
                          ),
                          if (error.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                error,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: handleStep1Submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF900603),
                              foregroundColor: Colors.white, // text color
                              minimumSize: const Size.fromHeight(50),
                            ),

                            child: const Text("Verify & Send OTP"),
                          ),
                        ],
                      ),
                    if (step == 2)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Enter OTP",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE60000),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter OTP (Use 123456)",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (val) => otp = val,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: () =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("OTP resent: 123456"),
                                      ),
                                    ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.orange,
                                  side: const BorderSide(color: Colors.orange),
                                ),
                                child: const Text("Resend OTP"),
                              ),
                              const SizedBox(width: 10),
                              OutlinedButton(
                                onPressed: resetForm,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                ),
                                child: const Text("Cancel"),
                              ),
                            ],
                          ),
                          if (error.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                error,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: handleStep2Submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF900603),
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: const Text("Verify OTP"),
                          ),
                        ],
                      ),
                    if (step == 3)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Capture Photo & Signature",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE60000),
                            ),
                          ),
                          const SizedBox(height: 12),
                          photo == null
                              ? ElevatedButton(
                                  onPressed: pickPhoto,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.green,
                                    minimumSize: const Size.fromHeight(50),
                                  ),
                                  child: const Text("Capture Photo"),
                                )
                              : Image.file(photo!, height: 200),
                          const SizedBox(height: 12),
                          const Text("Draw Signature"),
                          Signature(
                            controller: sigController,
                            height: 100,
                            backgroundColor: Colors.grey[200]!,
                          ),
                          OutlinedButton(
                            onPressed: () => sigController.clear(),
                            child: const Text("Clear Signature"),
                          ),
                          if (error.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                error,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: handleFinalSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,

                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: const Text("Submit KYC"),
                          ),
                        ],
                      ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 60,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "✅ KYC completed successfully!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: resetForm,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                      ),
                      child: const Text("Start New KYC"),
                    ),
                  ],
                ),
        ),
      ),
    );

    return AppLayout(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            // Wide screens: side-by-side panels
            return Row(
              children: [
                Expanded(child: leftPanel),
                Expanded(child: rightPanel),
              ],
            );
          } else {
            // Narrow screens: stacked panels
            return Column(children: [leftPanel, rightPanel]);
          }
        },
      ),
    );
  }
}
