import 'package:flutter/material.dart';

// 🔹 Style Constants
const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 16,
  color: Color.fromARGB(135, 2, 2, 2),
);

const TextStyle kCategoryTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 184, 28, 28),
);

final BoxDecoration kCardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  boxShadow: [
    BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
  ],
);

const TextStyle kCardTextStyle = TextStyle(fontSize: 14, color: Colors.black);

class ServicesStyle extends StatefulWidget {
  const ServicesStyle({super.key});

  @override
  State<ServicesStyle> createState() => _ServicesStyleState();
}

class _ServicesStyleState extends State<ServicesStyle> {
  String? selectedService;

  // 🔹 Categories with services
  final List<Map<String, dynamic>> serviceCategories = [
    {
      "category": "Accounts",
      "services": [
        {"label": "Open Savings Account", "icon": "🏦"},
        {"label": "Fixed Deposit", "icon": "💰"},
        {"label": "Recurring Deposit (RD)", "icon": "🗓️"},
        {"label": "Government Schemes (PPF/SSY)", "icon": "🏦"},
      ],
    },
    {
      "category": "Loans",
      "services": [
        {"label": "Loan Services", "icon": "📄"},
        {"label": "Loan Eligibility Check", "icon": "📌"},
        {"label": "EMI Calculator", "icon": "🧮"},
      ],
    },
    {
      "category": "Cards",
      "services": [
        {"label": "Credit Card Services", "icon": "💳"},
        {"label": "Block / Unblock Card", "icon": "🛑"},
        {"label": "Change Card PIN", "icon": "🔐"},
        {"label": "Set Spending Limit", "icon": "📉"},
      ],
    },
    {
      "category": "Payments",
      "services": [
        {"label": "Fund Transfer", "icon": "💸"},
        {"label": "UPI Payments", "icon": "📲"},
        {"label": "Bill Payments", "icon": "🧾"},
        {"label": "Add Beneficiary", "icon": "👤"},
      ],
    },
    {
      "category": "Digital Banking",
      "services": [
        {"label": "Mobile Banking Registration", "icon": "📱"},
        {"label": "Internet Banking Activation", "icon": "🖥️"},
        {"label": "Reset / Change Password", "icon": "🔑"},
        {"label": "e-Statement Subscription", "icon": "🧾"},
      ],
    },
    {
      "category": "Security & Support",
      "services": [
        {"label": "Report Fraud", "icon": "⚠️"},
        {"label": "Raise Service Request", "icon": "🗣️"},
        {"label": "Feedback / Complaint", "icon": "✉️"},
        {"label": "Stop Cheque Payment", "icon": "❌"},
        {"label": "Cheque Book Request", "icon": "📜"},
      ],
    },
  ];

  // 🔹 Popular services
  final List<Map<String, dynamic>> popularServices = [
    {"label": "UPI Payments", "icon": "📲"},
    {"label": "Fund Transfer", "icon": "💸"},
    {"label": "Bill Payments", "icon": "🧾"},
    {"label": "Mobile Banking", "icon": "📱"},
  ];

  // 🔹 Map each service to a route
  final Map<String, String> serviceRoutes = {
    "Open Savings Account": "/Client/Welcome",
    "Fixed Deposit": "/Client/fd-calculator",
    "Recurring Deposit (RD)": "/Client/recurring-deposit",
    "Government Schemes (PPF/SSY)": "/ppf",
    "Loan Services": "/Client/Loan",
    "Loan Eligibility Check": "/Client/Loan",
    "EMI Calculator": "/Client/Loan",
    "Credit Card Services": "/Client/cards",
    "Block / Unblock Card": "/Client/cards",
    "Change Card PIN": "/Client/cards",
    "Set Spending Limit": "/Client/money-transfer",
    "Fund Transfer": "/Client/money-transfer",
    "UPI Payments": "/Client/send-money",
    "Bill Payments": "/Client/pay-bills",
    "Add Beneficiary": "/addBeneficiary",
    "Mobile Banking Registration": "/mobileBanking",
    "Internet Banking Activation": "/internetBanking",
    "Reset / Change Password": "/Client/Setting",
    "e-Statement Subscription": "/Client/account-statement",
    "Report Fraud": "/Client/complaintfeedback",
    "Raise Service Request": "/Client/complaintfeedback",
    "Feedback / Complaint": "/Client/complaintfeedback",
    "Stop Cheque Payment": "/Client/stopCheque",
    "Cheque Book Request": "/Client/chequeBook",
  };

  // 🔹 Handle Proceed
  void handleProceed(String service) {
    if (serviceRoutes.containsKey(service)) {
      // In real app, use Navigator.pushNamed(context, serviceRoutes[service]!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Navigate to: ${serviceRoutes[service]}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No route defined for "$service"')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("Our Services"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Explore all the banking services we provide",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),

            // 🔹 Category-wise services
            ...serviceCategories.map((cat) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cat["category"],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(cat["services"].length, (i) {
                      final service = cat["services"][i];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedService = service["label"];
                          });
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  service["icon"],
                                  style: const TextStyle(fontSize: 28),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  service["label"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 26),
                ],
              );
            }),

            // 🔹 Popular Services
            const SizedBox(height: 20),
            const Text(
              "Popular Services",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: popularServices.map((service) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedService = service["label"];
                    });
                  },
                  child: Card(
                    color: Colors.deepPurple[50],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            service["icon"],
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            service["label"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // 🔹 Modal (Dialog)
            if (selectedService != null)
              _buildServiceDialog(context, selectedService!),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceDialog(BuildContext context, String service) {
    return AlertDialog(
      title: Text(service),
      content: Text('You have selected "$service". Proceed further…'),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              selectedService = null;
            });
          },
          child: const Text("Close"),
        ),
        ElevatedButton(
          onPressed: () {
            handleProceed(service);
            setState(() {
              selectedService = null;
            });
          },
          child: const Text("Proceed"),
        ),
      ],
    );
  }
}
