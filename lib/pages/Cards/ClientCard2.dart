import 'package:flutter/material.dart';

class ClientCard2 extends StatelessWidget {
  ClientCard2({super.key});

  final List<Map<String, dynamic>> transactions = [
    {
      'id': 1,
      'merchant': "Amazon India",
      'card': "Credit Card ****9012",
      'amount': -2500,
      'date': "2025-01-10",
    },
    {
      'id': 2,
      'merchant': "Swiggy",
      'card': "Debit Card ****5678",
      'amount': -450,
      'date': "2025-01-09",
    },
    {
      'id': 3,
      'merchant': "Netflix",
      'card': "Credit Card ****9012",
      'amount': -499,
      'date': "2025-01-08",
    },
    {
      'id': 4,
      'merchant': "Zomato",
      'card': "Debit Card ****5678",
      'amount': -350,
      'date': "2025-01-07",
    },
  ];

  final List<Map<String, dynamic>> summaryCards = [
    {
      'title': 'Cashback Earned',
      'value': '₹2,450',
      'subtitle': 'This month',
      'color': Colors.green,
    },
    {
      'title': 'Reward Points',
      'value': '15,680',
      'subtitle': 'Available to redeem',
      'color': Colors.orange,
    },
    {
      'title': 'Monthly Spend',
      'value': '₹18,750',
      'subtitle': 'Across all cards',
      'color': Colors.red,
    },
    {
      'title': 'EMI Spends',
      'value': '₹12,400',
      'subtitle': 'Active EMIs',
      'color': Colors.blue,
    },
    {
      'title': 'Pending Dues',
      'value': '₹3,200',
      'subtitle': 'Due in 5 days',
      'color': Colors.purple,
    },
    {
      'title': 'Total Cards',
      'value': '3',
      'subtitle': 'Active accounts',
      'color': Colors.teal,
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {'icon': Icons.lock, 'label': 'Block Card', 'color': Colors.red},
    {'icon': Icons.settings, 'label': 'Set PIN', 'color': Colors.orange},
    {'icon': Icons.download, 'label': 'Statement', 'color': Colors.blue},
    {'icon': Icons.phone_android, 'label': 'Mobile Pay', 'color': Colors.green},
  ];

  Widget _formatAmount(dynamic amount) {
    // ✅ Validation for null or invalid types
    if (amount == null || amount is! num) {
      return const Text(
        "₹0",
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );
    }

    final bool isNegative = amount < 0;
    final String amountText = isNegative ? '-₹${amount.abs()}' : '₹$amount';
    return Text(
      amountText,
      style: TextStyle(
        color: isNegative ? Colors.red : Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, bottomInset + 20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildQuickActionsCard(),
            const SizedBox(height: 20),
            _buildTransactionsCard(),
            const SizedBox(height: 20),
            _buildSummaryCardsGrid(context),
          ],
        ),
      ),
    );
  }

  // 🔹 Quick Actions
  Widget _buildQuickActionsCard() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Common card management tasks',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 15),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: quickActions.length,
              itemBuilder: (context, index) {
                final action = quickActions[index];
                // ✅ Validation for required fields
                final icon = action['icon'] is IconData
                    ? action['icon'] as IconData
                    : Icons.help_outline;
                final label = (action['label'] ?? 'Unknown') as String;
                final color = (action['color'] ?? Colors.grey) as Color;

                return _buildActionCard(icon: icon, label: label, color: color);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: color),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Transactions
  Widget _buildTransactionsCard() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Card Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Latest transactions across all cards',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 15),
            Column(
              children: transactions
                  .map((txn) => _buildTransactionRow(txn))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionRow(Map<String, dynamic> txn) {
    final merchant = (txn['merchant'] ?? 'Unknown Merchant').toString();
    final card = (txn['card'] ?? 'Unknown Card').toString();
    final date = (txn['date'] ?? 'N/A').toString();
    final amount = txn['amount'];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.credit_card, size: 28, color: const Color(0xFF950606)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  merchant,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  card,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _formatAmount(amount),
              Text(
                date,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 Summary Cards Grid (2 per row)
  Widget _buildSummaryCardsGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 30),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: summaryCards.length,
      itemBuilder: (context, index) {
        final summary = summaryCards[index];
        final title = (summary['title'] ?? 'N/A').toString();
        final value = (summary['value'] ?? '-').toString();
        final subtitle = (summary['subtitle'] ?? '').toString();
        final color = (summary['color'] ?? Colors.grey) as Color;

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.black.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
