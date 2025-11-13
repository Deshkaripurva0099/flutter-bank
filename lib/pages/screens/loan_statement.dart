import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/loan_model.dart';
//import '../widgets/common_widgets.dart';
import 'package:intl/intl.dart';

class LoanStatementScreen extends StatefulWidget {
  const LoanStatementScreen({super.key});

  @override
  State<LoanStatementScreen> createState() => _LoanStatementScreenState();
}

class _LoanStatementScreenState extends State<LoanStatementScreen> {
  String _selectedFilter = '3';
  bool _showStatement = false;

  final List<LoanTransaction> _allTransactions = [
    LoanTransaction(date: DateTime(2025, 9, 1), description: 'EMI Payment', amount: -10000),
    LoanTransaction(date: DateTime(2025, 8, 1), description: 'EMI Payment', amount: -10000),
    LoanTransaction(date: DateTime(2025, 7, 1), description: 'EMI Payment', amount: -10000),
    LoanTransaction(date: DateTime(2025, 6, 1), description: 'EMI Payment', amount: -10000),
    LoanTransaction(date: DateTime(2025, 5, 1), description: 'EMI Payment', amount: -10000),
    LoanTransaction(date: DateTime(2025, 4, 1), description: 'EMI Payment', amount: -10000),
    LoanTransaction(date: DateTime(2025, 3, 1), description: 'EMI Payment', amount: -10000),
    LoanTransaction(date: DateTime(2025, 2, 1), description: 'EMI Payment', amount: -10000),
    LoanTransaction(date: DateTime(2025, 1, 1), description: 'EMI Payment', amount: -10000),
  ];

  List<LoanTransaction> get _filteredTransactions {
    if (_selectedFilter == 'all') {
      return _allTransactions;
    }

    int months = int.parse(_selectedFilter);
    DateTime cutoff = DateTime.now().subtract(Duration(days: months * 30));

    return _allTransactions.where((t) => t.date.isAfter(cutoff)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sortedTransactions = _filteredTransactions.toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Statement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showStatement = !_showStatement;
                      });
                    },
                    child: Text(_showStatement ? 'Hide Statement' : 'View Statement'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
            
            if (_showStatement) ...[
              const SizedBox(height: 20),
              
              // Filter Dropdown
              Row(
                children: [
                  const Text(
                    'View for: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedFilter,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: '3', child: Text('Last 3 Months')),
                        DropdownMenuItem(value: '6', child: Text('Last 6 Months')),
                        DropdownMenuItem(value: '9', child: Text('Last 9 Months')),
                        DropdownMenuItem(value: '12', child: Text('Last 12 Months')),
                        DropdownMenuItem(value: '15', child: Text('Last 15 Months')),
                        DropdownMenuItem(value: 'all', child: Text('All Transactions')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedFilter = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Transaction Table
              Expanded(
                child: Card(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(
                        AppConstants.primaryRed.withOpacity(0.1),
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Amount',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: sortedTransactions.isEmpty
                          ? [
                              const DataRow(
                                cells: [
                                  DataCell(Text('No transactions')),
                                  DataCell(Text('-')),
                                  DataCell(Text('-')),
                                ],
                              ),
                            ]
                          : sortedTransactions.map((transaction) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(DateFormat('dd/MM/yyyy').format(transaction.date)),
                                  ),
                                  DataCell(Text(transaction.description)),
                                  DataCell(
                                    Text(
                                      transaction.amount < 0
                                          ? '-₹${transaction.amount.abs().toStringAsFixed(0)}'
                                          : '+₹${transaction.amount.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        color: transaction.amount < 0
                                            ? AppConstants.dangerRed
                                            : AppConstants.successGreen,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}