import 'dart:math';

import 'package:flutter/material.dart';
import 'tax_saver_fd_styles.dart';
import 'fixed_deposit.dart';

class TaxSaverFD extends StatefulWidget {
  const TaxSaverFD({super.key});

  @override
  State<TaxSaverFD> createState() => _TaxSaverFDState();
}

class _TaxSaverFDState extends State<TaxSaverFD> {
  double amount = 10000;
  final double rate = 7.75;
  final int term = 5; // 5 Years Fixed
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: amount.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maturity = (amount * (pow(1 + rate / 100, term))).roundToDouble();
    // Removed NumberFormat as intl is not available

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ✅ Hero Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: TaxSaverFDStyles.fdHero,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Text Column
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tax Saver Fixed Deposit",
                          style: TaxSaverFDStyles.fdHeroLeftTitle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Save tax under Section 80C & earn guaranteed 7.75% returns",
                          style: TaxSaverFDStyles.fdHeroLeftParagraph,
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FdCalculatorPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  246,
                                  247,
                                  247,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 20,
                                ),
                              ),
                              child: const Text(
                                "Open FD Account",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 145, 1, 1),
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TaxSaverFDStyles.tsBackBtnOutline,
                              child: const Text("Back"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Right Image Column
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      'assets/fd-banner.png', // <-- same as fdBanner
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Calculator Section
            Container(
              padding: TaxSaverFDStyles.fdCalculatorPadding,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Calculate Your Returns",
                    style: TaxSaverFDStyles.fdCalculatorTitle,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "Enter Amount",
                    ),
                    controller: _amountController,
                    onChanged: (value) {
                      setState(() {
                        amount = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildFDCard("Interest Rate", "$rate%"),
                      _buildFDCard("Tenure", "$term Years"),
                      _buildFDCard(
                        "Maturity Value",
                        "₹${maturity.toStringAsFixed(0)}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "*Premature withdrawal not allowed",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  // Summary Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: TaxSaverFDStyles.fdSummaryCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Summary", style: TaxSaverFDStyles.fdSummaryTitle),
                        const SizedBox(height: 8),
                        Text(
                          "Amount: ₹${amount.toStringAsFixed(0)}",
                          style: TaxSaverFDStyles.fdSummaryText,
                        ),
                        Text(
                          "Rate: $rate% p.a.",
                          style: TaxSaverFDStyles.fdSummaryText,
                        ),
                        Text(
                          "Tenure: $term Years",
                          style: TaxSaverFDStyles.fdSummaryText,
                        ),
                        Text(
                          "Maturity: ₹${maturity.toStringAsFixed(0)}",
                          style: TaxSaverFDStyles.fdSummaryText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Benefits Section
            Container(
              padding: TaxSaverFDStyles.fdBenefitsPadding,
              decoration: TaxSaverFDStyles.fdBenefitsBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Why Choose Tax Saver FD?",
                    style: TaxSaverFDStyles.fdBenefitsTitle,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children:
                        [
                              "Save tax upto ₹1.5 Lakh under 80C",
                              "100% Guaranteed & Safe Returns",
                              "Start with just ₹100",
                              "Hassle-free Setup",
                            ]
                            .map(
                              (benefit) => Container(
                                width: 160,
                                padding: const EdgeInsets.all(16),
                                decoration: TaxSaverFDStyles.fdBenefitCard,
                                child: Center(
                                  child: Text(
                                    benefit,
                                    textAlign: TextAlign.center,
                                    style: TaxSaverFDStyles.fdBenefitCardTitle,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),

            // ✅ CTA Section
            Container(
              padding: TaxSaverFDStyles.fdCTAPadding,
              alignment: Alignment.center,
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    "Start your Tax Saver FD Today",
                    style: TaxSaverFDStyles.fdCTATitle,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FdCalculatorPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Open FD Account"),
                    style: TaxSaverFDStyles.fdCTAButtonStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFDCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(16),
        decoration: TaxSaverFDStyles.fdCard,
        child: Column(
          children: [
            Text(title, style: TaxSaverFDStyles.fdCardTitle),
            const SizedBox(height: 6),
            Text(value, style: TaxSaverFDStyles.fdCardValue),
          ],
        ),
      ),
    );
  }
}
