import 'package:flutter/material.dart';
import 'package:neobank/pages/dashboard.dart';
import 'package:neobank/pages/imps.dart';
import 'package:neobank/pages/international_transfer_page.dart';
import 'package:neobank/pages/money_transfer_page.dart';
import 'package:neobank/pages/neft.dart';
import 'package:neobank/pages/profile.dart';
import 'package:neobank/pages/services.dart';
import 'package:neobank/pages/deposit.dart';

import 'package:neobank/pages/rtgs.dart';
import 'package:neobank/pages/send_money_page.dart';

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
        '/pages/services': (context) => const ServicesPage(),
        '/pages/deposit': (context) => const DepositsPageUnique(),
      },
    );
  }
}
