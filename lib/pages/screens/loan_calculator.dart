import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/constants.dart';
import '../../widgets/common_widgets.dart';

class LoanCalculatorWidget extends StatefulWidget {
  const LoanCalculatorWidget({Key? key}) : super(key: key);

  @override
  State<LoanCalculatorWidget> createState() => _LoanCalculatorWidgetState();
}

class _LoanCalculatorWidgetState extends State<LoanCalculatorWidget> {
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _emiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loanAmountController.addListener(_calculateEMI);
    _tenureController.addListener(_calculateEMI);
    _interestRateController.addListener(_calculateEMI);
  }

  void _calculateEMI() {
    if (_loanAmountController.text.isEmpty ||
        _tenureController.text.isEmpty ||
        _interestRateController.text.isEmpty) {
      _emiController.clear();
      return;
    }

    try {
      double P = double.parse(_loanAmountController.text);
      int n = int.parse(_tenureController.text);
      double r = double.parse(_interestRateController.text) / 12 / 100;

      if (P > 0 && n > 0 && r > 0) {
        double emiValue = (P * r * pow(1 + r, n)) / (pow(1 + r, n) - 1);
        _emiController.text = emiValue.toStringAsFixed(2);
      } else {
        _emiController.clear();
      }
    } catch (e) {
      _emiController.clear();
    }
  }

  @override
  void dispose() {
    _loanAmountController.dispose();
    _tenureController.dispose();
    _interestRateController.dispose();
    _emiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calculate, color: AppConstants.primaryRed, size: 28),
                const SizedBox(width: 12),
                const Text(
                  'EMI Calculator',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Calculate your monthly EMI before you apply',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Loan Amount (${AppConstants.rupeeSymbol})',
                    controller: _loanAmountController,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter amount',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    label: 'Tenure (months)',
                    controller: _tenureController,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter months',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Interest Rate (%)',
                    controller: _interestRateController,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter rate',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    label: 'Monthly EMI (${AppConstants.rupeeSymbol})',
                    controller: _emiController,
                    readOnly: true,
                    hintText: 'Calculated EMI',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
