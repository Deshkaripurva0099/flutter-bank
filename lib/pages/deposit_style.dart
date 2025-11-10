import 'package:flutter/material.dart';
import 'dart:math';

class DepositsUniquePageStyled extends StatefulWidget {
  const DepositsUniquePageStyled({super.key});

  @override
  State<DepositsUniquePageStyled> createState() =>
      _DepositsUniquePageStyledState();
}

class _DepositsUniquePageStyledState extends State<DepositsUniquePageStyled> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Header =====
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 32),
              color: const Color(0xFF900603),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 20,
                runSpacing: 10,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Deposits",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Secure your future with guaranteed returns",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFF0F0F0),
                        ),
                      ),
                    ],
                  ),
                  // Dropdown button
                  _DepositDropdown(),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ===== Content =====
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _depositCalculatorCard(),
                  const SizedBox(height: 13),
                  _depositOptionsSection(),
                  const SizedBox(height: 13),
                  _myDepositsSection(),
                  const SizedBox(height: 13),
                  _summaryCardsGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _depositCalculatorCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Deposit Calculator",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 768;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: isWide
                        ? (constraints.maxWidth / 4) - 12
                        : constraints.maxWidth,
                    height: 45,
                    child: TextField(
                      controller: principal,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter amount",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                        ),
                      ),
                      onChanged: (_) => _calculateMaturity(),
                    ),
                  ),
                  SizedBox(
                    width: isWide
                        ? (constraints.maxWidth / 4) - 12
                        : constraints.maxWidth,
                    height: 45,
                    child: TextField(
                      controller: termYears,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Term (years)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                        ),
                      ),
                      onChanged: (_) => _calculateMaturity(),
                    ),
                  ),
                  SizedBox(
                    width: isWide
                        ? (constraints.maxWidth / 4) - 12
                        : constraints.maxWidth,
                    height: 45,
                    child: TextField(
                      controller: interestRate,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: "Interest Rate (%)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                        ),
                      ),
                      onChanged: (_) => _calculateMaturity(),
                    ),
                  ),
                  Container(
                    width: isWide
                        ? (constraints.maxWidth / 4) - 12
                        : constraints.maxWidth,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDDDD),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Maturity Amount",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "₹${maturity.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Color(0xFF900603),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _depositOptionsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 768;
        final crossAxisCount = isWide ? 3 : 1;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _PlanCard("Fixed Deposit", 7.5, 1000, "10 years"),
            _PlanCard("Recurring Deposit", 7.0, 500, "10 years"),
            _PlanCard("Tax Saver FD", 7.75, 100, "5 years"),
          ],
        );
      },
    );
  }

  Widget _myDepositsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "My Deposits",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          children: deposits.map((d) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.savings, color: Color(0xFF900603)),
                      const SizedBox(width: 8),
                      Text(
                        "${d["type"]} (${d["rate"]}%)",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${d["amount"].toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Maturity: ₹${d["maturityAmount"].toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _summaryCardsGrid() {
    final totalDeposits = deposits.fold(
      0.0,
      (sum, d) => sum + (d["amount"] as num),
    );
    final expectedReturns = deposits.fold(
      0.0,
      (sum, d) => sum + ((d["maturityAmount"] - d["amount"]) as num),
    );
    final avgInterest = deposits.isEmpty
        ? 0
        : deposits.map((d) => d["rate"]).reduce((a, b) => a + b) /
              deposits.length;
    final nextMaturity = deposits.isEmpty
        ? "N/A"
        : _formatDate(deposits.first["maturityDate"]);

    final cards = [
      {
        "title": "Total Deposits",
        "value": "₹${totalDeposits.toStringAsFixed(0)}",
        "subtitle": "Across ${deposits.length} accounts",
      },
      {
        "title": "Expected Returns",
        "value": "₹${expectedReturns.toStringAsFixed(0)}",
        "subtitle": "Total interest earned",
      },
      {
        "title": "Next Maturity",
        "value": nextMaturity,
        "subtitle": deposits.isEmpty ? "No deposits" : deposits.first["type"],
      },
      {
        "title": "Avg. Interest",
        "value": "${avgInterest.toStringAsFixed(2)}%",
        "subtitle": "Weighted average",
      },
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 768;
        final crossAxisCount = isWide ? 4 : 1;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.5,
          children: cards.map((c) {
            return Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    c["title"]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 6,
                    ),
                  ),
                  Text(
                    c["value"]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF900603),
                      fontWeight: FontWeight.bold,
                      fontSize: 6,
                    ),
                  ),
                  Text(
                    c["subtitle"]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54, fontSize: 3),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// ===== Dropdown Widget =====
class _DepositDropdown extends StatefulWidget {
  const _DepositDropdown();

  @override
  State<_DepositDropdown> createState() => _DepositDropdownState();
}

class _DepositDropdownState extends State<_DepositDropdown> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              color: const Color(0xFF900603),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_box,
                    color: hover ? Colors.black : Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Open New Deposit",
                    style: TextStyle(
                      color: hover ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Visibility(
            visible: hover,
            maintainAnimation: true,
            maintainState: true,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFDDDDDD)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  _menuItem("Fixed Deposit"),
                  _menuItem("Recurring Deposit"),
                  _menuItem("Tax Saver FD"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(String title) {
    return InkWell(
      onTap: () {},
      hoverColor: const Color(0xFF900603),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

// ===== Deposit Options =====
class _PlanCard extends StatelessWidget {
  final String title;
  final double rate;
  final int minAmount;
  final String term;
  const _PlanCard(this.title, this.rate, this.minAmount, this.term);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.savings, color: Color(0xFF900603)),
                  SizedBox(width: 8),
                  Text("Plan", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "$rate%",
                  style: const TextStyle(
                    color: Color(0xFF900603),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Min Amount: ₹$minAmount",
            style: const TextStyle(color: Colors.black54),
          ),
          Text(
            "Max Term: $term",
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 8),
          const Text(
            "• Guaranteed returns\n• Flexible tenure\n• Premature withdrawal",
            style: TextStyle(color: Colors.black54),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF900603),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
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
