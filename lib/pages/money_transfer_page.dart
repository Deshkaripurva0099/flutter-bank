import 'package:flutter/material.dart';
import 'package:neobank/pages/domastic_transfer.dart';
import 'package:neobank/widgets/layout.dart';
import 'package:neobank/widgets/transfer_card.dart';
import 'send_money_page.dart';
import 'kyc_verification_page.dart';
import 'paybills_page.dart';
import 'history.dart';

class MoneyTransferPage extends StatefulWidget {
  const MoneyTransferPage({super.key});

  @override
  State<MoneyTransferPage> createState() => _MoneyTransferPageState();
}

class _MoneyTransferPageState extends State<MoneyTransferPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> options = [
      {
        "icon": Icons.send_rounded,
        "title": "Send Money",
        "subtitle": "Transfer money to bank accounts, UPI, or mobile wallets",
        "page": const SendMoneyPage(),
      },
      {
        "icon": Icons.verified_user_rounded,
        "title": "KYC Verification",
        "subtitle": "Complete your KYC for higher transaction limits",
        "page": const UpdateKYCPage(),
      },
      {
        "icon": Icons.payment_rounded,
        "title": "Pay Bills",
        "subtitle": "Pay utility bills, mobile recharge, and more",
        "page": const PayBillsPage(),
      },
      {
        "icon": Icons.lock_outline,
        "title": "Transaction Limit",
        "subtitle": "View or upgrade your daily transaction limit",
        "page": const SizedBox(),
      },
      {
        "icon": Icons.account_balance_rounded,
        "title": "Domestic Transfers",
        "subtitle":
            "Choose from NEFT, IMPS, RTGS, or UPI for sending money within India",
        "page": const DomesticTransferPage(),
      },
      {
        "icon": Icons.history_rounded,
        "title": "Transaction History",
        "subtitle": "View all your money transfer transactions",
        "page": const HistoryPage(),
      },
    ];

    return AppLayout(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 32),
              decoration: const BoxDecoration(color: Color(0xFF900603)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Money Transfer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Send money instantly and securely to anyone, anywhere",
                    style: TextStyle(color: Color(0xFFF0F0F0), fontSize: 14),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth > 1000
                          ? 3
                          : constraints.maxWidth > 600
                          ? 2
                          : 1;

                      return GridView.builder(
                        itemCount: options.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.6,
                        ),
                        itemBuilder: (context, index) {
                          final item = options[index];
                          return TransferCard(
                            icon: item['icon'],
                            title: item['title'],
                            subtitle: item['subtitle'],
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => item['page'],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  buildQuickTransferSection(context),
                  const SizedBox(height: 20),
                  buildRecentTransfersSection(),
                  const SizedBox(height: 20),
                  buildLimitAndKycSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Quick Transfer
  Widget buildQuickTransferSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Transfer Methods",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text("Choose your preferred way to send money"),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTransferMethod(
              Icons.qr_code,
              "UPI Transfer",
              "Instant transfers using UPI",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SendMoneyPage(),
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
            buildTransferMethod(
              Icons.account_balance,
              "NEFT/RTGS",
              "Bank to bank transfers",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DomesticTransferPage(),
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
            buildTransferMethod(
              Icons.public,
              "International",
              "Send money abroad",
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/pages/international_transfer_page",
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  // Transfer Method Card
  Widget buildTransferMethod(
    IconData icon,
    String title,
    String subtitle, {
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: SizedBox(
        height: 150,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: const Color(0xFF900603), size: 28),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //  Recent Transfers
  Widget buildRecentTransfersSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Transfers",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF900603),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF900603),
                child: Text("R", style: TextStyle(color: Colors.white)),
              ),
              title: Text("Rahul Sharma"),
              subtitle: Text("12 Sep 2025 · UPI"),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹2,500",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Completed",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Limit + KYC
  Widget buildLimitAndKycSection() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildLimitCard("Daily Limit", "₹25,000", "Used Today: ₹5,000"),
          const SizedBox(width: 10),
          buildLimitCard("Monthly Limit", "₹2,00,000", "Used: ₹80,000"),
          const SizedBox(width: 10),
          buildKycCard(),
        ],
      ),
    );
  }

  Widget buildLimitCard(String title, String limit, String used) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                limit,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(used, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKycCard() {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "KYC Status",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Verified",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Full limits available",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:neobank/pages/domastic_transfer.dart';
// import 'package:neobank/widgets/layout.dart';
// import 'package:neobank/widgets/transfer_card.dart';

// import 'send_money_page.dart';
// import 'kyc_verification_page.dart';
// // Import other pages here when available
// import 'paybills_page.dart';
// // import 'transaction_limit_page.dart';
// import 'history.dart';

// class MoneyTransferPage extends StatefulWidget {
//   const MoneyTransferPage({super.key});

//   @override
//   State<MoneyTransferPage> createState() => _MoneyTransferPageState();
// }

// class _MoneyTransferPageState extends State<MoneyTransferPage> {
//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> options = [
//       {
//         "icon": Icons.send_rounded,
//         "title": "Send Money",
//         "subtitle": "Transfer money to bank accounts, UPI, or mobile wallets",
//         "page": const SendMoneyPage(),
//       },
//       {
//         "icon": Icons.verified_user_rounded,
//         "title": "KYC Verification",
//         "subtitle": "Complete your KYC for higher transaction limits",
//         "page": const UpdateKYCPage(),
//       },
//       {
//         "icon": Icons.payment_rounded,
//         "title": "Pay Bills",
//         "subtitle": "Pay utility bills, mobile recharge, and more",
//         "page": const PayBillsPage(),
//       },
//       {
//         "icon": Icons.lock_outline,
//         "title": "Transaction Limit",
//         "subtitle": "View or upgrade your daily transaction limit",
//         "page": const SizedBox(),
//       },
//       {
//         "icon": Icons.account_balance_rounded,
//         "title": "Domestic Transfers",
//         "subtitle":
//             "Choose from NEFT, IMPS, RTGS, or UPI for sending money within India",
//         "page": const DomesticTransferPage(),
//       },
//       {
//         "icon": Icons.history_rounded,
//         "title": "Transaction History",
//         "subtitle": "View all your money transfer transactions",
//         "page": const HistoryPage(),
//       },
//     ];

//     return AppLayout(
//       child: Column(
//         children: [
//           // Full-width Header Section (no padding constraints)
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 32),
//             decoration: const BoxDecoration(color: Color(0xFF900603)),
//             child: const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Money Transfer",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 Text(
//                   "Send money instantly and securely to anyone, anywhere",
//                   style: TextStyle(color: Color(0xFFF0F0F0), fontSize: 14),
//                 ),
//               ],
//             ),
//           ),

//           // Scrollable content (inside padding)
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   // 🧾 Existing Grid of Cards
//                   LayoutBuilder(
//                     builder: (context, constraints) {
//                       int crossAxisCount = constraints.maxWidth > 1000
//                           ? 3
//                           : constraints.maxWidth > 600
//                           ? 2
//                           : 1;

//                       return GridView.builder(
//                         itemCount: options.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: crossAxisCount,
//                           crossAxisSpacing: 10,
//                           mainAxisSpacing: 10,
//                           childAspectRatio: 1.6,
//                         ),
//                         itemBuilder: (context, index) {
//                           final item = options[index];
//                           return TransferCard(
//                             icon: item['icon'],
//                             title: item['title'],
//                             subtitle: item['subtitle'],
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => item['page'],
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 30),

//                   // 💸 Quick Transfer Methods Section
//                   buildQuickTransferSection(),

//                   const SizedBox(height: 20),

//                   // 🕒 Recent Transfers Section
//                   buildRecentTransfersSection(),

//                   const SizedBox(height: 20),

//                   // 📊 Limits + KYC Status Section
//                   buildLimitAndKycSection(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildQuickTransferSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Quick Transfer Methods",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         const Text("Choose your preferred way to send money"),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             buildTransferMethod(
//               Icons.qr_code,
//               "UPI Transfer",
//               "Instant transfers using UPI",
//             ),
//             const SizedBox(width: 10),
//             buildTransferMethod(
//               Icons.account_balance,
//               "NEFT/RTGS",
//               "Bank to bank transfers",
//             ),
//             const SizedBox(width: 10),
//             buildTransferMethod(
//               Icons.public,
//               "International",
//               "Send money abroad",
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildTransferMethod(IconData icon, String title, String subtitle) {
//     return Expanded(
//       child: SizedBox(
//         height: 150, // 👈 fixed height for all cards
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 2,
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               mainAxisAlignment:
//                   MainAxisAlignment.center, // centers content vertically
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(icon, color: Colors.red, size: 28),
//                 const SizedBox(height: 6),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   subtitle,
//                   style: TextStyle(color: Colors.grey[700], fontSize: 13),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildRecentTransfersSection() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 3,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Recent Transfers",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () {},
//                   child: const Text(
//                     "View All",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.red,
//                 child: Text("R", style: TextStyle(color: Colors.white)),
//               ),
//               title: Text("Rahul Sharma"),
//               subtitle: Text("12 Sep 2025 · UPI"),
//               trailing: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     "₹2,500",
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "Completed",
//                     style: TextStyle(color: Colors.grey, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildLimitAndKycSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         buildLimitCard("Daily Limit", "₹25,000", "Used Today: ₹5,000"),
//         buildLimitCard("Monthly Limit", "₹2,00,000", "Used Today: ₹80,000"),
//         buildKycCard(),
//       ],
//     );
//   }

//   Widget buildLimitCard(String title, String limit, String used) {
//     return Expanded(
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 limit,
//                 style: const TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(used, style: const TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildKycCard() {
//     return Expanded(
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: const Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Text(
//                 "KYC Status",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "Verified",
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 "Full limits available",
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
