import 'package:flutter/material.dart';
import 'package:neobank/widgets/layout.dart';
import 'ClientCard2.dart'; // ✅ Make sure file name matches exactly

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
      'image': 'assets/images/Card1.png',
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
      'image': 'assets/images/Card2.png',
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
      'image': 'assets/images/Card1.png',
    },
  ];

  void handleSettingsAction(String action, String type) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$action — $type')));
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              // 🔴 HEADER
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
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
                      style: TextStyle(fontSize: 14, color: Color(0xFFF0F0F0)),
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
                            horizontal: 16,
                            vertical: 8,
                          ),
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

              // @override
              // Widget build(BuildContext context) {
              //   return Scaffold(
              //     backgroundColor: Colors.grey[50],
              //     body: SafeArea(
              //       child: SingleChildScrollView(
              //         padding: const EdgeInsets.only(bottom: 30),
              //         child: Column(
              //           children: [
              //             // 🔴 HEADER
              //             Container(
              //               padding:
              //                   const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              //               color: primaryRed,
              //               width: double.infinity,
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   const Text(
              //                     'My Cards',
              //                     style: TextStyle(
              //                       fontSize: 22,
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.white,
              //                     ),
              //                   ),
              //                   const SizedBox(height: 4),
              //                   const Text(
              //                     'Your digital cards, simplified and secure',
              //                     style: TextStyle(
              //                       fontSize: 14,
              //                       color: Color(0xFFF0F0F0),
              //                     ),
              //                   ),
              //                   const SizedBox(height: 20),
              //                   Align(
              //                     alignment: Alignment.centerRight,
              //                     child: OutlinedButton(
              //                       style: OutlinedButton.styleFrom(
              //                         side: const BorderSide(color: Colors.white, width: 2),
              //                         backgroundColor: primaryRed,
              //                         foregroundColor: Colors.white,
              //                         padding: const EdgeInsets.symmetric(
              //                             horizontal: 16, vertical: 8),
              //                       ),
              //                       onPressed: () {
              //                         Navigator.pushNamed(context, '/applyNewCard');
              //                         // TODO: Navigate to Apply New Card page
              //                       },
              //                       child: const Text("+ Apply for New Card"),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),

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
                    final cardAspectRatio = constraints.maxWidth > 600
                        ? 0.7
                        : 0.65;

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
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
            const Text(
              "Available Limit",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
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
                        const Text(
                          "Annual Fee",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          card['annualFee'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Interest Rate",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          card['interestRate'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Key Features",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              card['features'],
              style: const TextStyle(fontSize: 12, height: 1.4),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

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
                    child: const Text(
                      "Manage",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      child: Text("Block / Unblock Card"),
                    ),
                    PopupMenuItem(
                      value: "Set Spending Limit",
                      child: Text("Set Spending Limit"),
                    ),
                    PopupMenuItem(
                      value: "Change PIN",
                      child: Text("Change PIN"),
                    ),
                    PopupMenuItem(
                      value: "Report Lost",
                      child: Text("Report Lost / Request Replacement"),
                    ),
                    PopupMenuItem(
                      value: "View e-Statements",
                      child: Text("View e-Statements"),
                    ),
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







/*import 'package:flutter/material.dart';

const Color primaryRed = Color(0xFF900603);
const Color primaryGreen = Color(0xFF16A34A);
const Color primaryBlue = Color(0xFF2563EB);

class ClientCardPage extends StatefulWidget {
  const ClientCardPage({super.key});

  @override
  State<ClientCardPage> createState() => _ClientCardPageState();
}

class _ClientCardPageState extends State<ClientCardPage> {
  List<Map<String, dynamic>> cards = [
    {
      "id": 1,
      "status": "Active",
      "type": "PLATINUM CREDIT CARD",
      "bank": "NeoBank",
      "cardNumber": "**** **** **** 4523",
      "availableLimit": "₹75,000.00",
      "usedLimit": "₹25,000.00",
      "totalLimit": "₹1,00,000.00",
      "dueDate": "15 Feb 2024",
      "minDue": "₹2,500.00",
      "annualFee": "₹999.00",
      "interestRate": "18.99% p.a.",
      "features": "• 5x rewards on dining & travel\n• 2x rewards on all purchases\n• Airport lounge access\n• Zero fraud liability",
      "showNumber": false,
      "cardColor": primaryRed,
      "gradient": [const Color(0xFF900603), const Color(0xFFC62828)],
      "image": "assets/images/card1.png", // Add image path
    },
    {
      "id": 2,
      "status": "Active",
      "type": "GOLD DEBIT CARD",
      "bank": "NeoBank",
      "cardNumber": "**** **** **** 7812",
      "availableBalance": "₹45,250.75",
      "accountLinked": "Salary Account - ****3456",
      "dailyLimit": "₹50,000.00",
      "annualFee": "Free",
      "interestRate": "N/A",
      "features": "• Zero annual fees\n• Contactless payments\n• Instant transaction alerts\n• Free ATM withdrawals",
      "showNumber": false,
      "cardColor": const Color(0xFFD97706),
      "gradient": [const Color(0xFFD97706), const Color(0xFFF59E0B)],
      "image": "assets/images/card2.png", // Add image path
    },
    {
      "id": 3,
      "status": "Blocked",
      "type": "TRAVEL CREDIT CARD",
      "bank": "NeoBank",
      "cardNumber": "**** **** **** 9087",
      "availableLimit": "₹0.00",
      "usedLimit": "₹0.00",
      "totalLimit": "₹2,00,000.00",
      "dueDate": "N/A",
      "minDue": "N/A",
      "annualFee": "₹1,499.00",
      "interestRate": "16.99% p.a.",
      "features": "• Air miles program\n• Travel insurance\n• Hotel discounts\n• Forex markup waiver",
      "showNumber": false,
      "cardColor": const Color(0xFF7C3AED),
      "gradient": [const Color(0xFF7C3AED), const Color(0xFF8B5CF6)],
      "image": "assets/images/card1.png", // Add image path
    },
  ];

  int? openSettingsFor;
  String _selectedFilter = "All Cards";

  void toggleSettings(int index) {
    setState(() {
      openSettingsFor = openSettingsFor == index ? null : index;
    });
  }

  void handleSettingsAction(String action, Map<String, dynamic> card) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$action - ${card["type"]}"),
        backgroundColor: primaryRed,
      ),
    );
    setState(() => openSettingsFor = null);
  }

  void toggleCardNumber(int index) {
    setState(() {
      cards[index]["showNumber"] = !cards[index]["showNumber"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "My Cards",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Manage your cards securely",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          // Filter Button
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onSelected: (value) {
              setState(() => _selectedFilter = value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "All Cards", child: Text("All Cards")),
              const PopupMenuItem(value: "Credit Cards", child: Text("Credit Cards")),
              const PopupMenuItem(value: "Debit Cards", child: Text("Debit Cards")),
              const PopupMenuItem(value: "Active", child: Text("Active Cards")),
              const PopupMenuItem(value: "Blocked", child: Text("Blocked Cards")),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Quick Actions Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _actionButton(Icons.add_card, "Apply New Card", primaryRed),
                      _actionButton(Icons.lock_reset, "Block Card", const Color(0xFFEF4444)),
                      _actionButton(Icons.credit_score, "Set Limit", const Color(0xFF10B981)),
                      _actionButton(Icons.receipt_long, "View Statement", const Color(0xFF3B82F6)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Filter Chip Bar
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _filterChip("All Cards", _selectedFilter == "All Cards"),
                  _filterChip("Credit Cards", _selectedFilter == "Credit Cards"),
                  _filterChip("Debit Cards", _selectedFilter == "Debit Cards"),
                  _filterChip("Active", _selectedFilter == "Active"),
                  _filterChip("Blocked", _selectedFilter == "Blocked"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Cards Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 1200
                      ? 3
                      : constraints.maxWidth > 800
                          ? 2
                          : 1;

                  final filteredCards = _getFilteredCards();

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredCards.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final card = filteredCards[index];
                      final originalIndex = cards.indexWhere((c) => c["id"] == card["id"]);
                      return _buildCard(card, originalIndex);
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // 🔹 Floating Action Button for New Card
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Apply for new card feature coming soon!"),
              backgroundColor: primaryGreen,
            ),
          );
        },
        backgroundColor: primaryRed,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("New Card", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCards() {
    switch (_selectedFilter) {
      case "Credit Cards":
        return cards.where((card) => card["type"].contains("CREDIT")).toList();
      case "Debit Cards":
        return cards.where((card) => card["type"].contains("DEBIT")).toList();
      case "Active":
        return cards.where((card) => card["status"] == "Active").toList();
      case "Blocked":
        return cards.where((card) => card["status"] == "Blocked").toList();
      default:
        return cards;
    }
  }

  // 🔹 Filter Chip Widget
  Widget _filterChip(String label, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (bool value) {
          setState(() => _selectedFilter = value ? label : "All Cards");
        },
        backgroundColor: Colors.white,
        selectedColor: primaryRed,
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        side: BorderSide(color: selected ? primaryRed : Colors.grey.shade300),
      ),
    );
  }

  // 🔹 Action Button Widget
  Widget _actionButton(IconData icon, String label, Color color) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$label feature coming soon!")),
        );
      },
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // 🔹 Single Card UI
  Widget _buildCard(Map<String, dynamic> card, int index) {
    final isCreditCard = card["type"].contains("CREDIT");
    final isBlocked = card["status"] == "Blocked";

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: isBlocked 
              ? Border.all(color: Colors.red.shade300, width: 2)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Header: Status + Type
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isBlocked ? Colors.red.shade100 : primaryGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      card["status"],
                      style: TextStyle(
                        color: isBlocked ? Colors.red.shade800 : primaryGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    card["type"].split(" ")[0], // Show only PLATINUM, GOLD, etc.
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // 🔹 Card Design - Now with Image Option
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                  // Use image if available, otherwise use gradient
                  image: card["image"] != null 
                      ? DecorationImage(
                          image: AssetImage(card["image"]),
                          fit: BoxFit.cover,
                        )
                      : null,
                  gradient: card["image"] == null 
                      ? LinearGradient(
                          colors: (card["gradient"] as List<Color>?) ?? [primaryRed, const Color(0xFFC62828)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                ),
                child: Stack(
                  children: [
                    // Bank Logo - Only show if using gradient (not image)
                    if (card["image"] == null)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Text(
                          card["bank"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    // Card Number - Show on both image and gradient
                    Positioned(
                      top: 50,
                      left: 12,
                      right: 12,
                      child: Text(
                        card["showNumber"] ? "4242 4242 4242 ${card["id"]}123" : card["cardNumber"],
                        style: TextStyle(
                          color: card["image"] != null ? Colors.black : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          shadows: card["image"] != null 
                              ? [
                                  Shadow(
                                    color: Colors.white.withOpacity(0.8),
                                    blurRadius: 4,
                                  )
                                ]
                              : null,
                        ),
                      ),
                    ),

                    // Eye Icon to toggle number visibility
                    Positioned(
                      top: 12,
                      right: 12,
                      child: InkWell(
                        onTap: () => toggleCardNumber(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            card["showNumber"] ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    // Card Type Badge
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          isCreditCard ? "CREDIT" : "DEBIT",
                          style: TextStyle(
                            color: card["image"] != null ? Colors.black : Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            shadows: card["image"] != null 
                                ? [
                                    Shadow(
                                      color: Colors.white.withOpacity(0.8),
                                      blurRadius: 4,
                                    )
                                  ]
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 🔹 Card Details
              if (isCreditCard) ...[
                _detailRow("Available Limit", card["availableLimit"], primaryGreen),
                _detailRow("Used Limit", card["usedLimit"], Colors.orange),
                _detailRow("Due Date", card["dueDate"], Colors.blue),
              ] else ...[
                _detailRow("Available Balance", card["availableBalance"], primaryGreen),
                _detailRow("Linked Account", card["accountLinked"], Colors.blue),
                _detailRow("Daily Limit", card["dailyLimit"], Colors.orange),
              ],

              const Spacer(),

              // 🔹 Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isBlocked ? null : () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isBlocked ? Colors.grey : primaryRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: Text(
                        isBlocked ? "Blocked" : "Manage",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Settings Menu
                  _buildSettingsMenu(card, index),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Detail Row Widget
  Widget _detailRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Settings Menu Widget
  Widget _buildSettingsMenu(Map<String, dynamic> card, int index) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => toggleSettings(index),
          icon: const Icon(Icons.more_vert, color: Colors.black54),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
          ),
        ),
        if (openSettingsFor == index)
          Positioned(
            right: 0,
            bottom: 45,
            child: Container(
              width: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  )
                ],
              ),
              child: Column(
                children: [
                  _menuItem("View Card Details", Icons.info_outline, card),
                  _menuItem("Change PIN", Icons.lock_reset, card),
                  _menuItem("View Statements", Icons.receipt_long, card),
                  _menuItem(
                    card["status"] == "Active" ? "Block Card" : "Unblock Card",
                    card["status"] == "Active" ? Icons.block : Icons.lock_open,
                    card,
                    color: card["status"] == "Active" ? Colors.red : primaryGreen,
                  ),
                  _menuItem("Report Lost/Stolen", Icons.warning_amber, card, color: Colors.red),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // 🔹 Menu Item Widget
  Widget _menuItem(String text, IconData icon, Map<String, dynamic> card, {Color color = Colors.black87}) {
    return InkWell(
      onTap: () => handleSettingsAction(text, card),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/