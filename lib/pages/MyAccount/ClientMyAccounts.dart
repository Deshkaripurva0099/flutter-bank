import 'package:flutter/material.dart';

import 'ClientPersonal_Details.dart';
import 'ClientAccountClosure.dart';

const Color primaryRed = Color(0xFF900603);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Accounts (Flutter)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: primaryRed, useMaterial3: true),
      home: const MyAccountsPage(),
    );
  }
}

class MyAccountsPage extends StatefulWidget {
  const MyAccountsPage({super.key});

  @override
  State<MyAccountsPage> createState() => _MyAccountsPageState();
}

class _MyAccountsPageState extends State<MyAccountsPage> {
  bool showNewAccountMenu = false;
  bool showCloseAccountMenu = false;
  bool showAccountDetails = false;
  bool showStatementPopup = false;
  Map<String, dynamic>? selectedAccount;
  bool showAllTransactions = false;

  final List<Map<String, dynamic>> accounts = [
    {
      "id": 1,
      "type": "Savings Account",
      "balance": "₹1,25,480.75",
      "accountNumber": "12345678903456",
      "maskedNumber": "****3456",
      "ifsc": "NEOB0001567",
      "status": "Active",
      "statusColor": "active",
      "openedDate": "2023-05-15",
      "branch": "Mumbai Main",
      "interestRate": "3.5%",
    },
    {
      "id": 2,
      "type": "Current Account",
      "balance": "₹89,250.50",
      "accountNumber": "12345678907890",
      "maskedNumber": "****7890",
      "ifsc": "NEOB0001234",
      "status": "Inactive",
      "statusColor": "inactive",
      "openedDate": "2022-11-20",
      "branch": "Delhi Corporate",
      "interestRate": "0%",
    },
    {
      "id": 3,
      "type": "Fixed Deposit",
      "balance": "₹2,00,000.00",
      "accountNumber": "12345678909123",
      "maskedNumber": "****9123",
      "ifsc": "NEOB0001289",
      "status": "Active",
      "statusColor": "active",
      "openedDate": "2024-01-10",
      "branch": "Bangalore South",
      "interestRate": "6.8%",
      "maturityDate": "2025-07-10",
    },
    {
      "id": 4,
      "type": "Joint Account",
      "balance": "₹1,50,750.00",
      "accountNumber": "12345678904567",
      "maskedNumber": "****4567",
      "ifsc": "NEOB0001456",
      "status": "Active",
      "statusColor": "active",
      "openedDate": "2023-08-05",
      "branch": "Chennai Central",
      "interestRate": "3.5%",
      "jointHolder": "Priya Sharma",
    },
  ];

  final List<Map<String, dynamic>> transactions = [
    {
      "type": "credit",
      "title": "Salary Credit",
      "account": "Savings Account",
      "reference": "TXN123456789",
      "amount": "+₹75,000.00",
      "date": "2025-01-10",
      "icon": "salary",
      "amountColor": "credit",
      "category": "Salary",
    },
    {
      "type": "debit",
      "title": "Online Shopping - Amazon",
      "account": "Current Account",
      "reference": "TXN123456784",
      "amount": "-₹2,500.00",
      "date": "2025-01-09",
      "icon": "shopping",
      "amountColor": "debit",
      "category": "Shopping",
    },
    {
      "type": "credit",
      "title": "Interest Credit",
      "account": "Fixed Deposit",
      "reference": "TXN123456783",
      "amount": "+₹1,250.00",
      "date": "2025-01-08",
      "icon": "interest",
      "amountColor": "credit",
      "category": "Interest",
    },
    {
      "type": "debit",
      "title": "ATM Withdrawal",
      "account": "Savings Account",
      "reference": "TXN123456782",
      "amount": "-₹5,000.00",
      "date": "2025-01-07",
      "icon": "withdrawal",
      "amountColor": "debit",
      "category": "Cash",
    },
    {
      "type": "debit",
      "title": "Credit Card Payment",
      "account": "Current Account",
      "reference": "TXN123456781",
      "amount": "-₹15,200.00",
      "date": "2025-01-06",
      "icon": "creditcard",
      "amountColor": "debit",
      "category": "Payment",
    },
    {
      "type": "credit",
      "title": "Salary Credit",
      "account": "Savings Account",
      "reference": "TXN123456782",
      "amount": "+₹75,000.00",
      "date": "2025-01-01",
      "icon": "wallet",
      "amountColor": "credit",
      "category": "Income",
    },
    {
      "type": "debit",
      "title": "Electricity Bill Payment",
      "account": "Savings Account",
      "reference": "TXN123456783",
      "amount": "-₹2,450.00",
      "date": "2025-01-03",
      "icon": "zap",
      "amountColor": "debit",
      "category": "Utilities",
    },
    {
      "type": "debit",
      "title": "Grocery Purchase",
      "account": "Savings Account",
      "reference": "TXN123456784",
      "amount": "-₹3,200.00",
      "date": "2025-01-04",
      "icon": "shoppingbag",
      "amountColor": "debit",
      "category": "Shopping",
    },
    {
      "type": "credit",
      "title": "UPI Refund",
      "account": "Savings Account",
      "reference": "TXN123456785",
      "amount": "+₹500.00",
      "date": "2025-01-05",
      "icon": "refreshcw",
      "amountColor": "credit",
      "category": "Refund",
    },
    {
      "type": "debit",
      "title": "Mobile Recharge",
      "account": "Current Account",
      "reference": "TXN123456786",
      "amount": "-₹299.00",
      "date": "2025-01-07",
      "icon": "smartphone",
      "amountColor": "debit",
      "category": "Recharge",
    },
    {
      "type": "credit",
      "title": "Cashback Received",
      "account": "Savings Account",
      "reference": "TXN123456787",
      "amount": "+₹120.00",
      "date": "2025-01-08",
      "icon": "gift",
      "amountColor": "credit",
      "category": "Rewards",
    },
    {
      "type": "debit",
      "title": "Movie Ticket",
      "account": "Savings Account",
      "reference": "TXN123456788",
      "amount": "-₹450.00",
      "date": "2025-01-09",
      "icon": "film",
      "amountColor": "debit",
      "category": "Entertainment",
    },
    {
      "type": "credit",
      "title": "Friend Transfer",
      "account": "Current Account",
      "reference": "TXN123456789",
      "amount": "+₹5,000.00",
      "date": "2025-01-10",
      "icon": "userplus",
      "amountColor": "credit",
      "category": "Transfer",
    },
    {
      "type": "debit",
      "title": "Restaurant Bill",
      "account": "Savings Account",
      "reference": "TXN123456790",
      "amount": "-₹1,250.00",
      "date": "2025-01-11",
      "icon": "coffee",
      "amountColor": "debit",
      "category": "Food & Dining",
    },
    {
      "type": "credit",
      "title": "Interest Credited",
      "account": "Savings Account",
      "reference": "TXN123456791",
      "amount": "+₹450.00",
      "date": "2025-01-12",
      "icon": "trendingup",
      "amountColor": "credit",
      "category": "Interest",
    },
    {
      "type": "debit",
      "title": "Online Shopping",
      "account": "Current Account",
      "reference": "TXN123456792",
      "amount": "-₹4,899.00",
      "date": "2025-01-13",
      "icon": "shoppingcart",
      "amountColor": "debit",
      "category": "E-Commerce",
    },
  ];

