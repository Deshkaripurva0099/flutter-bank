import 'package:flutter/material.dart';
import '../../../widgets/layout.dart'; // ✅ Topbar + Sidebar साठी आवश्यक import

const Color primaryRed = Color(0xFF900603);

class AccountClosure extends StatefulWidget {
  final String accountType;

  const AccountClosure({super.key, required this.accountType});

  @override
  State<AccountClosure> createState() => _AccountClosureState();
}

class _AccountClosureState extends State<AccountClosure> {
  int currentStep = 1;
  bool isSubmitted = false;

  final Map<String, dynamic> formData = {
    "accountType": "",
    "accountNumber": "",
    "confirmAccountNumber": "",
    "fullName": "",
    "mobileNumber": "",
    "email": "",
    "dateOfBirth": "",
    "closureReason": "",
    "otherReason": "",
    "transferAccount": "",
    "transferIfsc": "",
    "transferBankName": "",
    "acknowledgment": false,
  };

  final List<String> closureReasons = [
    "Switching to another bank",
    "No longer needed",
    "Unsatisfactory service",
    "High charges/fees",
    "Moving to different location",
    "Account consolidation",
    "Other",
  ];

  final List<String> accountTypes = ["Savings", "Current", "Salary", "Joint"];

  @override
  void initState() {
    super.initState();
    if (widget.accountType.isNotEmpty) {
      formData["accountType"] = widget.accountType;
    }
  }

  void nextStep() {
    if (currentStep < 4) setState(() => currentStep++);
  }

  void prevStep() {
    if (currentStep > 1) setState(() => currentStep--);
  }

  void handleSubmit() {
    setState(() => isSubmitted = true);
  }

  void resetForm() {
    setState(() {
      isSubmitted = false;
      currentStep = 1;
      formData.updateAll((key, value) => value is bool ? false : "");
      if (widget.accountType.isNotEmpty) {
        formData["accountType"] = widget.accountType;
      }
    });
  }

