// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:neobank/pages/Cards/ClienCard.dart';
import 'package:neobank/pages/Money/add_money.dart';
import 'package:neobank/pages/Money/paybills_page.dart';
import 'package:neobank/pages/Money/send_money_page.dart';

import 'package:neobank/pages/deposit.dart';
import 'package:neobank/pages/investment/investment_page.dart';

import 'package:neobank/widgets/layout.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const Color primaryRed = Color(0xFF900603);
  static const Color primaryDark = Color(0xFF750505);

  final List<Map<String, dynamic>> actions = [
    {"icon": LucideIcons.send, "label": "Send Money"},
    {"icon": LucideIcons.wallet, "label": "Add Money"},
    {"icon": LucideIcons.creditCard, "label": "Pay Bills"},
    {"icon": LucideIcons.trendingUp, "label": "Investment"},
    {"icon": LucideIcons.piggyBank, "label": "Fixed Deposit"},
    {"icon": LucideIcons.creditCard, "label": "Card"},
  ];

  final List<Map<String, String>> accounts = [
    {
      "title": "Savings Account",
      "type": "Personal",
      "number": "**** 5678",
      "balance": "₹45,200.00",
    },
    {
      "title": "Current Account",
      "type": "Business",
      "number": "**** 7890",
      "balance": "₹1,20,800.00",
    },
  ];

  final List<Map<String, dynamic>> transactions = [
    {
      "icon": LucideIcons.arrowUp,
      "label": "Sent to Rohan",
      "type": "Transfer",
      "amount": "-₹2,500",
      "date": "30 Oct 2025",
      "color": Colors.redAccent,
    },
    {
      "icon": LucideIcons.arrowDown,
      "label": "Salary Credited",
      "type": "Deposit",
      "amount": "+₹80,000",
      "date": "28 Oct 2025",
      "color": Colors.green,
    },
    {
      "icon": LucideIcons.shoppingBag,
      "label": "Amazon Purchase",
      "type": "Shopping",
      "amount": "-₹3,999",
      "date": "27 Oct 2025",
      "color": Colors.orange,
    },
  ];

  final List<Map<String, dynamic>> insights = [
    {"icon": LucideIcons.pieChart, "label": "Expense Breakdown"},
    {"icon": LucideIcons.trendingUp, "label": "Savings Growth"},
    {"icon": LucideIcons.calendar, "label": "Upcoming Bills"},
    {"icon": LucideIcons.barChart3, "label": "Spending Trends"},
  ];

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: const BoxDecoration(color: primaryRed),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome back, Purvi 👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // Quick Actions
            _sectionTitle("Quick Actions"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  int crossAxisCount = constraints.maxWidth > 800
                      ? 4
                      : constraints.maxWidth > 500
                      ? 3
                      : 2;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: actions.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 3.5,
                    ),
                    itemBuilder: (context, index) {
                      final action = actions[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          final label = action['label'];

                          if (label == "Send Money") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SendMoneyPage(),
                              ),
                            );
                          } else if (label == "Pay Bills") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PayBillsPage(),
                              ),
                            );
                          } else if (label == "Add Money") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddMoneyPage(),
                              ),
                            );
                          } else if (label == "Investment") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InvestmentPage(),
                              ),
                            );
                          } else if (label == "Fixed Deposit") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DepositsPageUnique(),
                              ),
                            );
                          } else if (label == "Cards") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ClientCard(),
                              ),
                            );
                          }
                        },

                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(action['icon'], color: primaryRed),
                              const SizedBox(width: 10),
                              Text(
                                action['label'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // Accounts & Transactions
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool isWide = constraints.maxWidth > 800;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: _cardContainer(
                                title: "My Accounts",
                                subtitle: "Overview of your accounts",
                                child: Column(
                                  children: accounts.map(_accountItem).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Flexible(
                              flex: 1,
                              child: _cardContainer(
                                title: "Recent Transactions",
                                subtitle: "Your latest activity",
                                child: Column(
                                  children: transactions
                                      .map(_transactionItem)
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _cardContainer(
                              title: "My Accounts",
                              subtitle: "Overview of your accounts",
                              child: Column(
                                children: accounts.map(_accountItem).toList(),
                              ),
                            ),
                            _cardContainer(
                              title: "Recent Transactions",
                              subtitle: "Your latest activity",
                              child: Column(
                                children: transactions
                                    .map(_transactionItem)
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),

            const SizedBox(height: 25),

            // Stats Cards (Monthly Spending, Investment Growth, Credit Score)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 160,

                      child: _buildStatCard(
                        title: "Monthly Spending",
                        value: "₹15,750",
                        subtitle: "↓ 12% from last month",
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 160,

                      child: _buildStatCard(
                        title: "Investment Growth",
                        value: "₹2,45,000",
                        subtitle: "↑ 8.5% this quarter",
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 160,

                      child: _buildStatCard(
                        title: "Credit Score",
                        value: "785",
                        subtitle: "Excellent",
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // // Insights & Reports
            // _sectionTitle("Insights & Reports"),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: LayoutBuilder(
            //     builder: (BuildContext context, BoxConstraints constraints) {
            //       int crossAxisCount = constraints.maxWidth > 800
            //           ? 4
            //           : constraints.maxWidth > 500
            //           ? 2
            //           : 1;

            //       return GridView.builder(
            //         shrinkWrap: true,
            //         physics: const NeverScrollableScrollPhysics(),
            //         itemCount: insights.length,
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: crossAxisCount,
            //           crossAxisSpacing: 15,
            //           mainAxisSpacing: 15,
            //           childAspectRatio: 2.8,
            //         ),
            //         itemBuilder: (context, index) {
            //           final item = insights[index];
            //           return Container(
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               border: Border.all(color: Colors.grey.shade200),
            //               borderRadius: BorderRadius.circular(16),
            //             ),
            //             padding: const EdgeInsets.all(14),
            //             child: Row(
            //               children: [
            //                 Container(
            //                   width: 40,
            //                   height: 40,
            //                   decoration: BoxDecoration(
            //                     color: primaryRed.withOpacity(0.1),
            //                     borderRadius: BorderRadius.circular(50),
            //                   ),
            //                   child: Icon(item['icon'], color: primaryRed),
            //                 ),
            //                 const SizedBox(width: 12),
            //                 Text(
            //                   item['label'],
            //                   style: const TextStyle(
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),

            // const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryDark,
          ),
        ),
      ),
    );
  }

  Widget _cardContainer({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  Widget _accountItem(Map<String, String> acc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.account_balance, color: primaryRed),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    acc["title"] ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    acc["type"] ?? "N/A",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    acc["number"] ?? "N/A",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Text(
            acc["balance"] ?? "₹0.00",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryRed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionItem(Map<String, dynamic> tx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (tx['color'] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(tx['icon'] as IconData, color: tx['color']),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx["label"] ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    tx["type"] ?? "N/A",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                tx["amount"] ?? "₹0.00",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: tx["color"],
                ),
              ),
              Text(
                tx["date"] ?? "N/A",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Helper Widget for Stats
  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }
}
