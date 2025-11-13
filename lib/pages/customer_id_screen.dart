import 'package:flutter/material.dart';
import 'dart:math';
import 'customer_id_style.dart';
import 'update_kyc33_screen.dart';

class CustomerIDScreen extends StatefulWidget {
  const CustomerIDScreen({super.key});

  @override
  State<CustomerIDScreen> createState() => _CustomerIDScreenState();
}

class _CustomerIDScreenState extends State<CustomerIDScreen> {
  String customerId = '';

  @override
  void initState() {
    super.initState();
    // ✅ Always generate a new unique ID (equivalent to useEffect)
    final random = Random();
    final uniqueId = 'CUST${10000000 + random.nextInt(90000000)}';
    setState(() {
      customerId = uniqueId;
    });
    debugPrint('Generated Customer ID: $uniqueId');
    // updateUserData({ "customerId": uniqueId }); // mimic context call
  }

  // ✅ Proceed to KYC
  void handleProceed() {
    debugPrint("Navigating to step: updateKYC33");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UpdateKYC33Screen(customerId: customerId),
      ),
    );
  }

  // ✅ Back to Account Type
  void handleBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: CustomerIDStyle.containerGradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: CustomerIDStyle.cardPadding,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ✅ Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: handleBack,
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        label: Text(
                          "Back",
                          style: CustomerIDStyle.defaultFont.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ✅ Card
                    Container(
                      decoration: CustomerIDStyle.cardDecoration,
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 350),
                      child: Column(
                        children: [
                          // Logo
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: CustomerIDStyle.logoDecoration,
                            child: Text("💳", style: CustomerIDStyle.logoIcon),
                          ),

                          const SizedBox(height: 20),

                          // Title
                          Text(
                            "Your Customer ID is Ready!",
                            textAlign: TextAlign.center,
                            style: CustomerIDStyle.welcomeTitle,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "Use this unique ID for your KYC and account login.",
                            textAlign: TextAlign.center,
                            style: CustomerIDStyle.welcomeSubtitle,
                          ),

                          const SizedBox(height: 30),

                          // ✅ Customer ID Box
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: CustomerIDStyle.customerIdBoxDecoration,
                            child: Column(
                              children: [
                                Text(
                                  "Customer ID",
                                  style: CustomerIDStyle.customerIdLabel,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  customerId,
                                  style: CustomerIDStyle.generatedId,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "Please save this ID safely. You’ll need it to complete your KYC.",
                            textAlign: TextAlign.center,
                            style: CustomerIDStyle.idInfo,
                          ),

                          const SizedBox(height: 30),

                          // ✅ Proceed Button
                          Container(
                            decoration: CustomerIDStyle.buttonDecoration,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: handleProceed,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Proceed to KYC",
                                    style: CustomerIDStyle.buttonText,
                                  ),
                                  const SizedBox(width: 6),
                                  Text("→", style: CustomerIDStyle.arrowIcon),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          Text(
                            "Powered by Stoic Neobank • Secure Digital Banking",
                            textAlign: TextAlign.center,
                            style: CustomerIDStyle.footerText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
