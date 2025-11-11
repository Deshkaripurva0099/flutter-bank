import 'dart:math';
import 'package:flutter/material.dart';

class AccountStatement extends StatefulWidget {
  const AccountStatement({super.key});

  @override
  State<AccountStatement> createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement> {
  int step = 1;
  String captcha = "";
  String enteredCaptcha = "";
  String statementType = "Request for statement";
  String period = "";
  String? fromDate;
  String? toDate;

  final Color primaryRed = const Color(0xFF900603);
  final TextEditingController accountController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateCaptcha();
  }

  void generateCaptcha() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    setState(() {
      captcha = List.generate(6, (_) => chars[rand.nextInt(chars.length)]).join();
      enteredCaptcha = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 900,
            height: 530,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 2))
              ],
            ),
            child: Column(
              children: [
                // Top Section - Red Background
                Container(
                  height: 80, // Reduced height since steps are removed
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryRed,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      // Bank Image - Directly on red background
                      Container(
                        width: 60,
                        height: 60,
                        child: Image.asset(
                          'assets/neobank-white.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.account_balance,
                              color: Colors.white,
                              size: 30,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Neo Bank Account Statement",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 3),
                            const Text(
                              "Follow these steps to download your account statement",
                              style: TextStyle(color: Colors.white70, fontSize: 10),
                            ),
                            // Steps removed from here - only progress bar remains below
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom Section - White Background
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        _buildStepperHeader(), // This is the progress bar that remains
                        const SizedBox(height: 12),
                        Expanded(
                          child: SingleChildScrollView(
                            child: _buildCurrentStep(),
                          ),
                        ),
                      ],
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

  Widget _buildStepperHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStepCircle(1, "Account\nVerification"),
          _buildStepCircle(2, "OTP\nVerification"),
          _buildStepCircle(3, "Request\nStatement"),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int stepNumber, String title) {
    bool isActive = step >= stepNumber;
    bool isCompleted = step > stepNumber;
    
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isActive ? primaryRed : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted 
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : Text(
                    '$stepNumber',
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: TextStyle(
            color: isActive ? primaryRed : Colors.grey,
            fontSize: 9,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (step) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      default:
        return _buildStep1();
    }
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Step 1: Account Verification",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        
        // Account Number
        const Text(
          "Account Number",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: accountController,
          decoration: const InputDecoration(
            hintText: "Enter Account Number",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Captcha Section
        const Text(
          "Enter Captcha",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Enter Captcha",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                ),
                onChanged: (v) => setState(() => enteredCaptcha = v.toUpperCase()),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 90,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey.shade100,
              ),
              alignment: Alignment.center,
              child: Text(
                captcha,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: primaryRed,
                ),
              ),
            ),
            const SizedBox(width: 6),
            ElevatedButton(
              onPressed: generateCaptcha,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: primaryRed),
                foregroundColor: primaryRed,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              child: const Text("Refresh", style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        
        const SizedBox(height: 15),
        
        // Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primaryRed),
                foregroundColor: primaryRed,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              ),
              child: const Text("Back", style: TextStyle(fontSize: 12)),
            ),
            ElevatedButton(
              onPressed: enteredCaptcha == captcha && accountController.text.isNotEmpty
                  ? () => setState(() => step = 2)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              ),
              child: const Text("Next", style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Step 2: OTP Verification",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        
        Text(
          "An OTP has been sent to your registered mobile number: +91xxxxxx389",
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
          ),
        ),
        
        const SizedBox(height: 12),
        
        const Text(
          "Enter OTP",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: otpController,
          decoration: const InputDecoration(
            hintText: "Enter OTP (use 123456)",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          ),
          keyboardType: TextInputType.number,
          maxLength: 6,
          onChanged: (value) {
            setState(() {}); // Refresh UI to update button state
          },
        ),
        
        const SizedBox(height: 15),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () => setState(() => step = 1),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primaryRed),
                foregroundColor: primaryRed,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              ),
              child: const Text("Back", style: TextStyle(fontSize: 12)),
            ),
            ElevatedButton(
              onPressed: otpController.text == "123456"
                  ? () => setState(() => step = 3)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              ),
              child: const Text("Next", style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Step 3: Request Account Statement",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        
        // Account Information
        const Text(
          "Account Information",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            SizedBox(
              width: 170,
              child: _readonlyField("Account Holder", "AMITxxxxPUT"),
            ),
            SizedBox(
              width: 170,
              child: _readonlyField("Account Number", "1937xxxx850"),
            ),
            SizedBox(
              width: 170,
              child: _readonlyField("Mobile", "+91xxxxxx389"),
            ),
            SizedBox(
              width: 170,
              child: _readonlyField("Email", "na@nxxxx.na"),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        _readonlyField("Address", "GALIxxxxRDA"),
        
        const SizedBox(height: 12),
        
        // Date Range
        const Text(
          "Select Date Range",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        
        Row(
          children: [
            Expanded(
              child: _dateField(
                label: "From Date", 
                hint: fromDate ?? "Select Date", 
                onDateSelected: (date) {
                  setState(() => fromDate = "${date.day}/${date.month}/${date.year}");
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _dateField(
                label: "To Date", 
                hint: toDate ?? "Select Date", 
                onDateSelected: (date) {
                  setState(() => toDate = "${date.day}/${date.month}/${date.year}");
                },
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Statement Type
        _dropdown(
          label: "Statement Type",
          value: statementType,
          items: [
            "Request for statement",
            "Request for interest certificate",
            "Request for TDS certificate"
          ],
          onChanged: (v) => setState(() => statementType = v!),
        ),
        
        const SizedBox(height: 15),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () => setState(() => step = 2),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primaryRed),
                foregroundColor: primaryRed,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              ),
              child: const Text("Back", style: TextStyle(fontSize: 12)),
            ),
            ElevatedButton(
              onPressed: () {
                if (statementType == "Request for statement" && (fromDate == null || toDate == null)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select date range")),
                  );
                  return;
                }
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Request submitted successfully!")),
                );
                
                // Reset form
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    step = 1;
                    generateCaptcha();
                    statementType = "Request for statement";
                    period = "";
                    enteredCaptcha = "";
                    fromDate = null;
                    toDate = null;
                    accountController.clear();
                    otpController.clear();
                  });
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              ),
              child: const Text("Submit", style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _readonlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 3),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: value,
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          ),
        ),
      ],
    );
  }

  Widget _dateField({
    required String label,
    required String hint,
    required Function(DateTime) onDateSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 3),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
            );
            if (picked != null) {
              onDateSelected(picked);
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    hint,
                    style: TextStyle(
                      color: hint.contains("Select") ? Colors.grey : Colors.black,
                      fontSize: 11,
                    ),
                  ),
                ),
                Icon(Icons.calendar_today, color: primaryRed, size: 14),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 3),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 11)))).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    accountController.dispose();
    otpController.dispose();
    super.dispose();
  }
}