  final List<Map<String, dynamic>> monthlyStats = [
    {
      "title": "Monthly Inflow",
      "amount": "₹85,000",
      "change": "+5%",
      "changeText": "from last month",
      "amountColor": Colors.green,
      "icon": Icons.trending_up,
    },
    {
      "title": "Monthly Outflow",
      "amount": "₹32,500",
      "change": "-12%",
      "changeText": "from last month",
      "amountColor": Colors.red,
      "icon": Icons.trending_down,
    },
    {
      "title": "Net Savings",
      "amount": "₹52,500",
      "change": "+15%",
      "changeText": "from last month",
      "amountColor": Colors.green,
      "icon": Icons.savings,
    },
  ];

  final List<Map<String, String>> accountOptions = [
    {"name": "Savings", "icon": "wallet"},
    {"name": "Current", "icon": "bank"},
    {"name": "Salary", "icon": "cash"},
    {"name": "Joint Accounts", "icon": "people"},
  ];

  final List<Map<String, String>> statementPeriods = [
    {"label": "Last 7 days", "value": "7days"},
    {"label": "Last 30 days", "value": "30days"},
    {"label": "Last 3 months", "value": "3months"},
    {"label": "Last 6 months", "value": "6months"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> get displayedTransactions {
    return showAllTransactions ? transactions : transactions.take(5).toList();
  }

  void handleViewDetails(Map<String, dynamic> account) {
    setState(() {
      selectedAccount = account;
      showAccountDetails = true;
    });
    showAccountDetailsDialog(account);
  }

  void handleDownloadStatement(Map<String, dynamic> account) {
    setState(() {
      selectedAccount = account;
      showStatementPopup = true;
    });
    showStatementDialog(account);
  }

  void toggleTransactionsView() {
    setState(() {
      showAllTransactions = !showAllTransactions;
    });
  }

  Icon getTransactionIcon(String iconType) {
    switch (iconType) {
      case "salary":
        return const Icon(Icons.wallet, size: 18, color: Colors.green);
      case "shopping":
        return const Icon(Icons.shopping_cart, size: 18, color: Colors.red);
      case "interest":
        return const Icon(Icons.trending_up, size: 18, color: Colors.teal);
      case "withdrawal":
        return const Icon(Icons.money, size: 18, color: Colors.purple);
      case "creditcard":
        return const Icon(Icons.credit_card, size: 18, color: Colors.orange);
      default:
        return const Icon(Icons.swap_horiz, size: 18);
    }
  }

  Color getTransactionAmountColor(String type) {
    return type == "credit" ? Colors.green : Colors.red;
  }

  void showAccountDetailsDialog(Map<String, dynamic> acc) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          acc['type'] ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Balance: ${acc['balance']}",
                    style: const TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Account Number: ${acc['accountNumber'] ?? acc['number'] ?? ''}",
                  ),
                  Text("IFSC: ${acc['ifsc'] ?? ''}"),
                  Text("Branch: ${acc['branch'] ?? ''}"),
                  if (acc['interestRate'] != null)
                    Text("Interest: ${acc['interestRate']}"),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.download),
                        label: const Text("Download Statement"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRed,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          handleDownloadStatement(acc);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showStatementDialog(Map<String, dynamic> acc) {
    String selectedFormat = 'pdf';
    String selectedPeriod = '7days';
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Download Statement",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        acc['type'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      const Text("Select Period:"),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: statementPeriods.map((p) {
                          final value = p['value']!;
                          return ChoiceChip(
                            label: Text(p['label']!),
                            selected: selectedPeriod == value,
                            onSelected: (_) {
                              setStateDialog(() => selectedPeriod = value);
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      const Text("Select Format:"),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text("PDF"),
                            selected: selectedFormat == 'pdf',
                            onSelected: (_) {
                              setStateDialog(() => selectedFormat = 'pdf');
                            },
                          ),
                          ChoiceChip(
                            label: const Text("Excel"),
                            selected: selectedFormat == 'excel',
                            onSelected: (_) {
                              setStateDialog(() => selectedFormat = 'excel');
                            },
                          ),
                          ChoiceChip(
                            label: const Text("CSV"),
                            selected: selectedFormat == 'csv',
                            onSelected: (_) {
                              setStateDialog(() => selectedFormat = 'csv');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.download),
                            label: const Text("Download"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRed,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Statement for ${acc['type']} will be downloaded as $selectedFormat",
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // helper to get responsive crossAxisCount
  int _gridCountForWidth(double w) {
    if (w >= 1200) return 4;
    if (w >= 900) return 3;
    if (w >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      appBar: AppBar(
        backgroundColor: primaryRed,
        toolbarHeight: 75, //  HEIGHT Appbar
        title: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ), // ✅ Added vertical padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "My Accounts",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20, // ✅ SAME FONT SIZE
                ),
              ),
              SizedBox(height: 6), // ✅ More spacing between title and subtitle
              Text(
                "Manage your accounts, view transactions, \nand access banking services",
                style: TextStyle(
                  fontSize: 12, // ✅ SAME FONT SIZE
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Open New Account Dropdown
          PopupMenuButton<int>(
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 1.2),
              ),
              child: Row(
                children: const [
                  Icon(Icons.person_add_alt, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                ],
              ),
            ),
            onSelected: (value) {
              String type = "";
              if (value == 1) type = "Savings";
              if (value == 2) type = "Current";
              if (value == 3) type = "Salary";
              if (value == 4) type = "Joint";

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonalDetailsPage(accountType: type),
                ),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet_outlined),
                  title: Text("Savings"),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.account_balance_outlined),
                  title: Text("Current"),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.payments_outlined),
                  title: Text("Salary"),
                ),
              ),
              const PopupMenuItem(
                value: 4,
                child: ListTile(
                  leading: Icon(Icons.people_alt_outlined),
                  title: Text("Joint Accounts"),
                ),
              ),
            ],
          ),

          // Close Account
          PopupMenuButton<int>(
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 1.2),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_remove_alt_1,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 6),
                ],
              ),
            ),
            onSelected: (value) {
              String type = "";
              if (value == 1) type = "Savings";
              if (value == 2) type = "Current";
              if (value == 3) type = "Salary";
              if (value == 4) type = "Joint";

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountClosure(accountType: type),
                ),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet_outlined),
                  title: Text("Savings"),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.account_balance_outlined),
                  title: Text("Current"),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.payments_outlined),
                  title: Text("Salary"),
                ),
              ),
              const PopupMenuItem(
                value: 4,
                child: ListTile(
                  leading: Icon(Icons.people_alt_outlined),
                  title: Text("Joint Accounts"),
                ),
              ),
            ],
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final crossCount = _gridCountForWidth(width);
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Column(
              children: [
                // Accounts Grid
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: accounts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (context, index) {
                    final acc = accounts[index];
                    final isActive = acc['statusColor'] == 'active';
                    return GestureDetector(
                      onTap: () => handleViewDetails(acc),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x11000000),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo and Status Row
                              Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: primaryRed,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.account_balance,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? Colors.green
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      acc['status'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Account Type
                              Text(
                                acc['type'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Available Balance Label
                              const Text(
                                "Available Balance",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 2),

                              // Balance Amount
                              Text(
                                acc['balance'] ?? '',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryRed,
                                ),
                              ),

                              const Spacer(),

                              // Divider
                              Container(
                                height: 1,
                                color: Colors.grey.shade300,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                              ),

                              // Account Details
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Account Number Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Account Number",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        acc['maskedNumber'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),

                                  // IFSC Code Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "IFSC Code",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        acc['ifsc'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  // Buttons Row
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () =>
                                              handleViewDetails(acc),
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: primaryRed,
                                            side: const BorderSide(
                                              color: primaryRed,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.remove_red_eye,
                                                size: 16,
                                              ),
                                              SizedBox(width: 6),
                                              Text("View Details"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      OutlinedButton(
                                        onPressed: () =>
                                            handleDownloadStatement(acc),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: primaryRed,
                                          side: const BorderSide(
                                            color: primaryRed,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.download,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 22),

                // Services Grid (3 cards)
                LayoutBuilder(
                  builder: (c, box) {
                    final w = box.maxWidth;
                    final columns = (w > 900) ? 3 : (w > 600 ? 2 : 1);
                    return GridView.count(
                      crossAxisCount: columns,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3.2,
                      children: [
                        _serviceCard(Icons.verified, "Update KYC", () {
                          Navigator.pushNamed(context, '/updateKYC');
                        }),
                        _serviceCard(Icons.article, "Account Statement", () {
                          Navigator.pushNamed(context, '/accountStatement');
                        }),
                        _serviceCard(Icons.book_online, "Cheque Book", () {
                          Navigator.pushNamed(context, '/chequeBookRequest');
                        }),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 22),

                // Transactions card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Recent Transactions",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                showAllTransactions
                                    ? "All transactions across all accounts"
                                    : "Latest ${displayedTransactions.length} transactions across all accounts",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: toggleTransactionsView,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRed,
                            ),
                            child: Text(
                              showAllTransactions ? "Show Less" : "View All",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: displayedTransactions.map((txn) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFEDEDED),
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: Center(
                                    child: getTransactionIcon(txn['icon']),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        txn['title'] ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        txn['account'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "Ref: ${txn['reference'] ?? ''}",
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      txn['amount'] ?? '',
                                      style: TextStyle(
                                        color: getTransactionAmountColor(
                                          txn['type'],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      txn['date'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // Monthly stats
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: monthlyStats.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (width > 900) ? 3 : (width > 600 ? 2 : 1),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 3,
                  ),
                  itemBuilder: (context, idx) {
                    final stat = monthlyStats[idx];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(stat['icon'] as IconData),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stat['title'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  stat['amount'] ?? '',
                                  style: TextStyle(
                                    color: stat['amountColor'] as Color,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "${stat['change'] ?? ''} ${stat['changeText'] ?? ''}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _serviceCard(IconData icon, String title, VoidCallback onTap) {
    String buttonText;
    if (title == "Update KYC") {
      buttonText = "Update Now";
    } else if (title == "Account Statement") {
      buttonText = "Download";
    } else if (title == "Cheque Book") {
      buttonText = "Request";
    } else {
      buttonText = "Open";
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: primaryRed,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              width: 90, // ✅ BUTTON WIDTH DECREASED
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ), // ✅ Padding decreased
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12, // ✅ Font size decreased
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



 
 /* import 'package:flutter/material.dart';
  
import 'ClientPersonal_Details.dart'; 
import 'ClientAccountClosure.dart';


const Color primaryRed = Color(0xFF900603);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Accounts (Flutter)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryRed,
        useMaterial3: true,
      ),
      home: const MyAccountsPage(),
    );
  }
}

class MyAccountsPage extends StatefulWidget {
  const MyAccountsPage({super.key});

  @override
  State<MyAccountsPage> createState() => _MyAccountsPageState();
}

class _MyAccountsPageState extends State<MyAccountsPage> {
  bool showNewAccountMenu = false;
  bool showCloseAccountMenu = false;
  bool showAccountDetails = false;
  bool showStatementPopup = false;
  Map<String, dynamic>? selectedAccount;
  bool showAllTransactions = false;

  final List<Map<String, dynamic>> accounts = [
    {
      "id": 1,
      "type": "Savings Account",
      "balance": "₹1,25,480.75",
      "accountNumber": "12345678903456",
      "maskedNumber": "****3456",
      "ifsc": "NEOB0001567",
      "status": "Active",
      "statusColor": "active",
      "openedDate": "2023-05-15",
      "branch": "Mumbai Main",
      "interestRate": "3.5%",
    },
    {
      "id": 2,
      "type": "Current Account",
      "balance": "₹89,250.50",
      "accountNumber": "12345678907890",
      "maskedNumber": "****7890",
      "ifsc": "NEOB0001234",
      "status": "Inactive",
      "statusColor": "inactive",
      "openedDate": "2022-11-20",
      "branch": "Delhi Corporate",
      "interestRate": "0%",
    },
    {
      "id": 3,
      "type": "Fixed Deposit",
      "balance": "₹2,00,000.00",
      "accountNumber": "12345678909123",
      "maskedNumber": "****9123",
      "ifsc": "NEOB0001289",
      "status": "Active",
      "statusColor": "active",
      "openedDate": "2024-01-10",
      "branch": "Bangalore South",
      "interestRate": "6.8%",
      "maturityDate": "2025-07-10",
    },
    {
      "id": 4,
      "type": "Joint Account",
      "balance": "₹1,50,750.00",
      "accountNumber": "12345678904567",
      "maskedNumber": "****4567",
      "ifsc": "NEOB0001456",
      "status": "Active",
      "statusColor": "active",
      "openedDate": "2023-08-05",
      "branch": "Chennai Central",
      "interestRate": "3.5%",
      "jointHolder": "Priya Sharma",
    },
  ];

  final List<Map<String, dynamic>> transactions = [
    {
      "type": "credit",
      "title": "Salary Credit",
      "account": "Savings Account",
      "reference": "TXN123456789",
      "amount": "+₹75,000.00",
      "date": "2025-01-10",
      "icon": "salary",
      "amountColor": "credit",
      "category": "Salary",
    },
    {
      "type": "debit",
      "title": "Online Shopping - Amazon",
      "account": "Current Account",
      "reference": "TXN123456784",
      "amount": "-₹2,500.00",
      "date": "2025-01-09",
      "icon": "shopping",
      "amountColor": "debit",
      "category": "Shopping",
    },
    {
      "type": "credit",
      "title": "Interest Credit",
      "account": "Fixed Deposit",
      "reference": "TXN123456783",
      "amount": "+₹1,250.00",
      "date": "2025-01-08",
      "icon": "interest",
      "amountColor": "credit",
      "category": "Interest",
    },
    {
      "type": "debit",
      "title": "ATM Withdrawal",
      "account": "Savings Account",
      "reference": "TXN123456782",
      "amount": "-₹5,000.00",
      "date": "2025-01-07",
      "icon": "withdrawal",
      "amountColor": "debit",
      "category": "Cash",
    },
    {
      "type": "debit",
      "title": "Credit Card Payment",
      "account": "Current Account",
      "reference": "TXN123456781",
      "amount": "-₹15,200.00",
      "date": "2025-01-06",
      "icon": "creditcard",
      "amountColor": "debit",
      "category": "Payment",
    },
    {
      "type": "credit",
      "title": "Salary Credit",
      "account": "Savings Account",
      "reference": "TXN123456782",
      "amount": "+₹75,000.00",
      "date": "2025-01-01",
      "icon": "wallet",
      "amountColor": "credit",
      "category": "Income",
    },
    {
      "type": "debit",
      "title": "Electricity Bill Payment",
      "account": "Savings Account",
      "reference": "TXN123456783",
      "amount": "-₹2,450.00",
      "date": "2025-01-03",
      "icon": "zap",
      "amountColor": "debit",
      "category": "Utilities",
    },
    {
      "type": "debit",
      "title": "Grocery Purchase",
      "account": "Savings Account",
      "reference": "TXN123456784",
      "amount": "-₹3,200.00",
      "date": "2025-01-04",
      "icon": "shoppingbag",
      "amountColor": "debit",
      "category": "Shopping",
    },
    {
      "type": "credit",
      "title": "UPI Refund",
      "account": "Savings Account",
      "reference": "TXN123456785",
      "amount": "+₹500.00",
      "date": "2025-01-05",
      "icon": "refreshcw",
      "amountColor": "credit",
      "category": "Refund",
    },
    {
      "type": "debit",
      "title": "Mobile Recharge",
      "account": "Current Account",
      "reference": "TXN123456786",
      "amount": "-₹299.00",
      "date": "2025-01-07",
      "icon": "smartphone",
      "amountColor": "debit",
      "category": "Recharge",
    },
    {
      "type": "credit",
      "title": "Cashback Received",
      "account": "Savings Account",
      "reference": "TXN123456787",
      "amount": "+₹120.00",
      "date": "2025-01-08",
      "icon": "gift",
      "amountColor": "credit",
      "category": "Rewards",
    },
    {
      "type": "debit",
      "title": "Movie Ticket",
      "account": "Savings Account",
      "reference": "TXN123456788",
      "amount": "-₹450.00",
      "date": "2025-01-09",
      "icon": "film",
      "amountColor": "debit",
      "category": "Entertainment",
    },
    {
      "type": "credit",
      "title": "Friend Transfer",
      "account": "Current Account",
      "reference": "TXN123456789",
      "amount": "+₹5,000.00",
      "date": "2025-01-10",
      "icon": "userplus",
      "amountColor": "credit",
      "category": "Transfer",
    },
    {
      "type": "debit",
      "title": "Restaurant Bill",
      "account": "Savings Account",
      "reference": "TXN123456790",
      "amount": "-₹1,250.00",
      "date": "2025-01-11",
      "icon": "coffee",
      "amountColor": "debit",
      "category": "Food & Dining",
    },
    {
      "type": "credit",
      "title": "Interest Credited",
      "account": "Savings Account",
      "reference": "TXN123456791",
      "amount": "+₹450.00",
      "date": "2025-01-12",
      "icon": "trendingup",
      "amountColor": "credit",
      "category": "Interest",
    },
    {
      "type": "debit",
      "title": "Online Shopping",
      "account": "Current Account",
      "reference": "TXN123456792",
      "amount": "-₹4,899.00",
      "date": "2025-01-13",
      "icon": "shoppingcart",
      "amountColor": "debit",
      "category": "E-Commerce",
    },
  ];

  final List<Map<String, dynamic>> monthlyStats = [
    {
      "title": "Monthly Inflow",
      "amount": "₹85,000",
      "change": "+5%",
      "changeText": "from last month",
      "amountColor": Colors.green,
      "icon": Icons.trending_up,
    },
    {
      "title": "Monthly Outflow",
      "amount": "₹32,500",
      "change": "-12%",
      "changeText": "from last month",
      "amountColor": Colors.red,
      "icon": Icons.trending_down,
    },
    {
      "title": "Net Savings",
      "amount": "₹52,500",
      "change": "+15%",
      "changeText": "from last month",
      "amountColor": Colors.green,
      "icon": Icons.savings,
    },
  ];

  final List<Map<String, String>> accountOptions = [
    {"name": "Savings", "icon": "wallet"},
    {"name": "Current", "icon": "bank"},
    {"name": "Salary", "icon": "cash"},
    {"name": "Joint Accounts", "icon": "people"},
  ];

  final List<Map<String, String>> statementPeriods = [
    {"label": "Last 7 days", "value": "7days"},
    {"label": "Last 30 days", "value": "30days"},
    {"label": "Last 3 months", "value": "3months"},
    {"label": "Last 6 months", "value": "6months"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> get displayedTransactions {
    return showAllTransactions ? transactions : transactions.take(5).toList();
  }

  void handleViewDetails(Map<String, dynamic> account) {
    setState(() {
      selectedAccount = account;
      showAccountDetails = true;
    });
    showAccountDetailsDialog(account);
  }

  void handleDownloadStatement(Map<String, dynamic> account) {
    setState(() {
      selectedAccount = account;
      showStatementPopup = true;
    });
    showStatementDialog(account);
  }

  void toggleTransactionsView() {
    setState(() {
      showAllTransactions = !showAllTransactions;
    });
  }

  Icon getTransactionIcon(String iconType) {
    switch (iconType) {
      case "salary":
        return const Icon(Icons.wallet, size: 18, color: Colors.green);
      case "shopping":
        return const Icon(Icons.shopping_cart, size: 18, color: Colors.red);
      case "interest":
        return const Icon(Icons.trending_up, size: 18, color: Colors.teal);
      case "withdrawal":
        return const Icon(Icons.money, size: 18, color: Colors.purple);
      case "creditcard":
        return const Icon(Icons.credit_card, size: 18, color: Colors.orange);
      default:
        return const Icon(Icons.swap_horiz, size: 18);
    }
  }

  Color getTransactionAmountColor(String type) {
    return type == "credit" ? Colors.green : Colors.red;
  }

  void showAccountDetailsDialog(Map<String, dynamic> acc) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(acc['type'] ?? '',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("Balance: ${acc['balance']}",
                      style: const TextStyle(
                          color: Colors.green, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text("Account Number: ${acc['accountNumber'] ?? acc['number'] ?? ''}"),
                  Text("IFSC: ${acc['ifsc'] ?? ''}"),
                  Text("Branch: ${acc['branch'] ?? ''}"),
                  if (acc['interestRate'] != null)
                    Text("Interest: ${acc['interestRate']}"),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.download),
                        label: const Text("Download Statement"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRed,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          handleDownloadStatement(acc);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showStatementDialog(Map<String, dynamic> acc) {
    String selectedFormat = 'pdf';
    String selectedPeriod = '7days';
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text("Download Statement",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(acc['type'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    const Text("Select Period:"),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: statementPeriods.map((p) {
                        final value = p['value']!;
                        return ChoiceChip(
                          label: Text(p['label']!),
                          selected: selectedPeriod == value,
                          onSelected: (_) {
                            setStateDialog(() => selectedPeriod = value);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    const Text("Select Format:"),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(label: const Text("PDF"), selected: selectedFormat == 'pdf', onSelected: (_) {
                          setStateDialog(() => selectedFormat = 'pdf');
                        }),
                        ChoiceChip(label: const Text("Excel"), selected: selectedFormat == 'excel', onSelected: (_) {
                          setStateDialog(() => selectedFormat = 'excel');
                        }),
                        ChoiceChip(label: const Text("CSV"), selected: selectedFormat == 'csv', onSelected: (_) {
                          setStateDialog(() => selectedFormat = 'csv');
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.download),
                          label: const Text("Download"),
                          style: ElevatedButton.styleFrom(backgroundColor: primaryRed),
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Statement for ${acc['type']} will be downloaded as $selectedFormat"),
                            ));
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  // helper to get responsive crossAxisCount
  int _gridCountForWidth(double w) {
    if (w >= 1200) return 4;
    if (w >= 900) return 3;
    if (w >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "My Accounts",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Manage your accounts, view transactions, \nand access banking services",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Open New Account Dropdown
          PopupMenuButton<int>(
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 1.2),
              ),
              child: Row(
                children: const [
                  Icon(Icons.person_add_alt, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                ],
              ),
            ),
            onSelected: (value) {
              String type = "";
              if (value == 1) type = "Savings";
              if (value == 2) type = "Current";
              if (value == 3) type = "Salary";
              if (value == 4) type = "Joint";

              

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonalDetailsPage(accountType: type),
                ),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: ListTile(leading: Icon(Icons.account_balance_wallet_outlined), title: Text("Savings"))),
              const PopupMenuItem(value: 2, child: ListTile(leading: Icon(Icons.account_balance_outlined), title: Text("Current"))),
              const PopupMenuItem(value: 3, child: ListTile(leading: Icon(Icons.payments_outlined), title: Text("Salary"))),
              const PopupMenuItem(value: 4, child: ListTile(leading: Icon(Icons.people_alt_outlined), title: Text("Joint Accounts"))),
            ],
          ),

          // Close Account
          PopupMenuButton<int>(
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 1.2),
              ),
              child: Row(
                children: const [
                  Icon(Icons.person_remove_alt_1, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                ],
              ),
            ),
            onSelected: (value) {
              String type = "";
              if (value == 1) type = "Savings";
              if (value == 2) type = "Current";
              if (value == 3) type = "Salary";
              if (value == 4) type = "Joint";

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountClosure(accountType: type),
                ),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet_outlined),
                  title: Text("Savings"),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.account_balance_outlined),
                  title: Text("Current"),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.payments_outlined),
                  title: Text("Salary"),
                ),
              ),
              const PopupMenuItem(
                value: 4,
                child: ListTile(
                  leading: Icon(Icons.people_alt_outlined),
                  title: Text("Joint Accounts"),
                ),
              ),
            ],
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossCount = _gridCountForWidth(width);
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            children: [
              // Accounts Grid
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: accounts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  final acc = accounts[index];
                  final isActive = acc['statusColor'] == 'active';
                  return GestureDetector(
                    onTap: () => handleViewDetails(acc),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6, offset: Offset(0,4))],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo and Status Row
                            Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: primaryRed,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.account_balance, color: Colors.white, size: 20),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isActive ? Colors.green : Colors.grey,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(acc['status'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 12)),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            
                            // Account Type
                            Text(
                              acc['type'] ?? '', 
                              style: const TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            
                            // Available Balance Label
                            const Text(
                              "Available Balance",
                              style: TextStyle(
                                fontSize: 12, 
                                fontWeight: FontWeight.w500, 
                                color: Colors.black54
                              ),
                            ),
                            const SizedBox(height: 2),
                            
                            // Balance Amount
                            Text(
                              acc['balance'] ?? '', 
                              style: const TextStyle(
                                fontSize: 20, 
                                fontWeight: FontWeight.bold, 
                                color: primaryRed
                              ),
                            ),
                            
                            const Spacer(),
                            
                            // Divider
                            Container(
                              height: 1,
                              color: Colors.grey.shade300,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            
                            // Account Details
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Account Number Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Account Number",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      acc['maskedNumber'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                
                                // IFSC Code Row  
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "IFSC Code",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      acc['ifsc'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                
                                // Buttons Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => handleViewDetails(acc),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: primaryRed,
                                          side: const BorderSide(color: primaryRed),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.remove_red_eye, size: 16),
                                            SizedBox(width: 6),
                                            Text("View Details")
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    OutlinedButton(
                                      onPressed: () => handleDownloadStatement(acc),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: primaryRed,
                                        side: const BorderSide(color: primaryRed),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      ),
                                      child: const Icon(Icons.download, size: 16),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 22),

              // Services Grid (3 cards)
              LayoutBuilder(builder: (c, box) {
                final w = box.maxWidth;
                final columns = (w > 900) ? 3 : (w > 600 ? 2 : 1);
                return GridView.count(
                  crossAxisCount: columns,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3.2,
                  children: [
                    _serviceCard(Icons.verified, "Update KYC", () {
                      Navigator.pushNamed(context, '/updateKYC');
                    }),
                    _serviceCard(Icons.article, "Account Statement", () {
                      Navigator.pushNamed(context, '/accountStatement');
                    }),
                    _serviceCard(Icons.book_online, "Cheque Book", () {
                      Navigator.pushNamed(context, '/chequeBookRequest');
                    }),
                  ],
                );
              }),

              const SizedBox(height: 22),

              // Transactions card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Recent Transactions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            Text(
                              showAllTransactions 
                                ? "All transactions across all accounts" 
                                : "Latest ${displayedTransactions.length} transactions across all accounts", 
                              style: const TextStyle(fontSize: 12, color: Colors.black54)
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: toggleTransactionsView,
                          style: ElevatedButton.styleFrom(backgroundColor: primaryRed),
                          child: Text(
                            showAllTransactions ? "Show Less" : "View All", 
                            style: const TextStyle(color: Colors.white)
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: displayedTransactions.map((txn) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFEDEDED)),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade100,
                                ),
                                child: Center(child: getTransactionIcon(txn['icon'])),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(txn['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(txn['account'] ?? '', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                                    const SizedBox(height: 2),
                                    Text("Ref: ${txn['reference'] ?? ''}", style: const TextStyle(fontSize: 11, color: Colors.black45)),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(txn['amount'] ?? '', style: TextStyle(color: getTransactionAmountColor(txn['type']))),
                                  const SizedBox(height: 6),
                                  Text(txn['date'] ?? '', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                                ],
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // Monthly stats
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: monthlyStats.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (width > 900) ? 3 : (width > 600 ? 2 : 1),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, idx) {
                  final stat = monthlyStats[idx];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                          child: Icon(stat['icon'] as IconData),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(stat['title'] ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(stat['amount'] ?? '', style: TextStyle(color: stat['amountColor'] as Color)),
                              const SizedBox(height: 2),
                              Text("${stat['change'] ?? ''} ${stat['changeText'] ?? ''}", style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _serviceCard(IconData icon, String title, VoidCallback onTap) {
    String buttonText;
    if (title == "Update KYC") {
      buttonText = "Update Now";
    } else if (title == "Account Statement") {
      buttonText = "Download";
    } else if (title == "Cheque Book") {
      buttonText = "Request";
    } else {
      buttonText = "Open";
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: primaryRed,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
              ),
              child: Text(buttonText, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
  
  */

  
  
  
  
  
  /*import 'package:flutter/material.dart';
  
  import 'Personal_Details.dart'; 
  import 'AccountClosure.dart';
  



  //void main() {
    //runApp(const MyApp());
  //}

  const Color primaryRed = Color(0xFF900603);

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'My Accounts (Flutter)',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryRed,
          useMaterial3: true,
        ),
        home: const MyAccountsPage(),
      );
    }
  }

  class MyAccountsPage extends StatefulWidget {
    const MyAccountsPage({super.key});

    @override
    State<MyAccountsPage> createState() => _MyAccountsPageState();
  }

  class _MyAccountsPageState extends State<MyAccountsPage> {
    bool showNewAccountMenu = false;
    bool showCloseAccountMenu = false;
    bool showAccountDetails = false;
    bool showStatementPopup = false;
    Map<String, dynamic>? selectedAccount;






    final List<Map<String, dynamic>> accounts = [
      {
        "id": 1,
        "type": "Savings Account",
        "balance": "₹1,25,480.75",
        "accountNumber": "12345678903456",
        "maskedNumber": "****3456",
        "ifsc": "NEOB0001567",
        "status": "Active",
        "statusColor": "active",
        "openedDate": "2023-05-15",
        "branch": "Mumbai Main",
        "interestRate": "3.5%",
      },
      {
        "id": 2,
        "type": "Current Account",
        "balance": "₹89,250.50",
        "accountNumber": "12345678907890",
        "maskedNumber": "****7890",
        "ifsc": "NEOB0001234",
        "status": "Inactive",
        "statusColor": "inactive",
        "openedDate": "2022-11-20",
        "branch": "Delhi Corporate",
        "interestRate": "0%",
      },
      {
        "id": 3,
        "type": "Fixed Deposit",
        "balance": "₹2,00,000.00",
        "accountNumber": "12345678909123",
        "maskedNumber": "****9123",
        "ifsc": "NEOB0001289",
        "status": "Active",
        "statusColor": "active",
        "openedDate": "2024-01-10",
        "branch": "Bangalore South",
        "interestRate": "6.8%",
        "maturityDate": "2025-07-10",
      },
      {
        "id": 4,
        "type": "Joint Account",
        "balance": "₹1,50,750.00",
        "accountNumber": "12345678904567",
        "maskedNumber": "****4567",
        "ifsc": "NEOB0001456",
        "status": "Active",
        "statusColor": "active",
        "openedDate": "2023-08-05",
        "branch": "Chennai Central",
        "interestRate": "3.5%",
        "jointHolder": "Priya Sharma",
      },
    ];

    final List<Map<String, dynamic>> transactions = [
      {
        "type": "credit",
        "title": "Salary Credit",
        "account": "Savings Account",
        "reference": "TXN123456789",
        "amount": "+₹75,000.00",
        "date": "2025-01-10",
        "icon": "salary",
        "amountColor": "credit",
        "category": "Salary",
      },
      {
        "type": "debit",
        "title": "Online Shopping - Amazon",
        "account": "Current Account",
        "reference": "TXN123456784",
        "amount": "-₹2,500.00",
        "date": "2025-01-09",
        "icon": "shopping",
        "amountColor": "debit",
        "category": "Shopping",
      },
      {
        "type": "credit",
        "title": "Interest Credit",
        "account": "Fixed Deposit",
        "reference": "TXN123456783",
        "amount": "+₹1,250.00",
        "date": "2025-01-08",
        "icon": "interest",
        "amountColor": "credit",
        "category": "Interest",
      },
      {
        "type": "debit",
        "title": "ATM Withdrawal",
        "account": "Savings Account",
        "reference": "TXN123456782",
        "amount": "-₹5,000.00",
        "date": "2025-01-07",
        "icon": "withdrawal",
        "amountColor": "debit",
        "category": "Cash",
      },
      {
        "type": "debit",
        "title": "Credit Card Payment",
        "account": "Current Account",
        "reference": "TXN123456781",
        "amount": "-₹15,200.00",
        "date": "2025-01-06",
        "icon": "creditcard",
        "amountColor": "debit",
        "category": "Payment",
      },
      
  {
    "type": "credit",
    "title": "Salary Credit",
    "account": "Savings Account",
    "reference": "TXN123456782",
    "amount": "+₹75,000.00",
    "date": "2025-01-01",
    "icon": "wallet",
    "amountColor": "credit",
    "category": "Income",
  },
  {
    "type": "debit",
    "title": "Electricity Bill Payment",
    "account": "Savings Account",
    "reference": "TXN123456783",
    "amount": "-₹2,450.00",
    "date": "2025-01-03",
    "icon": "zap",
    "amountColor": "debit",
    "category": "Utilities",
  },
  {
    "type": "debit",
    "title": "Grocery Purchase",
    "account": "Savings Account",
    "reference": "TXN123456784",
    "amount": "-₹3,200.00",
    "date": "2025-01-04",
    "icon": "shoppingbag",
    "amountColor": "debit",
    "category": "Shopping",
  },
  {
    "type": "credit",
    "title": "UPI Refund",
    "account": "Savings Account",
    "reference": "TXN123456785",
    "amount": "+₹500.00",
    "date": "2025-01-05",
    "icon": "refreshcw",
    "amountColor": "credit",
    "category": "Refund",
  },
  {
    "type": "debit",
    "title": "Mobile Recharge",
    "account": "Current Account",
    "reference": "TXN123456786",
    "amount": "-₹299.00",
    "date": "2025-01-07",
    "icon": "smartphone",
    "amountColor": "debit",
    "category": "Recharge",
  },
  {
    "type": "credit",
    "title": "Cashback Received",
    "account": "Savings Account",
    "reference": "TXN123456787",
    "amount": "+₹120.00",
    "date": "2025-01-08",
    "icon": "gift",
    "amountColor": "credit",
    "category": "Rewards",
  },
  {
    "type": "debit",
    "title": "Movie Ticket",
    "account": "Savings Account",
    "reference": "TXN123456788",
    "amount": "-₹450.00",
    "date": "2025-01-09",
    "icon": "film",
    "amountColor": "debit",
    "category": "Entertainment",
  },
  {
    "type": "credit",
    "title": "Friend Transfer",
    "account": "Current Account",
    "reference": "TXN123456789",
    "amount": "+₹5,000.00",
    "date": "2025-01-10",
    "icon": "userplus",
    "amountColor": "credit",
    "category": "Transfer",
  },
  {
    "type": "debit",
    "title": "Restaurant Bill",
    "account": "Savings Account",
    "reference": "TXN123456790",
    "amount": "-₹1,250.00",
    "date": "2025-01-11",
    "icon": "coffee",
    "amountColor": "debit",
    "category": "Food & Dining",
  },
  {
    "type": "credit",
    "title": "Interest Credited",
    "account": "Savings Account",
    "reference": "TXN123456791",
    "amount": "+₹450.00",
    "date": "2025-01-12",
    "icon": "trendingup",
    "amountColor": "credit",
    "category": "Interest",
  },
  {
    "type": "debit",
    "title": "Online Shopping",
    "account": "Current Account",
    "reference": "TXN123456792",
    "amount": "-₹4,899.00",
    "date": "2025-01-13",
    "icon": "shoppingcart",
    "amountColor": "debit",
    "category": "E-Commerce",
  },


    ];

    final List<Map<String, dynamic>> monthlyStats = [
      {
        "title": "Monthly Inflow",
        "amount": "₹85,000",
        "change": "+5%",
        "changeText": "from last month",
        "amountColor": Colors.green,
        "icon": Icons.trending_up,
      },
      {
        "title": "Monthly Outflow",
        "amount": "₹32,500",
        "change": "-12%",
        "changeText": "from last month",
        "amountColor": Colors.red,
        "icon": Icons.trending_down,
      },
      {
        "title": "Net Savings",
        "amount": "₹52,500",
        "change": "+15%",
        "changeText": "from last month",
        "amountColor": Colors.green,
        "icon": Icons.savings,
      },
    ];

    final List<Map<String, String>> accountOptions = [
      {"name": "Savings", "icon": "wallet"},
      {"name": "Current", "icon": "bank"},
      {"name": "Salary", "icon": "cash"},
      {"name": "Joint Accounts", "icon": "people"},
    ];

    final List<Map<String, String>> statementPeriods = [
      {"label": "Last 7 days", "value": "7days"},
      {"label": "Last 30 days", "value": "30days"},
      {"label": "Last 3 months", "value": "3months"},
      {"label": "Last 6 months", "value": "6months"},
      {"label": "Custom Range", "value": "custom"},
    ];

    void handleViewDetails(Map<String, dynamic> account) {
      setState(() {
        selectedAccount = account;
        showAccountDetails = true;
      });
      showAccountDetailsDialog(account);
    }

    void handleDownloadStatement(Map<String, dynamic> account) {
      setState(() {
        selectedAccount = account;
        showStatementPopup = true;
      });
      showStatementDialog(account);
    }

    Icon getTransactionIcon(String iconType) {
      switch (iconType) {
        case "salary":
          return const Icon(Icons.wallet, size: 18, color: Colors.green);
        case "shopping":
          return const Icon(Icons.shopping_cart, size: 18, color: Colors.red);
        case "interest":
          return const Icon(Icons.trending_up, size: 18, color: Colors.teal);
        case "withdrawal":
          return const Icon(Icons.money, size: 18, color: Colors.purple);
        case "creditcard":
          return const Icon(Icons.credit_card, size: 18, color: Colors.orange);
        default:
          return const Icon(Icons.swap_horiz, size: 18);
      }
    }

    Color getTransactionAmountColor(String type) {
      return type == "credit" ? Colors.green : Colors.red;
    }

    void showAccountDetailsDialog(Map<String, dynamic> acc) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(acc['type'] ?? '',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text("Balance: ${acc['balance']}",
                        style: const TextStyle(
                            color: Colors.green, fontSize: 16)),
                    const SizedBox(height: 6),
                    Text("Account Number: ${acc['accountNumber'] ?? acc['number'] ?? ''}"),
                    Text("IFSC: ${acc['ifsc'] ?? ''}"),
                    Text("Branch: ${acc['branch'] ?? ''}"),
                    if (acc['interestRate'] != null)
                      Text("Interest: ${acc['interestRate']}"),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.download),
                          label: const Text("Download Statement"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryRed,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            handleDownloadStatement(acc);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    void showStatementDialog(Map<String, dynamic> acc) {
      String selectedFormat = 'pdf';
      String selectedPeriod = '7days';
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStateDialog) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Download Statement",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(acc['type'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      const Text("Select Period:"),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: statementPeriods.map((p) {
                          final value = p['value']!;
                          return ChoiceChip(
                            label: Text(p['label']!),
                            selected: selectedPeriod == value,
                            onSelected: (_) {
                              setStateDialog(() => selectedPeriod = value);
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      const Text("Select Format:"),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          ChoiceChip(label: const Text("PDF"), selected: selectedFormat == 'pdf', onSelected: (_) {
                            setStateDialog(() => selectedFormat = 'pdf');
                          }),
                          ChoiceChip(label: const Text("Excel"), selected: selectedFormat == 'excel', onSelected: (_) {
                            setStateDialog(() => selectedFormat = 'excel');
                          }),
                          ChoiceChip(label: const Text("CSV"), selected: selectedFormat == 'csv', onSelected: (_) {
                            setStateDialog(() => selectedFormat = 'csv');
                          }),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.download),
                            label: const Text("Download"),
                            style: ElevatedButton.styleFrom(backgroundColor: primaryRed),
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Statement for ${acc['type']} will be downloaded as $selectedFormat"),
                              ));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        },
      );
    }

    // helper to get responsive crossAxisCount
    int _gridCountForWidth(double w) {
      if (w >= 1200) return 4;
      if (w >= 900) return 3;
      if (w >= 600) return 2;
      return 1;
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        appBar: AppBar(
    backgroundColor: primaryRed,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "My Accounts",
          style: TextStyle(
            color: Colors.white, // 🔹 Title white
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 2),
        Text(
          "Manage your accounts, view transactions, \nand access banking services",
          style: TextStyle(
            fontSize: 12,
            color: Colors.white, // 🔹 Subtitle white
          ),
        ),
      ],
    ),
    iconTheme: const IconThemeData(color: Colors.white), // 🔹 Makes all icons white
    
    actions: [

      
      // Open New Account Dropdown
  PopupMenuButton<int>(
    offset: const Offset(0, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    icon: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1.2),
      ),
      child: Row(
        children: const [
          Icon(Icons.person_add_alt, color: Colors.white, size: 18),
          SizedBox(width: 6),
        // Text(
          //  "Open New Account",
          //  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        // ),
        ],
      ),
    ),
    onSelected: (value) {
      String type = "";
      if (value == 1) type = "Savings";
      if (value == 2) type = "Current";
      if (value == 3) type = "Salary";
      if (value == 4) type = "Joint";

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PersonalDetailsPage(accountType: type),
        ),
      );
    },
    itemBuilder: (context) => [
      const PopupMenuItem(value: 1, child: ListTile(leading: Icon(Icons.account_balance_wallet_outlined), title: Text("Savings"))),
      const PopupMenuItem(value: 2, child: ListTile(leading: Icon(Icons.account_balance_outlined), title: Text("Current"))),
      const PopupMenuItem(value: 3, child: ListTile(leading: Icon(Icons.payments_outlined), title: Text("Salary"))),
      const PopupMenuItem(value: 4, child: ListTile(leading: Icon(Icons.people_alt_outlined), title: Text("Joint Accounts"))),
    ],
  ),




      // Close Account
    // Close Account
  PopupMenuButton<int>(
    offset: const Offset(0, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    icon: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1.2),
      ),
      child: Row(
        children: const [
          Icon(Icons.person_remove_alt_1, color: Colors.white, size: 18),
          SizedBox(width: 6),
        // Text(
          // "Close Account",
        //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        // ),
        ],
      ),
    ),
  // MyAccounts.dart मध्ये (line ~275)
  // MyAccounts.dart मध्ये (line ~275) हे बदला:

  onSelected: (value) {
    String type = "";
    if (value == 1) type = "Savings";
    if (value == 2) type = "Current";
    if (value == 3) type = "Salary";
    if (value == 4) type = "Joint";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountClosure(accountType: type), // ✅ type वापरा
      ),
    );
  },
    itemBuilder: (context) => [
      const PopupMenuItem(
        value: 1,
        child: ListTile(
          leading: Icon(Icons.account_balance_wallet_outlined),
          title: Text("Savings"),
        ),
      ),
      const PopupMenuItem(
        value: 2,
        child: ListTile(
          leading: Icon(Icons.account_balance_outlined),
          title: Text("Current"),
        ),
      ),
      const PopupMenuItem(
        value: 3,
        child: ListTile(
          leading: Icon(Icons.payments_outlined),
          title: Text("Salary"),
        ),
      ),
      const PopupMenuItem(
        value: 4,
        child: ListTile(
          leading: Icon(Icons.people_alt_outlined),
          title: Text("Joint Accounts"),
        ),
      ),
    ],
  ),
    ],
  ),

      body: LayoutBuilder(builder: (context, constraints) {
    final width = constraints.maxWidth;
    final crossCount = _gridCountForWidth(width);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        children: [
          // Accounts Grid
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: accounts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.25, // 👈 height कमी करण्यासाठी aspect ratio increase केले
            ),
            itemBuilder: (context, index) {
              final acc = accounts[index];
              final isActive = acc['statusColor'] == 'active';
              return GestureDetector(
                onTap: () => handleViewDetails(acc),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6, offset: Offset(0,4))],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo and Status Row
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: primaryRed,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.account_balance, color: Colors.white, size: 20),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isActive ? Colors.green : Colors.grey,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(acc['status'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 12)),
                            )
                          ],
                        ),
                        const SizedBox(height: 8), // 👈 spacing कमी केले (12 → 8)
                        
                        // Account Type
                        Text(
                          acc['type'] ?? '', 
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6), // 👈 spacing कमी केले (8 → 6)
                        
                        // Available Balance Label
                        const Text(
                          "Available Balance",
                          style: TextStyle(
                            fontSize: 12, 
                            fontWeight: FontWeight.w500, 
                            color: Colors.black54
                          ),
                        ),
                        const SizedBox(height: 2), // 👈 spacing कमी केले (4 → 2)
                        
                        // Balance Amount
                        Text(
                          acc['balance'] ?? '', 
                          style: const TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold, 
                            color: primaryRed
                          ),
                        ),
                        
                        const Spacer(),
                        
                        // Divider
                        Container(
                          height: 1,
                          color: Colors.grey.shade300,
                          margin: const EdgeInsets.symmetric(vertical: 8), // 👈 spacing कमी केले (12 → 8)
                        ),
                        
                        // Account Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Account Number Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Account Number",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  acc['maskedNumber'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4), // spacing कमी केले (8 → 4)
                            
                            // IFSC Code Row  
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "IFSC Code",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  acc['ifsc'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8), // 👈 spacing कमी केले (12 → 8)
                            
                            // Buttons Row
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () => handleViewDetails(acc),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: primaryRed,
                                      side: const BorderSide(color: primaryRed),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      padding: const EdgeInsets.symmetric(vertical: 8), // 👈 padding कमी केले
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.remove_red_eye, size: 16),
                                        SizedBox(width: 6),
                                        Text("View Details")
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: () => handleDownloadStatement(acc),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: primaryRed,
                                    side: const BorderSide(color: primaryRed),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // 👈 padding कमी केले
                                  ),
                                  child: const Icon(Icons.download, size: 16),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
                const SizedBox(height: 22),

                // Services Grid (3 cards)
                LayoutBuilder(builder: (c, box) {
                  final w = box.maxWidth;
                  final columns = (w > 900) ? 3 : (w > 600 ? 2 : 1);
                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 3.2,
                    children: [
                    _serviceCard(Icons.verified, "Update KYC", () {
                  Navigator.pushNamed(context, '/updateKYC'); // ✅ route वापरून navigation
  }),
                      _serviceCard(Icons.article, "Account Statement", () {
                          Navigator.pushNamed(context, '/accountStatement');
                      }),
                      _serviceCard(Icons.book_online, "Cheque Book", () {
                        Navigator.pushNamed(context, '/chequeBookRequest');

                       // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cheque Book clicked")));
                      }),
                    ],
                  );
                }),

                const SizedBox(height: 22),

                // Transactions card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Recent Transactions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 4),
                              Text("Latest transactions across all accounts", style: TextStyle(fontSize: 12, color: Colors.black54)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("View All clicked")));
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: primaryRed),
                            child: const Text("View All", style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: transactions.map((txn) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFEDEDED)),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: Center(child: getTransactionIcon(txn['icon'])),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(txn['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Text(txn['account'] ?? '', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                                      const SizedBox(height: 2),
                                      Text("Ref: ${txn['reference'] ?? ''}", style: const TextStyle(fontSize: 11, color: Colors.black45)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(txn['amount'] ?? '', style: TextStyle(color: getTransactionAmountColor(txn['type']))),
                                    const SizedBox(height: 6),
                                    Text(txn['date'] ?? '', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // Monthly stats
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: monthlyStats.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (width > 900) ? 3 : (width > 600 ? 2 : 1),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 3,
                  ),
                  itemBuilder: (context, idx) {
                    final stat = monthlyStats[idx];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                            child: Icon(stat['icon'] as IconData),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(stat['title'] ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(stat['amount'] ?? '', style: TextStyle(color: stat['amountColor'] as Color)),
                                const SizedBox(height: 2),
                                Text("${stat['change'] ?? ''} ${stat['changeText'] ?? ''}", style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          );
        }),
      );
    }
  Widget _serviceCard(IconData icon, String title, VoidCallback onTap) {
    // Choose button text dynamically
    String buttonText;
    if (title == "Update KYC") {
      buttonText = "Update Now";
    } else if (title == "Account Statement") {
      buttonText = "Download";
    } else if (title == "Cheque Book") {
      buttonText = "Request";
    } else {
      buttonText = "Open";
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: primaryRed,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
              ),
              child: Text(buttonText, style: const TextStyle(color: Colors.white)), // 🔹 White text
            ),
          ],
        ),
      ),
    );
  }
  } */