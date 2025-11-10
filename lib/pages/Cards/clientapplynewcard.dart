import 'package:flutter/material.dart';

const Color primaryRed = Color(0xFF950606);
const Color primaryBlue = Color(0xFF007BFF);

class ApplyNewCard extends StatefulWidget {
  const ApplyNewCard({super.key});

  @override
  State<ApplyNewCard> createState() => _ApplyNewCardState();
}

class _ApplyNewCardState extends State<ApplyNewCard> {
  String? selectedCard; // "Credit Card" or "Debit Card"
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    "fullName": TextEditingController(),
    "email": TextEditingController(),
    "phone": TextEditingController(),
    "dob": TextEditingController(),
    "address": TextEditingController(),
    "income": TextEditingController(),
    "employment": TextEditingController(),
    "accountNumber": TextEditingController(),
    "accountType": TextEditingController(),
    "branch": TextEditingController(),
    "cibil": TextEditingController(),
    "pan": TextEditingController(),
    "aadhaar": TextEditingController(),
    "creditLimit": TextEditingController(),
    "existingCard": TextEditingController(),
  };

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("✅ Application submitted for $selectedCard!"),
          backgroundColor: primaryRed,
        ),
      );
      setState(() {
        selectedCard = null;
        _controllers.forEach((_, c) => c.clear());
      });
    }
  }

  void handleCancel() {
    setState(() {
      selectedCard = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: const Text("Apply New Card"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width > 800 ? 600 : double.infinity,
              child: Column(
                children: [
                  Text(
                    selectedCard == null
                        ? "Choose a Card to Apply"
                        : "Apply for $selectedCard",
                    style: const TextStyle(
                      color: primaryRed,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🔸 Choose Card Type
                  if (selectedCard == null)
                    Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        _cardButton("Credit Card", primaryRed),
                        _cardButton("Debit Card", primaryBlue),
                      ],
                    )
                  else
                    _buildForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Choose Button
  Widget _cardButton(String type, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: () => setState(() => selectedCard = type),
      child: Text(
        "Apply for $type",
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  // 🔹 Main Form
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Common Fields
          _inputField("Full Name", "fullName"),
          _inputField("Email", "email", type: TextInputType.emailAddress),
          _inputField("Phone Number", "phone",
              type: TextInputType.phone, validator: _validatePhone),
          _inputField("Date of Birth (YYYY-MM-DD)", "dob"),
          _inputField("Address", "address", maxLines: 3),

          // Conditional Fields
          if (selectedCard == "Debit Card") ..._debitFields(),
          if (selectedCard == "Credit Card") ..._creditFields(),

          const SizedBox(height: 20),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: handleCancel,
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: handleSubmit,
                child: const Text(
                  "Submit",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🔸 Common Input Widget
  Widget _inputField(String label, String name,
      {TextInputType type = TextInputType.text,
      int maxLines = 1,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: _controllers[name],
            keyboardType: type,
            maxLines: maxLines,
            validator: validator ?? (v) {
              if (v == null || v.isEmpty) return "Required";
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  // 🔸 Debit Fields
  List<Widget> _debitFields() {
    return [
      _inputField("Bank Account Number", "accountNumber"),
      _dropdownField("Account Type", "accountType",
          ["Savings", "Current"], "Select Account Type"),
      _inputField("Branch Name", "branch"),
    ];
  }

  // 🔸 Credit Fields
  List<Widget> _creditFields() {
    return [
      _inputField("Annual Income", "income", type: TextInputType.number),
      _dropdownField("Employment Type", "employment",
          ["Salaried", "Self-Employed", "Student", "Retired"], "Select Type"),
      _inputField("PAN Number", "pan"),
      _inputField("Aadhaar Number (Optional)", "aadhaar"),
      _inputField("CIBIL Score", "cibil", type: TextInputType.number),
      _inputField("Credit Limit Required (Optional)", "creditLimit",
          type: TextInputType.number),
      _dropdownField("Existing Credit Card Holder?", "existingCard",
          ["Yes", "No"], "Select Option"),
    ];
  }

  // 🔸 Dropdown widget
  Widget _dropdownField(
      String label, String name, List<String> options, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            value: _controllers[name]!.text.isEmpty
                ? null
                : _controllers[name]!.text,
            items: options
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            hint: Text(hint),
            onChanged: (v) => _controllers[name]!.text = v ?? "",
            validator: (v) {
              if (v == null || v.isEmpty) return "Required";
              return null;
            },
          ),
        ],
      ),
    );
  }

  // 🔸 Validation for phone number
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return "Required";
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Enter 10-digit number";
    }
    return null;
  }
}