  String _getLastFourDigits(String accountNumber) {
    if (accountNumber.isEmpty || accountNumber.length < 4) return "****";
    return accountNumber.substring(accountNumber.length - 4);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Wrap Scaffold inside AppLayout to show Topbar + Sidebar
    return AppLayout(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F4F0),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8))
                  ],
                ),
                child: isSubmitted
                    ? _buildSubmittedPage()
                    : _buildFormPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Submitted Success Screen
  Widget _buildSubmittedPage() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 60),
          const SizedBox(height: 20),
          const Text(
            "Account Closure Request Submitted",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            "Your account closure request has been received and is being processed.\nYou'll receive updates via SMS and email.",
            style: TextStyle(color: Colors.grey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _infoBox(
            "Request Details:",
            [
              "Request ID: AC${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
              "Account Number: ****${_getLastFourDigits(formData['accountNumber'])}",
              "Processing Time: 7–10 business days",
              "Status: Under Review"
            ],
            bg: const Color(0xFFFEE2E2),
            color: const Color(0xFFB91C1C),
          ),
          const SizedBox(height: 16),
          _infoBox(
            "Important:",
            [
              "Please ensure all pending transactions are completed and maintain minimum balance until closure is confirmed."
            ],
            bg: const Color(0xFFFEF3C7),
            color: const Color(0xFF78350F),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 18),
                label: const Text("Download Receipt"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: resetForm,
                child: const Text("New Request"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _infoBox(String title, List<String> lines,
      {Color bg = Colors.white, Color color = Colors.black}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: color, fontSize: 15)),
            const SizedBox(height: 8),
            ...lines
                .map((e) => Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(e,
                          style: TextStyle(color: color, fontSize: 13)),
                    ))
                .toList()
          ]),
    );
  }

  Widget _buildFormPage() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: primaryRed,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/neobank-white.png',
                height: 55,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.account_balance,
                      size: 36, color: Colors.white);
                },
              ),
              const SizedBox(height: 6),
              const Text(
                "Neo Bank Account Closure",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Secure and hassle-free account closure process in simple steps",
                style: TextStyle(color: Colors.white70, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildStepper(),
                const SizedBox(height: 24),
                _buildStepContent(),
                const SizedBox(height: 24),
                _buildNavigationButtons(),
                const SizedBox(height: 16),
                const Text(
                  "Need help? Call 1800-XXX-XXXX (24/7 support)",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  // 🔹 Stepper UI
  Widget _buildStepper() {
    final steps = [
      "Account Details",
      "Personal Info", 
      "Closure Details",
      "Review"
    ];

    
     return Column(
    children: [
      // 🔹 Step circles with lines
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final stepNum = index + 1;
          final isActive = currentStep >= stepNum;
          final isCompleted = currentStep > stepNum;

          return Expanded(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Connector line (left)
                    if (index != 0)
                      Positioned(
                        left: 0,
                        right: MediaQuery.of(context).size.width * 0.05,
                        child: Container(
                          height: 3,
                          color: isCompleted ? primaryRed : Colors.grey[300],
                        ),
                      ),
                    // Step Circle
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: isActive ? primaryRed : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isActive ? primaryRed : Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "$stepNum",
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  steps[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isActive ? primaryRed : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    ],
  );
}
  // 🧾 Step Content
  Widget _buildStepContent() {
    switch (currentStep) {
      case 1:
        return _accountInfoStep();
      case 2:
        return _personalInfoStep();
      case 3:
        return _closureDetailsStep();
      case 4:
        return _reviewStep();
      default:
        return const SizedBox.shrink();
    }
  }

  // 🏦 Step 1
  Widget _accountInfoStep() {
    return _formCard(
      "Account Information",
      [
        const SizedBox(height: 8),
        _inputDropdown("Account Type", "accountType", accountTypes),
        const SizedBox(height: 20),
        _inputField("Account Number", "accountNumber"),
        const SizedBox(height: 20),
        _inputField("Confirm Account Number", "confirmAccountNumber"),
        if (formData["confirmAccountNumber"].isNotEmpty &&
            formData["accountNumber"] != formData["confirmAccountNumber"])
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: const Text("⚠ Account numbers do not match",
                style: TextStyle(color: Colors.red, fontSize: 13)),
          ),
        const SizedBox(height: 20),
        _alertBox(
          "Security Notice: Ensure you're on our official website. Never share PIN/OTP here.",
          bg: const Color(0xFFFEE2E2),
          color: const Color(0xFFB91C1C),
        ),
      ],
    );
  }

  // 👤 Step 2
  Widget _personalInfoStep() {
    return _formCard("Personal Information", [
      const SizedBox(height: 8),
      _inputField("Full Name", "fullName"),
      const SizedBox(height: 20),
      _inputField("Mobile Number", "mobileNumber", keyboard: TextInputType.phone),
      const SizedBox(height: 20),
      _inputField("Email", "email", keyboard: TextInputType.emailAddress),
      const SizedBox(height: 20),
      _inputField("Date of Birth", "dateOfBirth", isDate: true),
      const SizedBox(height: 20),
      _alertBox(
        "All information must match bank records. Verification may be required.",
        bg: const Color(0xFFDBEAFE),
        color: const Color(0xFF1E40AF),
      )
    ]);
  }

  // 📄 Step 3
  Widget _closureDetailsStep() {
    return _formCard("Closure Details", [
      const SizedBox(height: 8),
      _inputDropdown("Reason for Account Closure", "closureReason", 
          ["Select Reason", ...closureReasons]),
      if (formData["closureReason"] == "Other")
        Column(
          children: [
            const SizedBox(height: 20),
            _inputField("Please specify", "otherReason", isTextArea: true),
          ],
        ),
      const SizedBox(height: 20),
      const Text("Balance Transfer Details",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      const SizedBox(height: 16),
      _inputField("Transfer to Account Number", "transferAccount"),
      const SizedBox(height: 20),
      _inputField("IFSC Code", "transferIfsc"),
      const SizedBox(height: 20),
      _inputField("Bank Name", "transferBankName"),
    ]);
  }

  // ✅ Step 4
  Widget _reviewStep() {
    return _formCard("Review & Confirmation", [
      const SizedBox(height: 8),
      _reviewBox("Account Details", [
        "Type: ${formData['accountType']}",
        "Number: ****${_getLastFourDigits(formData['accountNumber'])}",
        "Holder: ${formData['fullName']}",
        "Mobile: ${formData['mobileNumber']}",
      ]),
      const SizedBox(height: 16),
      _reviewBox("Closure Details", [
        "Reason: ${formData['closureReason']}",
        if (formData['otherReason'] != "") "Other: ${formData['otherReason']}",
        "Balance Transfer: ${formData['transferBankName']} (****${_getLastFourDigits(formData['transferAccount'])})",
      ]),
      const SizedBox(height: 16),
      _alertBox(
        "• Closure takes 7–10 business days\n• All pending transactions must be cleared\n• Remaining balance will be transferred\n• This action cannot be undone",
        bg: const Color(0xFFFEE2E2),
        color: const Color(0xFFB91C1C),
      ),
      const SizedBox(height: 16),
      CheckboxListTile(
        value: formData["acknowledgment"],
        onChanged: (v) => setState(() => formData["acknowledgment"] = v!),
        title: const Text(
          "I acknowledge all terms and authorize closure",
          style: TextStyle(fontSize: 14),
        ),
        contentPadding: EdgeInsets.zero,
      )
    ]);
  }

  Widget _reviewBox(String title, List items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            const SizedBox(height: 10),
            ...items
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(e, style: const TextStyle(fontSize: 14)),
                    ))
                .toList()
          ]),
    );
  }

  // 🧱 UI Helper Components
  Widget _formCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 6))
          ]),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 18)),
            const SizedBox(height: 16),
            ...children
          ]),
    );
  }

  Widget _alertBox(String text, {Color? bg, Color? color}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: TextStyle(color: color, fontSize: 13)),
    );
  }

  Widget _inputField(String label, String key,
      {bool isTextArea = false,
      bool isDate = false,
      TextInputType? keyboard}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      const SizedBox(height: 8),
      if (isTextArea)
        TextField(
          controller: TextEditingController(text: formData[key]),
          onChanged: (v) => formData[key] = v,
          maxLines: 3,
          decoration: _inputDecoration(),
        )
      else if (isDate)
        TextField(
          controller: TextEditingController(text: formData[key]),
          readOnly: true,
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              setState(() => formData[key] =
                  "${picked.year}-${picked.month}-${picked.day}");
            }
          },
          decoration: _inputDecoration(),
        )
      else
        TextField(
          controller: TextEditingController(text: formData[key]),
          onChanged: (v) => formData[key] = v,
          keyboardType: keyboard,
          decoration: _inputDecoration(),
        ),
    ]);
  }

  Widget _inputDropdown(String label, String key, List<String> items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        value: formData[key].isEmpty ? null : formData[key],
        onChanged: (v) => setState(() => formData[key] = v!),
        decoration: _inputDecoration(),
        hint: const Text("Select"),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      ),
    ]);
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryRed, width: 2)),
    );
  }

  // 🔘 Navigation Buttons
  Widget _buildNavigationButtons() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  if (currentStep == 1) {
                    Navigator.pop(context);
                  } else {
                    prevStep();
                  }
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: primaryRed),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Back", style: TextStyle(fontSize: 15)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: (currentStep == 4)
                    ? (formData["acknowledgment"] == true ? handleSubmit : null)
                    : (formData["accountNumber"] ==
                                formData["confirmAccountNumber"] ||
                            currentStep != 1)
                        ? nextStep
                        : null,
                child: Text(
                  currentStep < 4 ? "Next Step →" : " Submit Request", 
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}