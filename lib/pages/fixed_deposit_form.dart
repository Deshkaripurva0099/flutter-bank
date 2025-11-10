import 'dart:math';
import 'package:flutter/material.dart';
import 'fd_formstyles.dart'; // ✅ style file import

class FixedDepositForm extends StatefulWidget {
  final double? depositAmount;
  final double? tenure;
  final double? interestRate;

  const FixedDepositForm({
    super.key,
    this.depositAmount,
    this.tenure,
    this.interestRate,
  });

  @override
  State<FixedDepositForm> createState() => _FixedDepositFormState();
}

class _FixedDepositFormState extends State<FixedDepositForm> {
  final Map<String, dynamic> data = {};

  late String depositType;
  late double amount;
  late double duration;
  String account = "";
  String stateValue = "";
  String city = "";
  String branch = "";

  final double minAmount = 5000;
  final double maxAmount = 9999999;
  final double minDuration = 6;
  final double maxDuration = 120;

  double interestRate = 0;
  double maturity = 0;

  @override
  void initState() {
    super.initState();

    depositType = data["type"] ?? "Fixed Deposit";
    amount = widget.depositAmount ?? (data["amount"] ?? 5000).toDouble();
    duration = widget.tenure ?? (data["duration"] ?? 6).toDouble();

    double rate = widget.interestRate ?? getInterestRate(duration);
    double maturityValue = (amount * (pow(1 + rate / 100, duration / 12)))
        .roundToDouble();

    interestRate = rate;
    maturity = maturityValue;
  }

  double getInterestRate(double months) {
    if (months >= 6 && months < 12) return 6.4;
    if (months >= 12 && months < 24) return 6.8;
    if (months >= 24 && months < 60) return 7.2;
    if (months >= 60) return 7.5;
    return 6.0;
  }

  void recalculate() {
    if (amount <= 0 || duration <= 0) {
      setState(() {
        interestRate = 0;
        maturity = 0;
      });
      return;
    }
    double rate = getInterestRate(duration);
    double maturityValue = (amount * (pow(1 + rate / 100, duration / 12)))
        .roundToDouble();
    setState(() {
      interestRate = rate;
      maturity = maturityValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FdFormStyles.backgroundColor, // ✅ using form style
      appBar: AppBar(
        backgroundColor: FdFormStyles.appBarColor,
        title: Row(
          children: [
            const Icon(Icons.menu_book),
            const SizedBox(width: 8),
            Text("Open New Fixed Deposit", style: FdFormStyles.titleText),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: FdFormStyles.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (amount > 0 && duration > 0 && maturity > 0)
              Container(
                padding: FdFormStyles.summaryPadding,
                margin: FdFormStyles.summaryMargin,
                decoration: FdFormStyles.summaryBox,
                child: Text(
                  "Summary from Calculator:\nYou selected ₹${amount.toStringAsFixed(0)} "
                  "for ${duration.toInt()} months at ${interestRate.toStringAsFixed(1)}% → "
                  "Expected Maturity: ₹${maturity.toStringAsFixed(0)}",
                  style: FdFormStyles.summaryText,
                ),
              ),

            // Account Input
            _buildTextField(
              label: "Your Saving A/C No.",
              hint: "Enter your Account Number",
              value: account,
              onChanged: (v) => setState(() => account = v),
            ),

            const SizedBox(height: 12),

            // State, City, Branch
            Column(
              children: [
                _buildDropdown(
                  label: "State",
                  value: stateValue,
                  items: const ["State1", "State2"],
                  onChanged: (v) => setState(() => stateValue = v ?? ""),
                ),
                const SizedBox(height: 12),
                _buildDropdown(
                  label: "City",
                  value: city,
                  items: const ["City1", "City2"],
                  onChanged: (v) => setState(() => city = v ?? ""),
                ),
                const SizedBox(height: 12),
                _buildDropdown(
                  label: "Branch",
                  value: branch,
                  items: const ["Branch1", "Branch2"],
                  onChanged: (v) => setState(() => branch = v ?? ""),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Deposit Amount
            _buildNumberField(
              label: "Deposit Amount (₹)",
              value: amount,
              onChanged: (v) {
                amount = double.tryParse(v) ?? 0;
                recalculate();
              },
            ),

            const SizedBox(height: 12),

            // Deposit Duration
            _buildNumberField(
              label: "Deposit Duration (Months)",
              value: duration,
              onChanged: (v) {
                duration = double.tryParse(v) ?? 0;
                recalculate();
              },
            ),

            const SizedBox(height: 16),

            if (maturity > 0)
              Container(
                padding: FdFormStyles.maturityPadding,
                decoration: FdFormStyles.maturityBox,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "💰 Interest & Maturity Summary",
                      style: FdFormStyles.maturityTitle,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "📈 Interest Rate: ${interestRate.toStringAsFixed(1)}% Per Annum",
                      style: FdFormStyles.maturityText,
                    ),
                    Text(
                      "🎯 Estimated Maturity: ₹${maturity.toStringAsFixed(0)}",
                      style: FdFormStyles.maturityText,
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: FdFormStyles.primaryButton,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("FD Opened Successfully!"),
                        ),
                      );
                    },
                    child: const Text("Open FD"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: FdFormStyles.outlineButton,
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Text field
  Widget _buildTextField({
    required String label,
    required String hint,
    required String value,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: FdFormStyles.labelText),
        const SizedBox(height: 6),
        TextField(
          decoration: FdFormStyles.inputDecoration(hint),
          controller: TextEditingController(text: value),
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Number field
  Widget _buildNumberField({
    required String label,
    required double value,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: FdFormStyles.labelText),
        const SizedBox(height: 6),
        TextField(
          keyboardType: TextInputType.number,
          decoration: FdFormStyles.inputDecoration("Enter number"),
          controller: TextEditingController(text: value.toStringAsFixed(0)),
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Dropdown field
  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: FdFormStyles.labelText),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value.isEmpty ? null : value,
          hint: Text(label, style: FdFormStyles.hintText),
          onChanged: onChanged,
          isDense: true,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          decoration: FdFormStyles.dropdownDecoration,
        ),
      ],
    );
  }
}
