import 'package:flutter/material.dart';
import 'package:neobank/widgets/layout.dart';
import 'package:neobank/widgets/topbar.dart';

class InternationalTransferPage extends StatefulWidget {
  const InternationalTransferPage({super.key});

  @override
  State<InternationalTransferPage> createState() =>
      _InternationalTransferPageState();
}

class _InternationalTransferPageState extends State<InternationalTransferPage> {
  int step = 0;

  final List<String> countries = ["USA", "UK", "UAE", "Canada"];
  final List<String> currencies = ["USD", "GBP", "AED", "CAD"];

  final TextEditingController recipientController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController swiftController = TextEditingController();

  String? selectedCountry;

  void handleNext() {
    setState(() {
      if (step < 3) step += 1;
    });
  }

  void handlePrev() {
    setState(() {
      if (step > 0) step -= 1;
    });
  }

  void handleStartTransfer() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Transfer Confirmed!"),
        content: const Text("Your international transfer has been sent."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                step = 0;
                selectedCountry = null;
                recipientController.clear();
                accountController.clear();
                swiftController.clear();
              });
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            margin: const EdgeInsets.only(top: 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _buildStepContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (step) {
      case 0:
        return _landingStep();
      case 1:
        return _chooseCountryStep();
      case 2:
        return _recipientDetailsStep();
      case 3:
        return _reviewStep();
      default:
        return const SizedBox();
    }
  }

  Widget _landingStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.public, size: 60, color: Colors.blue),
        const SizedBox(height: 16),
        const Text(
          "International Transfer",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF950606),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          "Send money securely to bank accounts worldwide",
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("Cancel"),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: handleNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("Start Transfer"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _chooseCountryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choose recipient country",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF950606),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: selectedCountry,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
          hint: const Text("Select Country"),
          items: countries
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: (val) {
            setState(() {
              selectedCountry = val;
            });
          },
        ),
        const SizedBox(height: 12),
        Text(
          "Supported currencies: ${currencies.join(', ')}",
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: handlePrev,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("Back"),
            ),
            ElevatedButton(
              onPressed: selectedCountry != null ? handleNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("Next"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _recipientDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recipient Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF950606),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: recipientController,
          decoration: InputDecoration(
            labelText: "Recipient Name",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: accountController,
          decoration: InputDecoration(
            labelText: "Account Number",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: swiftController,
          decoration: InputDecoration(
            labelText: "SWIFT / IBAN",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: handlePrev,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("Back"),
            ),
            ElevatedButton(
              onPressed: selectedCountry != null ? handleNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("Next"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _reviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Review Transfer Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF950606),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Country: ${selectedCountry ?? ''}"),
              Text("Recipient: ${recipientController.text}"),
              Text("Account Number: ${accountController.text}"),
              Text("SWIFT / IBAN: ${swiftController.text}"),
              const Divider(),
              const Text("Conversion Rate: 1 USD = 82.50 INR"),
              const Text("Transfer Fees: \$2.50"),
              const Text("Estimated Delivery: 1-2 business days"),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: handlePrev,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("Back"),
            ),
            ElevatedButton(
              onPressed: selectedCountry != null ? handleNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),

              child: const Text("Confirm & Send Transfer"),
            ),
          ],
        ),
      ],
    );
  }
}
