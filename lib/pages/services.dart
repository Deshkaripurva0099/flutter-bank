import 'package:flutter/material.dart';
import 'servicesstyle.dart'; // ✅ Import your style file
import 'neobank_account_open_form.dart'; // Import the new form
import 'fixed_deposit.dart'; // Import Fixed Deposit form
import 'rd_page.dart'; // Import RD Page
import 'deposit.dart';
import '../widgets/layout.dart'; // Import AppLayout
import 'screens/loan_dashboard.dart'; // Import LoanDashboard

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  String? selectedService;
  Map<String, bool> hoveredServices = {};

  // 🔹 Service Categories
  final List<Map<String, dynamic>> serviceCategories = [
    {
      "category": "Accounts",
      "services": [
        {"label": "Open Savings Account", "icon": "🏦"},
        {"label": "Fixed Deposit", "icon": "💰"},
        {"label": "Recurring Deposit (RD)", "icon": "🗓️"},
        {"label": "Deposit", "icon": "💸"},
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
      "category": "Payment",
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
    {
      "category": "Popular Services",
      "services": [
        {"label": "UPI Payments", "icon": "📲"},
        {"label": "Fund Transfer", "icon": "💸"},
        {"label": "Bill Payments", "icon": "🧾"},
        {"label": "Mobile Banking", "icon": "📱"},
      ],
    },
  ];

  // 🔹 Handle proceed
  void handleProceed(String service) {
    if (service == "Open Savings Account") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NeobankAccountOpenForm()),
      );
    } else if (service == "Fixed Deposit") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FdCalculatorPage()),
      );
    } else if (service == "Recurring Deposit (RD)") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RDPage()),
      );
    } else if (service == "Deposit") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DepositsPageUnique()),
      );
    } else if (service == "Loan Services" ||
        service == "Loan Eligibility Check" ||
        service == "EMI Calculator") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoanDashboard()),
      );
    } else if (service == "Credit Card Services" ||
        service == "Block / Unblock Card" ||
        service == "Change Card PIN") {
      Navigator.pushNamed(context, '/cards');
    } else if (service == "Set Spending Limit" ||
        service == "Fund Transfer" ||
        service == "UPI Payments" ||
        service == "Bill Payments" ||
        service == "Add Beneficiary" ||
        service == "Mobile Banking") {
      Navigator.pushNamed(context, '/pages/money_transfer_page');
    } else if (service == "Report Fraud" ||
        service == "Raise Service Request" ||
        service == "Feedback / Complaint" ||
        service == "Stop Cheque Payment" ||
        service == "Cheque Book Request") {
      Navigator.pushNamed(context, '/complaints');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Proceeding with $service...')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 246, 243, 243),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== HEADER =====
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 24,
                    ),
                    decoration: const BoxDecoration(color: Color(0xFF900603)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Services",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Explore all the banking services we provide",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 🔹 Category-wise list
                  ...serviceCategories.map((cat) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            cat["category"],
                            style: kCategoryTitleStyle,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 1.2,
                          children: List.generate(
                            (cat["services"] as List).length,
                            (index) {
                              final service = cat["services"][index];
                              final serviceLabel = service["label"];
                              final isHovered =
                                  hoveredServices[serviceLabel] ?? false;
                              return MouseRegion(
                                onEnter: (_) => setState(
                                  () => hoveredServices[serviceLabel] = true,
                                ),
                                onExit: (_) => setState(
                                  () => hoveredServices[serviceLabel] = false,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedService = serviceLabel;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      left: 16,
                                      top: 6,
                                      right: 6,
                                      bottom: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isHovered
                                          ? const Color.fromARGB(
                                              255,
                                              154,
                                              13,
                                              3,
                                            )
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            service["icon"],
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8.0,
                                                  ),
                                              child: Text(
                                                serviceLabel,
                                                textAlign: TextAlign.center,
                                                style: kCardTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          if (selectedService != null)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => selectedService = null),
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedService!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'You selected "$selectedService". Proceed further…',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    218,
                                    128,
                                    128,
                                  ),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () =>
                                    setState(() => selectedService = null),
                                child: const Text("Close"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    172,
                                    45,
                                    22,
                                  ),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () =>
                                    handleProceed(selectedService!),
                                child: const Text("Proceed"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
