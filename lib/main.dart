import 'package:flutter/material.dart';

// Splash & Auth
import 'package:neobank/pages/splash_screen.dart';
import 'package:neobank/pages/SignIN/signupscreen.dart';

// Money Transfer & Dashboard
import 'package:neobank/pages/Money/dashboard.dart';
import 'package:neobank/pages/Money/money_transfer_page.dart';
import 'package:neobank/pages/Money/send_money_page.dart';
import 'package:neobank/pages/Money/international_transfer_page.dart';
import 'package:neobank/pages/Money/neft.dart';
import 'package:neobank/pages/Money/imps.dart';
import 'package:neobank/pages/Money/rtgs.dart';

// My Account
import 'package:neobank/pages/MyAccount/ClientMyAccounts.dart';
import 'package:neobank/pages/MyAccount/clientpersonaldetails.dart';
import 'package:neobank/pages/MyAccount/clientaadhar_verification.dart';
import 'package:neobank/pages/MyAccount/clientpanverification.dart';
import 'package:neobank/pages/MyAccount/clientvideokyc.dart';
import 'package:neobank/pages/MyAccount/clientaccountclosure.dart';
import 'package:neobank/pages/MyAccount/clientupdatekyc.dart';
import 'package:neobank/pages/MyAccount/clientaccountstatement.dart';
import 'package:neobank/pages/MyAccount/clientchequebook.dart';

// Cards
import 'package:neobank/pages/Cards/clientcard.dart';
import 'package:neobank/pages/Cards/clientcard2.dart';
import 'package:neobank/pages/Cards/clientapplynewcard.dart';

// Other Pages
import 'package:neobank/pages/profile.dart';
import 'package:neobank/pages/services.dart';
import 'package:neobank/pages/deposit.dart';
import 'package:neobank/pages/complaintandfeedback/complaint_feedback.dart';
import 'package:neobank/pages/investment/investment_page.dart';

// Layout
import 'widgets/layout.dart';

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
      home: const SplashScreen(),
      routes: {
        // Auth
        '/signup': (context) => const SignupScreen(),

        // Money
        '/dashboard': (context) => const DashboardPage(),
        '/moneyTransfer': (context) => const MoneyTransferPage(),
        '/sendMoney': (context) => const SendMoneyPage(),
        '/internationalTransfer': (context) =>
            const InternationalTransferPage(),
        '/neft': (context) => NEFTFormPage(),
        '/imps': (context) => ImpsFormPage(),
        '/rtgs': (context) => RtgsFormPage(),

        // Profile
        '/profile': (context) => ProfileSection(),

        // Services
        '/services': (context) => const ServicesPage(),
        '/deposit': (context) => const DepositsPageUnique(),
        '/complaints': (context) => ComplaintFeedback(),
        '/investment': (context) => InvestmentPage(),

        // My Account (Wrapped in AppLayout)
        '/myAccount': (context) => MyAccountsPage(),
        '/personalDetails': (context) =>
            AppLayout(child: const PersonalDetailsPage()),
        '/aadharVerification': (context) =>
            AppLayout(child: const AadharVerificationPage()),
        '/panVerification': (context) =>
            AppLayout(child: const PANVerificationPage()),
        '/videoKYC': (context) => AppLayout(child: const VideoKYCPage()),
        '/accountClosure': (context) =>
            AppLayout(child: AccountClosure(accountType: "")),
        '/updateKYC': (context) => AppLayout(child: const UpdateKYC()),
        '/accountStatement': (context) =>
            AppLayout(child: const AccountStatement()),
        '/chequeBookRequest': (context) =>
            AppLayout(child: const ChequeBookRequest()),

        // Cards (Wrapped in AppLayout)
        '/cards': (context) => AppLayout(child: const ClientCard()),
        '/clientCard2': (context) => AppLayout(child: ClientCard2()),
        '/applyNewCard': (context) => AppLayout(child: const ApplyNewCard()),
      },
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:neobank/pages/Cards/ClienCard.dart';
// import 'package:neobank/pages/Money/dashboard.dart';
// import 'package:neobank/pages/Money/imps.dart';
// import 'package:neobank/pages/Money/international_transfer_page.dart';
// import 'package:neobank/pages/Money/money_transfer_page.dart';
// import 'package:neobank/pages/Money/neft.dart';
// import 'package:neobank/pages/Money/rtgs.dart';
// import 'package:neobank/pages/Money/send_money_page.dart';
// import 'package:neobank/pages/MyAccount/ClientMyAccounts.dart';
// import 'package:neobank/pages/SignIN/signupscreen.dart';
// import 'package:neobank/pages/complaintandfeedback/complaint_feedback.dart';
// import 'package:neobank/pages/investment/investment_page.dart';
// import 'package:neobank/pages/profile.dart';

