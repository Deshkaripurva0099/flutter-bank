import 'package:flutter/material.dart';
import 'package:neobank/widgets/topbar.dart';

class RtgsFormPage extends StatefulWidget {
  const RtgsFormPage({super.key});

  @override
  State<RtgsFormPage> createState() => _RtgsFormPageState();
}

class _RtgsFormPageState extends State<RtgsFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _beneficiaryController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _confirmAccountController =
      TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  String? _selectedBank;
  bool _submitted = false;

  final List<String> _banks = [
    "HDFC Bank",
    "State Bank of India",
    "ICICI Bank",
    "Axis Bank",
    "Kotak Mahindra Bank",
    "Punjab National Bank",
  ];

  final RegExp _ifscRegex = RegExp(r'^[A-Za-z]{4}0[A-Za-z0-9]{6}$');

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _submitted = true);

      final payload = {
        "beneficiaryName": _beneficiaryController.text.trim(),
        "bankName": _selectedBank,
        "accountNumber": _accountController.text.trim(),
        "ifsc": _ifscController.text.trim().toUpperCase(),
        "amount": double.parse(_amountController.text.trim()),
        "remarks": _remarksController.text.trim(),
        "timestamp": DateTime.now().toIso8601String(),
      };

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("RTGS Initiated"),
          content: Text(
            "Beneficiary: ${payload['beneficiaryName']}\n"
            "Account: ${payload['accountNumber']}\n"
            "IFSC: ${payload['ifsc']}\n"
            "Amount: ₹${payload['amount']}\n"
            "Remarks: ${payload['remarks']}",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _beneficiaryController.dispose();
    _accountController.dispose();
    _confirmAccountController.dispose();
    _ifscController.dispose();
    _amountController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarTop(),
      backgroundColor: const Color(0xFFF8F9FA),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 25,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              constraints: const BoxConstraints(maxWidth: 600),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "RTGS Transfer",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF900603),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Beneficiary Name
                    TextFormField(
                      controller: _beneficiaryController,
                      decoration: const InputDecoration(
                        labelText: "Beneficiary Name",
                        hintText: "e.g. Rajesh Kumar",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Beneficiary name is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Bank Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedBank,
                      items: _banks
                          .map(
                            (bank) => DropdownMenuItem(
                              value: bank,
                              child: Text(bank),
                            ),
                          )
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: "Bank Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onChanged: (value) =>
                          setState(() => _selectedBank = value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bank name is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Account Number & Confirm
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _accountController,
                            decoration: const InputDecoration(
                              labelText: "Account Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Account number is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: _confirmAccountController,
                            decoration: const InputDecoration(
                              labelText: "Confirm Account Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Confirm account is required";
                              } else if (value != _accountController.text) {
                                return "Account numbers do not match";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // IFSC & Amount
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _ifscController,
                            decoration: const InputDecoration(
                              labelText: "IFSC Code",
                              hintText: "e.g. HDFC0AAAA12",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 11,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "IFSC is required";
                              } else if (!_ifscRegex.hasMatch(
                                value.trim().toUpperCase(),
                              )) {
                                return "Invalid IFSC format";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: _amountController,
                            decoration: const InputDecoration(
                              labelText: "Amount (₹2,00,000+)",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Amount is required";
                              } else if (double.tryParse(value.trim()) ==
                                      null ||
                                  double.parse(value.trim()) < 200000) {
                                return "RTGS is for transactions ₹2,00,000 or more";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Remarks (optional)
                    TextFormField(
                      controller: _remarksController,
                      decoration: const InputDecoration(
                        labelText: "Remarks (optional)",
                        hintText: "e.g. Invoice Payment #123",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Submit Button
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _handleSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF900603),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              "Submit RTGS",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Success message
                    if (_submitted)
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4EDDA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "✅ RTGS Transfer submitted successfully!",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF155724)),
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
