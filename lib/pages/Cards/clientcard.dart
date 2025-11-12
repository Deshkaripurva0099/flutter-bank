import 'package:flutter/material.dart';
import 'clientcard2.dart'; // 

const Color primaryRed = Color(0xFF900603);

class ClientCard extends StatefulWidget {
  const ClientCard({super.key});

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  List<Map<String, dynamic>> cards = [
    {
      'id': 1,
      'status': 'Active',
      'type': 'CREDIT CARD',
      'bank': 'NeoBank',
      'cardNumber': '1234 5618 9012 3456',
      'cardHolder': 'CARDHOLDER',
      'availableLimit': '₹50,000.00',
      'annualFee': '₹99.99',
      'interestRate': '18.99% p.a.',
      'features':
          '5x points on dining and travel, 2x points on all other purchases, complimentary airport lounge access, fraud protection.',
      'image': 'assets/Card1.png',
    },
    {
      'id': 2,
      'status': 'Active',
      'type': 'CREDIT CARD',
      'bank': 'NeoBank',
      'cardNumber': '5678 9012 3456 7890',
      'cardHolder': 'CARDHOLDER',
      'availableLimit': '₹75,000.00',
      'annualFee': '₹99.99',
      'interestRate': '18.99% p.a.',
      'features':
          '5x points on dining and travel, 2x points on all other purchases, complimentary airport lounge access, fraud protection.',
      'image': 'assets/Card2.png',
    },
    {
      'id': 3,
      'status': 'Active',
      'type': 'CREDIT CARD',
      'bank': 'NeoBank',
      'cardNumber': '3456 7890 1234 5678',
      'cardHolder': 'CARDHOLDER',
      'availableLimit': '₹1,00,000.00',
      'annualFee': '₹99.99',
      'interestRate': '18.99% p.a.',
      'features':
          '5x points on dining and travel, 2x points on all other purchases, complimentary airport lounge access, fraud protection.',
      'image': 'assets/Card1.png',
    },
  ];

  void handleSettingsAction(String action, String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action — $type')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              // 🔴 HEADER
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                color: primaryRed,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Cards',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Your digital cards, simplified and secure',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF0F0F0),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 2),
                          backgroundColor: primaryRed,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/applyNewCard');
                         
                        },
                        child: const Text("+ Apply for New Card"),
                      ),
                    ),
                  ],
                ),
              ),

              // 🔘 Subheading
              const Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Manage your debit and credit cards",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),

              // 🧩 RESPONSIVE GRID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                    final cardAspectRatio =
                        constraints.maxWidth > 600 ? 0.7 : 0.65;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cards.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: cardAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final card = cards[index];
                        return _buildCardItem(card);
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Add ClientCard2 Below
              ClientCard2(), // 👈 This displays the detailed section below

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Single Card Item
  Widget _buildCardItem(Map<String, dynamic> card) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status and Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4EDDA),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    card['status'],
                    style: const TextStyle(
                      color: Color(0xFF155724),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  card['type'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Card Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(card['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Card Info
            const Text("Available Limit",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(
              card['availableLimit'],
              style: const TextStyle(
                color: primaryRed,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),

            // Fees
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Annual Fee",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                        Text(card['annualFee'],
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Interest Rate",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                        Text(card['interestRate'],
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            const Text("Key Features",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(card['features'],
                style: const TextStyle(fontSize: 12, height: 1.4),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {},
                    child: const Text("Manage",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 20),
                  onSelected: (value) =>
                      handleSettingsAction(value, card['type']),
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                        value: "Block / Unblock Card",
                        child: Text("Block / Unblock Card")),
                    PopupMenuItem(
                        value: "Set Spending Limit",
                        child: Text("Set Spending Limit")),
                    PopupMenuItem(
                        value: "Change PIN", child: Text("Change PIN")),
                    PopupMenuItem(
                        value: "Report Lost",
                        child: Text("Report Lost / Request Replacement")),
                    PopupMenuItem(
                        value: "View e-Statements",
                        child: Text("View e-Statements")),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



