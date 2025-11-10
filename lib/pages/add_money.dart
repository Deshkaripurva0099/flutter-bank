import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neobank/widgets/topbar.dart';

class AddMoneyPage extends StatefulWidget {
  const AddMoneyPage({super.key});

  @override
  State<AddMoneyPage> createState() => _AddMoneyPageState();
}

class _AddMoneyPageState extends State<AddMoneyPage> {
  String source = 'upi';
  bool savePayment = false;
  bool saving = false;
  String error = '';

  // --- 📌 Controllers ---
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpiryController = TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();

  final paymentOptions = [
    {'id': 'upi', 'label': 'UPI', 'icon': Icons.smartphone},
    {'id': 'card', 'label': 'Debit / Credit Card', 'icon': Icons.credit_card},
    {'id': 'bank', 'label': 'Netbanking', 'icon': Icons.account_balance},
    {'id': 'wallet', 'label': 'Wallet', 'icon': Icons.account_balance_wallet},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _upiController.dispose();
    _cardNumberController.dispose();
    _cardExpiryController.dispose();
    _cardCvvController.dispose();
    _cardNameController.dispose();
    super.dispose();
  }

  bool validate() {
    setState(() => error = '');
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      setState(() => error = "Enter a valid amount.");
      return false;
    }
    if (amount < 10) {
      setState(() => error = "Minimum amount is ₹10.");
      return false;
    }

    if (source == 'upi') {
      final re = RegExp(r'^[\w.+-]+@[\w]+$');
      if (!re.hasMatch(_upiController.text)) {
        setState(() => error = "Enter a valid UPI ID.");
        return false;
      }
    }

    if (source == 'card') {
      if (!RegExp(
        r'^\d{13,19}$',
      ).hasMatch(_cardNumberController.text.replaceAll(' ', ''))) {
        setState(() => error = "Enter a valid card number.");
        return false;
      }
      if (!RegExp(r'^\d{3,4}$').hasMatch(_cardCvvController.text)) {
        setState(() => error = "Enter valid CVV.");
        return false;
      }
      if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(_cardExpiryController.text)) {
        setState(() => error = "Expiry should be MM/YY.");
        return false;
      }
    }

    return true;
  }

  void handlePay() {
    if (!validate()) return;

    setState(() {
      saving = true;
      error = '';
    });

    Future.delayed(const Duration(seconds: 1), () {
      final amount = _amountController.text;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "✅ Payment successful\nAdded ₹$amount via ${source.toUpperCase()}",
          ),
        ),
      );

      setState(() {
        _amountController.clear();
        _upiController.clear();
        _cardNumberController.clear();
        _cardExpiryController.clear();
        _cardCvvController.clear();
        _cardNameController.clear();
        savePayment = false;
        saving = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarTop(),
      backgroundColor: const Color(0xFFF5F5F5),
      //resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          // Dismiss keyboard when tapping outside
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.deferToChild,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 12),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "💰 Add Money",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF950606),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Amount
                      const Text(
                        "Amount (INR)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.grey[200],
                            child: const Text("₹"),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                hintText: "Enter amount e.g. 1000",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Payment Options
                      const Text(
                        "Choose source",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: paymentOptions.map((opt) {
                          final isActive = source == opt['id'];
                          return ElevatedButton.icon(
                            icon: Icon(
                              opt['icon'] as IconData,
                              size: 18,
                              color: isActive ? Colors.white : Colors.black,
                            ),
                            label: Text(
                              opt['label'] as String,
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isActive
                                  ? const Color(0xFF950606)
                                  : Colors.white,
                              side: BorderSide(
                                color: isActive
                                    ? const Color(0xFF950606)
                                    : Colors.grey,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                            ),
                            onPressed: () =>
                                setState(() => source = opt['id'] as String),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // UPI
                      if (source == 'upi') ...[
                        const Text(
                          "UPI ID",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              color: Colors.grey[200],
                              child: const Text("@"),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _upiController,
                                decoration: const InputDecoration(
                                  hintText: "example@bank",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Card Payment
                      if (source == 'card') ...[
                        const SizedBox(height: 8),
                        TextField(
                          controller: _cardNumberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Card number",
                            prefixIcon: Icon(Icons.credit_card),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _cardExpiryController,
                                decoration: const InputDecoration(
                                  hintText: "MM/YY",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _cardCvvController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "CVV",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _cardNameController,
                          decoration: const InputDecoration(
                            hintText: "Cardholder name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: savePayment,
                              onChanged: (val) =>
                                  setState(() => savePayment = val!),
                            ),
                            const Text(
                              "Save this card for faster payments",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],

                      if (error.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            error,
                            style: const TextStyle(color: Color(0xFF950606)),
                          ),
                        ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: saving ? null : handlePay,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: saving
                              ? Colors.grey
                              : const Color(0xFF950606),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          saving
                              ? "Processing..."
                              : "Add ₹${_amountController.text.isEmpty ? '' : _amountController.text}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
