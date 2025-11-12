import 'package:flutter/material.dart';
import 'package:neobank/widgets/layout.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> transactions = [];
  String search = "";

  @override
  void initState() {
    super.initState();

    transactions = [
      {
        "date": "2025-11-03",
        "recipient": "Ajit",
        "type": "Transfer",
        "amount": 1000,
        "status": "Success",
      },
      {
        "date": "2025-11-02",
        "recipient": "Purvi",
        "type": "Bill Payment",
        "amount": 500,
        "status": "Pending",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filtered = transactions.where((tx) {
      final lowerSearch = search.toLowerCase();
      return (tx["recipient"]?.toString().toLowerCase().contains(lowerSearch) ??
              false) ||
          (tx["type"]?.toString().toLowerCase().contains(lowerSearch) ?? false);
    }).toList();

    return AppLayout(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
              color: const Color(0xFF900603),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Transaction History",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "View all your past money transfers, bill payments, and recharges",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Search Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by recipient or type...",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF950606)),
                  ),
                ),
                onChanged: (value) => setState(() => search = value),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  dataRowHeight: 40, // Reduce default row height
                  headingRowHeight: 40, // Reduce header height
                  columnSpacing: 16, // Adjust horizontal spacing
                  headingRowColor: MaterialStateProperty.all(
                    const Color(0xFF900603),
                  ), // Red background

                  columns: const [
                    DataColumn(
                      label: Text(
                        "Date",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Recipient",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Type",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Amount",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Status",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: filtered.isNotEmpty
                      ? filtered.map((tx) {
                          Color statusColor = Colors.white;
                          switch (tx["status"].toString().toLowerCase()) {
                            case "success":
                              statusColor = Colors.green;
                              break;
                            case "pending":
                              statusColor = Colors.orange;
                              break;
                            case "failed":
                              statusColor = Colors.red;
                              break;
                          }
                          return DataRow(
                            cells: [
                              DataCell(Text(tx["date"].toString())),
                              DataCell(Text(tx["recipient"].toString())),
                              DataCell(Text(tx["type"].toString())),
                              DataCell(
                                Text(
                                  "₹${tx["amount"]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  tx["status"].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList()
                      : [
                          const DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  "No transactions found",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                              DataCell.empty,
                            ],
                          ),
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
