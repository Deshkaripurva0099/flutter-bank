import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neobank/widgets/layout.dart';
//import 'package:neobank/widgets/topbar.dart';

class InvestmentPage extends StatelessWidget {
  const InvestmentPage({super.key});

  static const Color primaryColor = Color(0xFF900603);
  static const Color accentColor = Color(0xFF950606);
  static const Color bgColor = Color(0xFFF8F9FA);

  static final List<Map<String, dynamic>> _investmentOptions = [
    {
      'name': 'Equity Mutual Fund',
      'type': 'Mutual Fund',
      'risk': 'High',
      'desc': 'Best for long term wealth creation.',
      'returns': '12-15% annually',
      'amount': '5000',
      'img':
          'https://images.pexels.com/photos/5716004/pexels-photo-5716004.jpeg?auto=compress&cs=tinysrgb&w=800',
    },
    {
      'name': 'Fixed Deposit',
      'type': 'Bank FD',
      'risk': 'Low',
      'desc': 'Safe and secure investment with fixed returns.',
      'returns': '6-7% annually',
      'amount': '1000',
      'img':
          'https://images.pexels.com/photos/8437000/pexels-photo-8437000.jpeg?auto=compress&cs=tinysrgb&w=800',
    },
    {
      'name': 'Gold ETF',
      'type': 'Exchange Traded Fund',
      'risk': 'Medium',
      'desc': 'Diversify portfolio with gold backed securities.',
      'returns': '8-10% annually',
      'amount': '2000',
      'img':
          'https://images.pexels.com/photos/5980742/pexels-photo-5980742.jpeg?auto=compress&cs=tinysrgb&w=800',
    },
    {
      'name': 'Real Estate Fund',
      'type': 'Property',
      'risk': 'Medium',
      'desc': 'Invest in commercial and residential properties.',
      'returns': '10-12% annually',
      'amount': '10000',
      'img':
          'https://images.pexels.com/photos/439391/pexels-photo-439391.jpeg?auto=compress&cs=tinysrgb&w=800',
    },
    {
      'name': 'Crypto Portfolio',
      'type': 'Digital Asset',
      'risk': 'High',
      'desc': 'High-risk, high-return decentralized assets.',
      'returns': '20-30% annually',
      'amount': '3000',
      'img':
          'https://images.pexels.com/photos/6770713/pexels-photo-6770713.jpeg?auto=compress&cs=tinysrgb&w=800',
    },
    {
      'name': 'Government Bonds',
      'type': 'Fixed Income',
      'risk': 'Low',
      'desc': 'Stable returns backed by government securities.',
      'returns': '5-6% annually',
      'amount': '1500',
      'img':
          'https://images.pexels.com/photos/259200/pexels-photo-259200.jpeg?auto=compress&cs=tinysrgb&w=800',
    },
  ];

  static final List<Map<String, dynamic>> _tipsList = [
    {
      'icon': '🎯',
      'title': 'Diversify Your Portfolio',
      'desc': 'Spread your investments across different asset classes.',
    },
    {
      'icon': '📈',
      'title': 'Think Long-term',
      'desc': 'Patient investors often achieve higher returns.',
    },
    {
      'icon': '🛡️',
      'title': 'Understand Risk',
      'desc': 'Higher risk often brings potential for higher return.',
    },
  ];

  static Color _riskColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.amber;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static Widget _overviewCard(
    String title,
    String value,
    String subtitle,
    Color color,
  ) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          top: BorderSide(color: color.withOpacity(0.9), width: 4),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth < 992;

