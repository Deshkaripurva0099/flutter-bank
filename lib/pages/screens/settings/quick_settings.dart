import 'package:flutter/material.dart';

class QuickSettingItem {
  final String title;
  final IconData icon;
  bool enabled;

  QuickSettingItem({
    required this.title,
    required this.icon,
    required this.enabled,
  });
}

class QuickSettings extends StatefulWidget {
  const QuickSettings({Key? key}) : super(key: key);

  @override
  State<QuickSettings> createState() => _QuickSettingsState();
}

class _QuickSettingsState extends State<QuickSettings> {
  late List<QuickSettingItem> settings;

  @override
  void initState() {
    super.initState();
    settings = [
      QuickSettingItem(
        title: 'Biometric Login',
        icon: Icons.fingerprint,
        enabled: true,
      ),
      QuickSettingItem(
        title: 'Transaction Alerts',
        icon: Icons.notifications_active,
        enabled: true,
      ),
      QuickSettingItem(
        title: 'Account Visibility',
        icon: Icons.visibility,
        enabled: false,
      ),
      QuickSettingItem(
        title: 'Auto-Lock',
        icon: Icons.lock_clock,
        enabled: true,
      ),
    ];
  }

  void toggleSetting(int index) {
    setState(() {
      settings[index].enabled = !settings[index].enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        
        return Container(
          padding: EdgeInsets.all(isMobile ? 15 : 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Settings',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isMobile ? 3 : 5),
              Text(
                'Frequently used settings for quick access',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: isMobile ? 12 : 15),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 2,
                  mainAxisSpacing: isMobile ? 10 : 15,
                  crossAxisSpacing: isMobile ? 10 : 15,
                  childAspectRatio: isMobile ? 4 : 3,
                ),
                itemCount: settings.length,
                itemBuilder: (context, index) {
                  final item = settings[index];
                  return _buildQuickSettingCard(item, index, isMobile);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickSettingCard(QuickSettingItem item, int index, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 15,
        vertical: isMobile ? 10 : 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isMobile ? 30 : 35,
            height: isMobile ? 30 : 35,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8C00).withOpacity(0.15),
            ),
            child: Icon(
              item.icon,
              size: isMobile ? 16 : 18,
              color: const Color(0xFFFF8C00),
            ),
          ),
          SizedBox(width: isMobile ? 8 : 10),
          Expanded(
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: isMobile ? 13 : 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildSwitch(item.enabled, () => toggleSetting(index)),
        ],
      ),
    );
  }

  Widget _buildSwitch(bool value, VoidCallback onChanged) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        width: 36,
        height: 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: value ? const Color(0xFF960603) : const Color(0xFFCCCCCC),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 14,
            height: 14,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}