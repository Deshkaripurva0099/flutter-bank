import 'package:flutter/material.dart';
import 'dart:math';
import 'fixed_deposit.dart';
import 'rd_page.dart';
import 'tax_saver_fd.dart';
import '../widgets/layout.dart'; // Import AppLayout

class DepositsPageUnique extends StatefulWidget {
  const DepositsPageUnique({super.key});

  @override
  State<DepositsPageUnique> createState() => _DepositsPageUniqueState();
}

class _DepositsPageUniqueState extends State<DepositsPageUnique> {
  final List<Map<String, dynamic>> deposits = [
    {
      "id": 1,
      "type": "Fixed Deposit",
      "rate": 7.5,
      "amount": 100000,
      "start": "2022-12-15",
      "maturityDate": "2025-12-15",
      "maturityAmount": 107500,
    },
    {
      "id": 2,
      "type": "Recurring Deposit",
      "rate": 7.0,
      "amount": 5000,
      "start": "2025-06-30",
      "maturityDate": "2026-06-30",
      "maturityAmount": 65000,
    },
    {
      "id": 3,
      "type": "Tax Saver FD",
      "rate": 7.75,
      "amount": 150000,
      "start": "2023-03-20",
      "maturityDate": "2028-03-20",
      "maturityAmount": 187500,
    },
  ];

  final TextEditingController principal = TextEditingController();
  final TextEditingController termYears = TextEditingController();
  final TextEditingController interestRate = TextEditingController(text: "7.5");

  double maturity = 0;

  @override
  void initState() {
    super.initState();
    _calculateMaturity();
  }

  void _calculateMaturity() {
    final P = double.tryParse(principal.text) ?? 0;
    final r = (double.tryParse(interestRate.text) ?? 0) / 100;
    final t = double.tryParse(termYears.text) ?? 0;
    if (P == 0 || t == 0) {
      setState(() => maturity = 0);
    } else {
      setState(() => maturity = P * pow(1 + r, t));
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return "${date.day}/${date.month}/${date.year}";
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalDeposits = deposits.fold(
      0.0,
      (sum, d) => sum + (d["amount"] as num),
    );
    final expectedReturns = deposits.fold(
      0.0,
      (sum, d) => sum + ((d["maturityAmount"] - d["amount"]) as num),
    );
    final avgInterest =
        deposits.map((d) => d["rate"]).reduce((a, b) => a + b) /
        deposits.length;

    return AppLayout(
      child: Column(
        children: [
          // ===== HEADER =====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
              left: 24,
              right: 24,
            ),
            decoration: const BoxDecoration(color: Color(0xFF900603)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Deposits",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  // ===== Deposit Calculator =====
                  Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Deposit Calculator",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: principal,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Enter amount",
                            ),
                            onChanged: (_) => _calculateMaturity(),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: termYears,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Term (years)",
                            ),
                            onChanged: (_) => _calculateMaturity(),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: interestRate,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: "Interest Rate (%)",
                            ),
                            onChanged: (_) => _calculateMaturity(),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFDDDD),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Maturity Amount",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "₹${maturity.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Color(0xFF900603),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ===== Deposit Options =====
                  const Text(
                    "Deposit Options",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 25,
                    runSpacing: 25,
                    children: [
                      PlanCard(
                        title: "Fixed Deposit",
                        rate: 7.5,
                        minAmount: 1000,
                        term: "10 years",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FdCalculatorPage(),
                            ),
                          );
                        },
                      ),
                      PlanCard(
                        title: "Recurring Deposit",
                        rate: 7.0,
                        minAmount: 500,
                        term: "10 years",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RDPage(),
                            ),
                          );
                        },
                      ),
                      PlanCard(
                        title: "Tax Saver FD",
                        rate: 7.75,
                        minAmount: 100,
                        term: "5 years",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TaxSaverFD(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ===== My Deposits =====
                  const Text(
                    "My Deposits",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: deposits.map((d) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.savings,
                            color: Color(0xFF900603),
                          ),
                          title: Text(d["type"]),
                          subtitle: Text(
                            "${d["rate"]}% p.a. · Matures on ${_formatDate(d["maturityDate"])}",
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("₹${d["amount"].toStringAsFixed(0)}"),
                              Text(
                                "Maturity: ₹${d["maturityAmount"].toStringAsFixed(0)}",
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // ===== Summary Cards =====
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2,
                    children: [
                      SummaryCard(
                        title: "Total Deposits",
                        value: "₹${totalDeposits.toStringAsFixed(0)}",
                        subtitle: "Across ${deposits.length} accounts",
                      ),
                      SummaryCard(
                        title: "Expected Returns",
                        value: "₹${expectedReturns.toStringAsFixed(0)}",
                        subtitle: "Total interest earned",
                      ),
                      const SummaryCard(
                        title: "Next Maturity",
                        value: "Dec 2025",
                        subtitle: "Fixed Deposit",
                      ),
                      SummaryCard(
                        title: "Avg. Interest",
                        value: "${avgInterest.toStringAsFixed(2)}%",
                        subtitle: "Weighted average",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final double rate;
  final double minAmount;
  final String term;
  final VoidCallback? onPressed;

  const PlanCard({
    super.key,
    required this.title,
    required this.rate,
    required this.minAmount,
    required this.term,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFFFDDDD)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.savings, color: Color(0xFF900603)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "${rate.toStringAsFixed(2)}%",
                  style: const TextStyle(
                    color: Color(0xFF900603),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text("Min Amount: ₹${minAmount.toStringAsFixed(0)}"),
          Text("Max Term: $term"),
          const SizedBox(height: 8),
          const Text(
            "Guaranteed returns\nFlexible tenure\nPremature withdrawal",
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF900603),
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(30),
            ),
            child: const Text(
              "Open Account",
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDDDD),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF900603),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 1),
          Text(subtitle, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