    int columnCount = isMobile
        ? 1
        : isTablet
        ? 2
        : 3;
    return AppLayout(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // everything inside remains unchanged
            Container(
              color: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Investment Portfolios',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Grow your wealth with smart investments',
                        style: TextStyle(
                          color: Color(0xFFF0F0F0),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text(
                      'Start Investing',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // return Scaffold(
            //   appBar: NavbarTop(),
            //   backgroundColor: bgColor,
            //   body: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         // ...Header and Overview Suitably...
            //         Container(
            //           color: primaryColor,
            //           padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            //           child: Wrap(
            //             alignment: WrapAlignment.spaceBetween,
            //             runAlignment: WrapAlignment.center,
            //             children: [
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: const [
            //                   Text(
            //                     'Investment Portfolios',
            //                     style: TextStyle(
            //                       fontSize: 22,
            //                       fontWeight: FontWeight.bold,
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                   SizedBox(height: 4),
            //                   Text(
            //                     'Grow your wealth with smart investments',
            //                     style: TextStyle(
            //                       color: Color(0xFFF0F0F0),
            //                       fontSize: 14,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               const SizedBox(height: 10),
            //               OutlinedButton.icon(
            //                 onPressed: () {},
            //                 icon: const Icon(Icons.add, color: Colors.white),
            //                 label: const Text(
            //                   'Start Investing',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //                 style: OutlinedButton.styleFrom(
            //                   side: const BorderSide(color: Colors.white),
            //                   padding: const EdgeInsets.symmetric(
            //                     horizontal: 16,
            //                     vertical: 10,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _overviewCard(
                    'Total Value',
                    '₹1,25,000',
                    '↑ 8.5% this month',
                    Colors.orange,
                  ),
                  _overviewCard(
                    'Total Returns',
                    '₹45,680',
                    '15.2% overall',
                    Colors.green,
                  ),
                  _overviewCard(
                    'Goal Progress',
                    '70%',
                    'Retirement fund',
                    Colors.blue,
                  ),
                  _overviewCard(
                    'Risk Score',
                    'Moderate',
                    'Balanced portfolio',
                    Colors.purple,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Investment Options Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: primaryColor,
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Investment Options',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Explore new investment opportunities',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double itemWidth =
                            (constraints.maxWidth - (columnCount - 1) * 10) /
                            columnCount;
                        return Wrap(
                          spacing: 10,
                          runSpacing: 12,
                          children: _investmentOptions.map((item) {
                            return SizedBox(
                              width: itemWidth,
                              // use the new card widget
                              child: InvestmentCard(item: item),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ...Tips section remains unchanged...
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Investment Tips for Success',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 15,
                      children: _tipsList.map((tip) {
                        return _TipCard(
                          icon: tip['icon'],
                          title: tip['title'],
                          desc: tip['desc'],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class InvestmentCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const InvestmentCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            InvestmentPage.primaryColor.withOpacity(0.96),
            InvestmentPage.accentColor.withOpacity(0.90),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: InvestmentPage.primaryColor.withOpacity(0.14),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.network(
              item['img'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          item['type'],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: InvestmentPage._riskColor(item['risk']),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${item['risk']} Risk',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item['desc'],
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Expected Returns',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      item['returns'],
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Minimum Investment',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      '₹${item['amount']}',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: InvestmentPage.accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => InvestDialog(schemeName: item['name']),
                      );
                    },
                    child: const Text(
                      'Invest Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InvestDialog extends StatefulWidget {
  final String schemeName;
  const InvestDialog({super.key, required this.schemeName});

  @override
  State<InvestDialog> createState() => _InvestDialogState();
}

class _InvestDialogState extends State<InvestDialog> {
  final TextEditingController _amountController = TextEditingController();
  String? error;

  void _onConfirm() {
    if (_amountController.text.trim().isEmpty) {
      setState(() => error = "Please enter an amount");
      return;
    }
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Invested ₹${_amountController.text.trim()} successfully!",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dim background
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(color: Colors.black.withOpacity(0.42)),
        ),
        Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 370,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 30,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.14),
                    blurRadius: 22,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Red header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: InvestmentPage.primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                    ),
                    child: Text(
                      "Invest in ${widget.schemeName}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      children: [
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Enter Amount",
                            labelStyle: const TextStyle(color: Colors.black87),
                            hintText: "Enter amount in INR",
                            filled: true,
                            fillColor: const Color(0xFFF8F9FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: InvestmentPage.primaryColor,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 16,
                            ),
                          ),
                        ),
                        if (error != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              error ?? "",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: InvestmentPage.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _onConfirm,
                            child: const Text(
                              "Confirm",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TipCard extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;

  const _TipCard({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
