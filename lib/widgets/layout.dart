import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
      drawer: _customDrawer(),
      appBar: NavbarTop(),
      backgroundColor: Colors.grey.shade100,
      body: Column(children: [Expanded(child: widget.child)]),
    );
  }

  Widget _customDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(child: Image.asset('assets/logo.png', height: 140)),
          ),

          // UserAccountsDrawerHeader(
          //   decoration: const BoxDecoration(color: Color(0xFF900603)),
          //   accountName: const Text('Purvi D', style: TextStyle(fontSize: 18)),
          //   accountEmail: const Text(
          //     'purvi@example.com',
          //     style: TextStyle(fontSize: 14),
          //   ),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundColor: Colors.white,
          //     child: Text(
          //       'P',
          //       style: TextStyle(
          //         fontSize: 24,
          //         color: Color(0xFF900603),
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Color(0xFF900603)),
            title: const Text('DashBoard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/pages/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF900603)),
            title: const Text('My Account'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.wallet, color: Color(0xFF900603)),
            title: const Text('Deposit'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/pages/deposit');
            },
          ),
          ListTile(
            leading: const Icon(
              LucideIcons.dollarSign,
              color: Color(0xFF900603),
            ),
            title: const Text('Loan'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.swap_horiz, color: Color(0xFF900603)),
            title: const Text('Money Transfer'),
            onTap: () {
              Navigator.pushNamed(context, '/pages/money_transfer_page');
            },
          ),
          ListTile(
            leading: const Icon(Icons.trending_up, color: Color(0xFF900603)),
            title: const Text('Investment'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.credit_card, color: Color(0xFF900603)),
            title: const Text('Cards'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent, color: Color(0xFF900603)),
            title: const Text('Services'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/pages/services');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF900603)),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/pages/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.report, color: Color(0xFF900603)),
            title: const Text('Complaints'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF900603)),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
