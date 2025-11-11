import 'package:flutter/material.dart';
import 'fd_styles.dart';
import 'fixed_deposit_form.dart';

class RDPage extends StatefulWidget {
  const RDPage({super.key});

  @override
  State<RDPage> createState() => _RDPageState();
}

class _RDPageState extends State<RDPage> {
  int selectedTab = 0;
  double depositAmount = 50000;
  double interestRate = 6.4;
  double tenure = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fdBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===================== Hero Section =====================
            Container(
              decoration: fdHeroDecoration,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button and Open FD Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: fdPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: const Text("Back"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FixedDepositForm(
                                depositAmount: depositAmount,
                                tenure: tenure,
                                interestRate: interestRate,
                              ),
                            ),
                          );
                        },
                        style: fdPrimaryButton,
                        child: const Text("Open RD"),
                      ),
                    ],
                  ),

                  // 🔹 Added FD banner image here
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 450,
                    height: 200,
                    child: Image.asset('assets/fd-banner.png'),
                  ),

                  const SizedBox(height: 40),
                  Text("Recurring Deposit (RD)", style: fdTitleText),
                  const SizedBox(height: 10),
                  Text("Invest smartly and safely.", style: fdSubTitleText),
                  const SizedBox(height: 10),
                  Text(
                    "Attractive returns | Flexible Tenures | Guaranteed Returns.",
                    style: fdBodyText,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: fdPrimaryButton,
                        child: const Text("Calculate Now"),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: fdOutlineButton,
                        child: const Text("Know More"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "⭐ 8,500+ PEOPLE ARE INTERESTED",
                    style: fdSummaryLabelText,
                  ),
                ],
              ),
            ),

            // ===================== Calculator Card =====================
            Container(
              padding: fdSectionPadding,
              color: fdBackgroundColor,
              child: Container(
                decoration: fdCardDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 112,
                        vertical: 15,
                      ),
                      decoration: const BoxDecoration(color: fdPrimaryColor),
                      child: const Text(
                        "Recurring Deposit Calculator",
                        style: fdCardHeaderText,
                      ),
                    ),
                    Container(
                      padding: fdCardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tabs
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => selectedTab = 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedTab == 0
                                          ? fdPrimaryColor
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        "General",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: selectedTab == 0
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => selectedTab = 1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedTab == 1
                                          ? fdPrimaryColor
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        "Senior Citizen",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: selectedTab == 1
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Input: Deposit Amount
                          const Text(
                            "Deposit Amount",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Slider(
                            min: 1000,
                            max: 1000000,
                            divisions: 100,
                            activeColor: fdPrimaryColor,
                            value: depositAmount,
                            onChanged: (val) =>
                                setState(() => depositAmount = val),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("₹1,000"),
                              Text(
                                "₹${depositAmount.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  color: fdPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text("₹10,00,000"),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Input: Tenure
                          const Text(
                            "Tenure (Months)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Slider(
                            min: 1,
                            max: 120,
                            divisions: 120,
                            activeColor: fdPrimaryColor,
                            value: tenure,
                            onChanged: (val) => setState(() => tenure = val),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("1"),
                              Text(
                                tenure.toStringAsFixed(0),
                                style: const TextStyle(
                                  color: fdPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text("120"),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Interest Slabs
                          const Text(
                            "Interest Slabs",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildInterestSlabs(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Interest rates depend on tenure and bank policy.",
                            style: fdSummaryLabelText,
                          ),
                          const SizedBox(height: 20),

                          // ===================== Summary Card =====================
                          Center(
                            child: Container(
                              width: 400,
                              decoration: fdSummaryDecoration,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  const Text(
                                    "Total Maturity Amount",
                                    style: fdSummaryLabelText,
                                  ),
                                  Text(
                                    "₹${_calculateMaturityAmount().toStringAsFixed(2)}",
                                    style: fdSummaryValueText,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Interest Earned: ₹${_calculateInterest().toStringAsFixed(2)}",
                                    style: fdDarkBodyText,
                                  ),
                                  const SizedBox(height: 15),
                                  Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: fdPrimaryButton,
                                        child: const Text("Invest Now"),
                                      ),
                                      const SizedBox(height: 10),
                                      OutlinedButton(
                                        onPressed: () {},
                                        style: fdOutlineButton,
                                        child: const Text("Download Summary"),
                                      ),
                                    ],
                                  ),
                                ],
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

            // ===================== Benefits Section =====================
            Container(
              padding: fdSectionPadding,
              child: Column(
                children: [
                  const Text(
                    "Benefits of FD Calculator",
                    style: fdBenefitTitle,
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 30,
                    runSpacing: 30,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildBenefitCard(
                        title: "Quick Estimation",
                        desc:
                            "Get instant results based on your deposit and tenure.",
                      ),
                      _buildBenefitCard(
                        title: "Compare Rates",
                        desc:
                            "See how different interest rates affect your maturity value.",
                      ),
                      _buildBenefitCard(
                        title: "User Friendly",
                        desc:
                            "Simple sliders and easy interface for quick planning.",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateMaturityAmount() {
    double interest = _calculateInterest();
    return depositAmount + interest;
  }

  double _calculateInterest() {
    double timeInYears = tenure / 12;
    return depositAmount * (interestRate / 100) * timeInYears;
  }

  Widget _buildInterestSlab(double rate, String description) {
    return GestureDetector(
      onTap: () => setState(() => interestRate = rate),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: interestRate == rate ? fdPrimaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              "$rate%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: interestRate == rate ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 10,
                color: interestRate == rate ? Colors.white : Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInterestSlabs() {
    List<Map<String, dynamic>> slabs;
    if (selectedTab == 0) {
      slabs = [
        {'rate': 6.4, 'desc': 'For Tenure of 18M to 2Y'},
        {'rate': 6.6, 'desc': 'For Tenure of 2Y 1D to 10Y'},
        {'rate': 6.8, 'desc': 'For Tenure of Tax Saver FD (5Y)'},
      ];
    } else {
      slabs = [
        {'rate': 6.9, 'desc': 'For Tenure of 18M to 2Y'},
        {'rate': 7.1, 'desc': 'For Tenure of 2Y 1D to 10Y'},
        {'rate': 7.3, 'desc': 'For Tenure of Tax Saver FD (5Y)'},
      ];
    }
    List<Widget> widgets = [];
    for (int i = 0; i < slabs.length; i++) {
      widgets.add(_buildInterestSlab(slabs[i]['rate'], slabs[i]['desc']));
      if (i < slabs.length - 1) {
        widgets.add(const SizedBox(width: 20));
      }
    }
    return widgets;
  }

  Widget _buildBenefitCard({required String title, required String desc}) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: fdBenefitCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: fdBenefitTitle),
          const SizedBox(height: 10),
          Text(desc, style: fdBenefitDesc),
        ],
      ),
    );
  }
}
