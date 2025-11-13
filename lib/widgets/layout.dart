import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../pages/dashboard.dart';
import '../pages/money_transfer_page.dart';
import '../pages/profile.dart';
import '../pages/screens/loan_dashboard.dart';
import '../pages/screens/settings/settings_screen.dart';
import 'topbar.dart';

class AppLayout extends StatefulWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _customDrawer(context),
      appBar: NavbarTop(),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [Expanded(child: widget.child)],
      ),
    );
  }

  Widget _customDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Image.asset('assets/logo.png', height: 140),
            ),
          ),

          // 🏠 Dashboard
          ListTile(
            leading: const Icon(Icons.dashboard, color: Color(0xFF900603)),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
            },
          ),

          // 👤 My Account
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF900603)),
            title: const Text('My Account'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileSection()),
              );
            },
          ),

          // 💰 Loan
          ListTile(
            leading: const Icon(LucideIcons.dollarSign, color: Color(0xFF900603)),
            title: const Text('Loan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoanDashboard()),
              );
            },
          ),

          // 🔁 Money Transfer
          ListTile(
            leading: const Icon(Icons.swap_horiz, color: Color(0xFF900603)),
            title: const Text('Money Transfer'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MoneyTransferPage()),
              );
            },
          ),

          // ⚙️ Settings
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF900603)),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