// import 'package:neobank/pages/services.dart';
// import 'package:neobank/pages/deposit.dart';

// import 'package:neobank/pages/splash_screen.dart';

// import 'widgets/layout.dart';

// import 'pages/MyAccount/ClientMyAccounts.dart';
// import 'pages/MyAccount/clientpersonaldetails.dart';
// import 'pages/MyAccount/clientaadhar_verification.dart';
// import 'pages/MyAccount/clientpanverification.dart';
// import 'pages/MyAccount/clientvideokyc.dart';
// import 'pages/MyAccount/clientaccountclosure.dart';
// import 'pages/MyAccount/clientupdatekyc.dart';
// import 'pages/MyAccount/clientaccountstatement.dart';
// import 'pages/MyAccount/clientchequebook.dart';

// import 'pages/Cards/clientcard.dart' hide ClientCard;
// import 'pages/Cards/clientcard2.dart';
// import 'pages/Cards/clientapplynewcard.dart';

// void main() {
//   runApp(const NeoBankApp());
// }

// class NeoBankApp extends StatefulWidget {
//   const NeoBankApp({super.key});

//   @override
//   State<NeoBankApp> createState() => _NeoBankAppState();
// }

// class _NeoBankAppState extends State<NeoBankApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const SplashScreen(),
//       routes: {
//         '/signup': (context) => const SignupScreen(),
//         '/pages/money_transfer_page': (context) => const MoneyTransferPage(),

//         '/pages/dashboard': (context) => const DashboardPage(),
//         '/pages/neft': (context) => NEFTFormPage(),
//         '/pages/imps': (context) => ImpsFormPage(),
//         '/pages/rtgs': (context) => RtgsFormPage(),
//         '/pages/send_money_page': (context) => SendMoneyPage(),
//         '/pages/international_transfer_page': (context) =>
//             const InternationalTransferPage(),
//         '/pages/profile': (context) => ProfileSection(),

//         // '/pages/my_account': (context) => MyApp(),
//         // '/pages/cards': (context) => ClientCard(),
//         '/pages/complaintandfeedback': (context) => ComplaintFeedback(),
//         '/pages/investment': (context) => InvestmentPage(),

//         '/pages/services': (context) => const ServicesPage(),
//         '/pages/deposit': (context) => const DepositsPageUnique(),

//         // 💼 My Account Section (Wrapped in AppLayout)
//         '/myAccount': (context) => MyAccountsPage(),
//         '/personalDetails': (context) =>
//             AppLayout(child: const PersonalDetailsPage()),
//         '/aadharVerification': (context) =>
//             AppLayout(child: const AadharVerificationPage()),
//         '/panVerification': (context) =>
//             AppLayout(child: const PANVerificationPage()),
//         '/videoKYC': (context) => AppLayout(child: const VideoKYCPage()),
//         '/accountClosure': (context) =>
//             AppLayout(child: AccountClosure(accountType: "")),
//         '/updateKYC': (context) => AppLayout(child: const UpdateKYC()),
//         '/accountStatement': (context) =>
//             AppLayout(child: const AccountStatement()),
//         '/chequeBookRequest': (context) =>
//             AppLayout(child: const ChequeBookRequest()),

//         // 💳 Cards Section
//         '/cards': (context) => AppLayout(child: const ClientCard()),
//         '/ClientCard2': (context) => AppLayout(child: ClientCard2()),
//         '/applyNewCard': (context) => AppLayout(child: const ApplyNewCard()),
//       },
//     );
//   }
// }
