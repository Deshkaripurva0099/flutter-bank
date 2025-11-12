import 'package:flutter/material.dart';
import 'package:neobank/pages/dashboard.dart';
import 'package:neobank/pages/imps.dart';
import 'package:neobank/pages/international_transfer_page.dart';
import 'package:neobank/pages/money_transfer_page.dart';
import 'package:neobank/pages/neft.dart';
import 'package:neobank/pages/profile.dart';

import 'package:neobank/pages/rtgs.dart';
import 'package:neobank/pages/send_money_page.dart';


import 'widgets/layout.dart';

import 'pages/MyAccount/ClientMyAccounts.dart';
import 'pages/MyAccount/clientpersonaldetails.dart';
import 'pages/MyAccount/clientaadhar_verification.dart';
import 'pages/MyAccount/clientpanverification.dart';
import 'pages/MyAccount/clientvideokyc.dart';
import 'pages/MyAccount/clientaccountclosure.dart';
import 'pages/MyAccount/clientupdatekyc.dart';
import 'pages/MyAccount/clientaccountstatement.dart';
import 'pages/MyAccount/clientchequebook.dart';

import 'pages/Cards/clientcard.dart';
import 'pages/Cards/clientcard2.dart';
import 'pages/Cards/clientapplynewcard.dart';



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



         // 💼 My Account Section (Wrapped in AppLayout)
        '/myAccount': (context) => AppLayout(child: const MyAccountsPage()),
        '/personalDetails': (context) => AppLayout(child: const PersonalDetailsPage()),
        '/aadharVerification': (context) => AppLayout(child: const AadharVerificationPage()),
        '/panVerification': (context) => AppLayout(child: const PANVerificationPage()),
        '/videoKYC': (context) => AppLayout(child: const VideoKYCPage()),
        '/accountClosure': (context) => AppLayout(child: AccountClosure(accountType: "")),
        '/updateKYC': (context) => AppLayout(child: const UpdateKYC()),
        '/accountStatement': (context) => AppLayout(child: const AccountStatement()),
        '/chequeBookRequest': (context) => AppLayout(child: const ChequeBookRequest()),

        // 💳 Cards Section
        '/cards': (context) => AppLayout(child: const ClientCard()),
        '/ClientCard2': (context) => AppLayout(child: ClientCard2()),
        '/applyNewCard': (context) => AppLayout(child: const ApplyNewCard()),
        
      },
    );
  }
}
