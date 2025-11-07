import 'package:flutter/material.dart';
import 'package:neobank/widgets/topbar.dart';

class PayBillsPage extends StatefulWidget {
  const PayBillsPage({super.key});

  @override
  State<PayBillsPage> createState() => _PayBillsPageState();
}

class _PayBillsPageState extends State<PayBillsPage> {
  final List<Map<String, String>> billers = [
    {"id": "electricity", "name": "Electricity Bill", "icon": "💡"},
    {"id": "water", "name": "Water Bill", "icon": "🚰"},
    {"id": "gas", "name": "Gas Bill", "icon": "🔥"},
    {"id": "mobile", "name": "Mobile Recharge", "icon": "📱"},
    {"id": "dth", "name": "DTH Recharge", "icon": "📺"},
    {"id": "broadband", "name": "Broadband Bill", "icon": "🌐"},
  ];

  String selectedBiller = "";
  final TextEditingController accountController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String message = "";

  void handlePay() {
    if (selectedBiller.isEmpty ||
        accountController.text.isEmpty ||
        amountController.text.isEmpty) {
      setState(() {
        message = "⚠️ Please fill in all fields.";
      });
      return;
    }

    setState(() {
      message =
          "✅ Successfully paid ₹${amountController.text} for $selectedBiller!";
      selectedBiller = "";
      accountController.clear();
      amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: NavbarTop(),
      backgroundColor: const Color(0xFFFAFAFA),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header with Back Button
                    Stack(
                      children: [
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: GestureDetector(
                        //     onTap: () => Navigator.of(context).pop(),
                        //     child: const Text(
                        //       "← Back",
                        //       style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.bold,
                        //         color: Color(0xFF950606),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Center(
                          child: Text(
                            "🧾 Pay Bills",
                            style: TextStyle(
                              fontSize: screenWidth < 768 ? 22 : 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF950606),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Select a biller and pay instantly",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF6C757D)),
                    ),
                    const SizedBox(height: 20),

                    // Bill
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: billers.map((biller) {
                        final isSelected = selectedBiller == biller['name'];
                        final itemWidth = (screenWidth - 20 * 2 - 15 * 2) / 3;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBiller = biller['name']!;
                            });
                          },
                          child: Container(
                            width: itemWidth,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFF8F9FA)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFDC3545)
                                    : const Color(0xFFDEE2E6),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  biller['icon']!,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  biller['name']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Account / Consumer Number
                    TextField(
                      controller: accountController,
                      decoration: InputDecoration(
                        hintText: "Account / Consumer Number",
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Color(0xFFDEE2E6),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Color(0xFF950606),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Amount Input
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter Amount",
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Color(0xFFDEE2E6),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Color(0xFF950606),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Pay Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: handlePay,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF950606),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,

                            fontSize: 16,
                          ),
                        ),
                        child: const Text("🚀 Pay Now"),
                      ),
                    ),

                    // Message
                    if (message.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF28A745),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
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
