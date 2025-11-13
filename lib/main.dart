import 'package:flutter/material.dart';
import 'package:neobank/pages/dashboard.dart';
import 'package:neobank/pages/imps.dart';
import 'package:neobank/pages/international_transfer_page.dart';
import 'package:neobank/pages/money_transfer_page.dart';
import 'package:neobank/pages/neft.dart';
import 'package:neobank/pages/profile.dart';
import 'package:neobank/pages/rtgs.dart';
import 'package:neobank/pages/screens/loan_dashboard.dart';
import 'package:neobank/pages/screens/loan_products.dart';
import 'package:neobank/pages/send_money_page.dart';
import 'package:neobank/pages/screens/settings/settings_screen.dart';

void main() {
  runApp(const NeoBankApp());
}

class NeoBankApp extends StatefulWidget {
  const NeoBankApp({super.key});

  @override
  State<NeoBankApp> createState() => _NeoBankAppState();
}

class _NeoBankAppState extends State<NeoBankApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DashboardPage(),
      routes: {
        '/pages/money_transfer_page': (context) => const MoneyTransferPage(),
        '/pages/dashboard': (context) => const DashboardPage(),
        '/pages/neft': (context) => NEFTFormPage(),
        '/pages/imps': (context) => ImpsFormPage(),
        '/pages/rtgs': (context) => RtgsFormPage(),
        '/pages/send_money_page': (context) => SendMoneyPage(),
        '/pages/international_transfer_page': (context) =>
            const InternationalTransferPage(),
        '/pages/profile': (context) => ProfileSection(),
        '/pages/screens/loan_dashboard': (context) => const LoanDashboard(),
        '/pages/screens/settings_screen': (context) => const SettingsScreen(),

        // ✅ Added missing route to fix your error
        '/client/loan-products': (context) => const LoanProducts(),
      },
    );
  }
}
