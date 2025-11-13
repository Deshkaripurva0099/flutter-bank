import 'package:flutter/material.dart';
import 'package:neobank/pages/screens/settings/general_settings.dart';
import 'package:neobank/widgets/layout.dart';
import 'quick_settings.dart';
import 'account_info.dart';
import 'security_options.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = [
      {
        'title': 'General Settings',
        'description': 'App preferences, language, and display settings',
        'icon': Icons.settings,
        'path': const GeneralSettings(),
      },
      {
        'title': 'Personal Details',
        'description': 'Update your profile information and contact details',
        'icon': Icons.person,
        'path': '/client/personal-details',
      },
      {
        'title': 'Security',
        'description': 'Password, 2FA, and security preferences',
        'icon': Icons.shield,
        'path': '/client/security',
      },
      {
        'title': 'Notifications',
        'description': 'Manage email, SMS, and push notifications',
        'icon': Icons.notifications,
        'path': '/client/notifications',
      },
    ];

    return AppLayout(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final isTablet =
                constraints.maxWidth >= 600 && constraints.maxWidth < 992;

            int crossAxisCount = 2;
            double childAspectRatio = 1.2;

            if (isMobile) {
              crossAxisCount = 1;
              childAspectRatio = 1.4;
            } else if (isTablet) {
              crossAxisCount = 2;
              childAspectRatio = 1.3;
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 32,
                      vertical: isMobile ? 20 : 25,
                    ),
                    decoration: const BoxDecoration(color: Color(0xFF900603)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 22 : 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Manage your account preferences and security',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: isMobile ? 12 : 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Cards Grid
                  Padding(
                    padding: EdgeInsets.all(isMobile ? 12 : 20),
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: isMobile ? 12 : 20,
                                crossAxisSpacing: isMobile ? 12 : 20,
                                childAspectRatio: childAspectRatio,
                              ),
                          itemCount: settings.length,
                          itemBuilder: (context, index) {
                            final item = settings[index];
                            return _buildSettingCard(context, item, isMobile);
                          },
                        ),

                        SizedBox(height: isMobile ? 20 : 30),

                        // Extra Sections
                        const QuickSettings(),
                        SizedBox(height: isMobile ? 15 : 20),
                        const AccountInfo(),
                        SizedBox(height: isMobile ? 15 : 20),
                        const SecurityOptions(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ----------------------------
  // 🔹 Card Builder with Direct Navigation
  // ----------------------------
  Widget _buildSettingCard(
    BuildContext context,
    Map<String, dynamic> item,
    bool isMobile,
  ) {
    return GestureDetector(
      onTap: () {
        // Direct widget-based navigation (no main.dart route needed)
        if (item['path'] is Widget) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item['path']),
          );
        } else if (item['path'] is String) {
          // Handle string routes manually
          Widget? page;
          switch (item['path']) {
            case '/client/personal-details':
              page = const AccountInfo();
              break;
            case '/client/security':
              page = const SecurityOptions();
              break;
            case '/client/notifications':
              page = const QuickSettings();
              break;
          }

          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page!),
            );
          }
        }
      },
      child: Container(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Circle
            Container(
              width: isMobile ? 50 : 60,
              height: isMobile ? 50 : 60,
              decoration: const BoxDecoration(
                color: Color(0xFF960603),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item['icon'],
                color: Colors.white,
                size: isMobile ? 24 : 28,
              ),
            ),
            SizedBox(height: isMobile ? 12 : 16),

            // Title
            Text(
              item['title'],
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: isMobile ? 6 : 8),

            // Description
            Expanded(
              child: Text(
                item['description'],
                style: TextStyle(
                  fontSize: isMobile ? 12 : 13,
                  color: const Color(0xFF666666),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),

            // Configure Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: isMobile ? 8 : 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF960603), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Configure',
                    style: TextStyle(
                      color: const Color(0xFF960603),
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 13 : 14,
                    ),
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF960603),
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
