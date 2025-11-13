import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  String theme = 'Light';
  bool compactView = false;
  bool animations = true;
  bool soundEffects = true;
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool smsNotifications = false;
  String language = 'English';
  String currency = '₹ INR';
  String dateFormat = 'DD/MM/YYYY';
  String timeFormat = '12-hour';
  bool analytics = true;
  bool crashReporting = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      theme = prefs.getString('theme') ?? 'Light';
      compactView = prefs.getBool('compactView') ?? false;
      animations = prefs.getBool('animations') ?? true;
      soundEffects = prefs.getBool('soundEffects') ?? true;
      pushNotifications = prefs.getBool('pushNotifications') ?? true;
      emailNotifications = prefs.getBool('emailNotifications') ?? true;
      smsNotifications = prefs.getBool('smsNotifications') ?? false;
      language = prefs.getString('language') ?? 'English';
      currency = prefs.getString('currency') ?? '₹ INR';
      dateFormat = prefs.getString('dateFormat') ?? 'DD/MM/YYYY';
      timeFormat = prefs.getString('timeFormat') ?? '12-hour';
      analytics = prefs.getBool('analytics') ?? true;
      crashReporting = prefs.getBool('crashReporting') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
    await prefs.setBool('compactView', compactView);
    await prefs.setBool('animations', animations);
    await prefs.setBool('soundEffects', soundEffects);
    await prefs.setBool('pushNotifications', pushNotifications);
    await prefs.setBool('emailNotifications', emailNotifications);
    await prefs.setBool('smsNotifications', smsNotifications);
    await prefs.setString('language', language);
    await prefs.setString('currency', currency);
    await prefs.setString('dateFormat', dateFormat);
    await prefs.setString('timeFormat', timeFormat);
    await prefs.setBool('analytics', analytics);
    await prefs.setBool('crashReporting', crashReporting);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Settings applied successfully!'),
          backgroundColor: Color(0xFF900603),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = theme == 'Dark';
    final backgroundColor = isDark
        ? const Color(0xFF121212)
        : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark
        ? const Color(0xFFF1F1F1)
        : const Color(0xFF212529);
    final subtitleColor = isDark
        ? const Color(0xFFCFCFCF)
        : const Color(0xFF6C757D);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          final isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 992;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header
                _buildHeader(isMobile),

                // Content
                Padding(
                  padding: EdgeInsets.all(isMobile ? 12 : 16),
                  child: isMobile
                      ? _buildMobileLayout(
                          cardColor,
                          textColor,
                          subtitleColor,
                          isMobile,
                        )
                      : _buildDesktopLayout(
                          cardColor,
                          textColor,
                          subtitleColor,
                          isMobile,
                        ),
                ),

                // Footer Buttons
                _buildFooterButtons(isMobile),
                SizedBox(height: isMobile ? 20 : 0),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 15 : 15,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF960603),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'General Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isMobile ? 2 : 4),
                Text(
                  'Customize your app experience and preferences',
                  style: TextStyle(
                    color: const Color(0xFFFEFEFE),
                    fontSize: isMobile ? 11 : 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: isMobile ? 8 : 16),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, size: isMobile ? 14 : 16),
            label: Text(isMobile ? 'Back' : 'Back'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF900603),
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 2),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 8 : 12,
                vertical: isMobile ? 6 : 8,
              ),
              textStyle: TextStyle(fontSize: isMobile ? 12 : 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(
    Color cardColor,
    Color textColor,
    Color subtitleColor,
    bool isMobile,
  ) {
    return Column(
      children: [
        _buildThemeCard(cardColor, textColor, subtitleColor, isMobile),
        const SizedBox(height: 16),
        _buildNotificationCard(cardColor, textColor, subtitleColor, isMobile),
        const SizedBox(height: 16),
        _buildLanguageCard(cardColor, textColor, subtitleColor, isMobile),
        const SizedBox(height: 16),
        _buildPrivacyCard(cardColor, textColor, subtitleColor, isMobile),
        const SizedBox(height: 16),
        _buildPreviewCard(cardColor, textColor, isMobile),
      ],
    );
  }

  Widget _buildDesktopLayout(
    Color cardColor,
    Color textColor,
    Color subtitleColor,
    bool isMobile,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildThemeCard(cardColor, textColor, subtitleColor, isMobile),
              const SizedBox(height: 24),
              _buildNotificationCard(
                cardColor,
                textColor,
                subtitleColor,
                isMobile,
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            children: [
              _buildLanguageCard(cardColor, textColor, subtitleColor, isMobile),
              const SizedBox(height: 24),
              _buildPrivacyCard(cardColor, textColor, subtitleColor, isMobile),
              const SizedBox(height: 24),
              _buildPreviewCard(cardColor, textColor, isMobile),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThemeCard(
    Color cardColor,
    Color textColor,
    Color subtitleColor,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.075),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎨 Theme & Appearance',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          SizedBox(height: isMobile ? 2 : 4),
          Text(
            'Customize the look and feel of your app',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: subtitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'App Theme',
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          SizedBox(height: isMobile ? 8 : 12),
          ...[
            {
              'name': 'Light',
              'icon': Icons.wb_sunny,
              'desc': 'Clean and bright interface',
            },
            {
              'name': 'Dark',
              'icon': Icons.nightlight_round,
              'desc': 'Easy on the eyes in low light',
            },
            {
              'name': 'Auto',
              'icon': Icons.devices,
              'desc': 'Follows your device settings',
            },
          ].map(
            (item) => _buildThemeOption(
              item['name'] as String,
              item['icon'] as IconData,
              item['desc'] as String,
              cardColor,
              textColor,
              isMobile,
            ),
          ),
          Divider(height: isMobile ? 24 : 32),
          Text(
            'Display Options',
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          SizedBox(height: isMobile ? 8 : 12),
          _buildSwitchRow(
            'Compact View',
            'Reduce spacing and padding',
            compactView,
            (val) => setState(() => compactView = val),
            isMobile,
          ),
          _buildSwitchRow(
            'Animations',
            'Enable smooth transitions',
            animations,
            (val) => setState(() => animations = val),
            isMobile,
          ),
          _buildSwitchRow(
            'Sound Effects',
            'Play sounds for actions',
            soundEffects,
            (val) => setState(() => soundEffects = val),
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    String name,
    IconData icon,
    String description,
    Color cardColor,
    Color textColor,
    bool isMobile,
  ) {
    final isActive = theme == name;
    return GestureDetector(
      onTap: () => setState(() => theme = name),
      child: Container(
        margin: EdgeInsets.only(bottom: isMobile ? 8 : 12),
        padding: EdgeInsets.all(isMobile ? 10 : 12),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFF8D7DA)
              : (theme == 'Dark' ? const Color(0xFF2C2C2C) : cardColor),
          border: Border.all(
            color: isActive ? const Color(0xFF900603) : const Color(0xFFDEE2E6),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: name == 'Light' ? Colors.orange : textColor,
              size: isMobile ? 20 : 24,
            ),
            SizedBox(width: isMobile ? 10 : 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name Theme',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: isMobile ? 13 : 14,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: isMobile ? 10 : 12,
                      color: const Color(0xFF6C757D),
                    ),
                  ),
                ],
              ),
            ),
            if (isActive)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 8 : 10,
                  vertical: isMobile ? 3 : 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF900603),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Active',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 10 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow(
    String label,
    String description,
    bool value,
    Function(bool) onChanged,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 10 : 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFDEE2E6))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: isMobile ? 13 : 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: isMobile ? 10 : 12,
                    color: const Color(0xFF6C757D),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          Transform.scale(
            scale: isMobile ? 0.8 : 1.0,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF900603),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    Color cardColor,
    Color textColor,
    Color subtitleColor,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.075),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🔔 Notification Preferences',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          SizedBox(height: isMobile ? 2 : 4),
          Text(
            'Choose how you want to receive notifications',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: subtitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildSwitchRow(
            'Push Notifications',
            'Receive push notifications',
            pushNotifications,
            (val) => setState(() => pushNotifications = val),
            isMobile,
          ),
          _buildSwitchRow(
            'Email Notifications',
            'Receive email notifications',
            emailNotifications,
            (val) => setState(() => emailNotifications = val),
            isMobile,
          ),
          _buildSwitchRow(
            'SMS Notifications',
            'Receive SMS notifications',
            smsNotifications,
            (val) => setState(() => smsNotifications = val),
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(
    Color cardColor,
    Color textColor,
    Color subtitleColor,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.075),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🌐 Language & Regional',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          SizedBox(height: isMobile ? 2 : 4),
          Text(
            'Set your language, currency, and format preferences',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: subtitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildDropdown(
            'Language',
            language,
            ['English', 'UK English', 'Hindi'],
            (val) => setState(() => language = val!),
            isMobile,
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildDropdown(
            'Currency',
            currency,
            ['₹ INR', '\$ USD'],
            (val) => setState(() => currency = val!),
            isMobile,
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildDropdown(
            'Date Format',
            dateFormat,
            ['DD/MM/YYYY', 'MM/DD/YYYY'],
            (val) => setState(() => dateFormat = val!),
            isMobile,
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildDropdown(
            'Time Format',
            timeFormat,
            ['12-hour', '24-hour'],
            (val) => setState(() => timeFormat = val!),
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: isMobile ? 13 : 14,
          ),
        ),
        SizedBox(height: isMobile ? 6 : 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            contentPadding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 12,
              vertical: isMobile ? 6 : 8,
            ),
            isDense: isMobile,
          ),
          style: TextStyle(fontSize: isMobile ? 12 : 14, color: Colors.black),
          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildPrivacyCard(
    Color cardColor,
    Color textColor,
    Color subtitleColor,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.075),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🔒 Privacy & Data',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          SizedBox(height: isMobile ? 2 : 4),
          Text(
            'Control how your data is used and shared',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: subtitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildSwitchRow(
            'Analytics & Usage Data',
            'Help improve the app',
            analytics,
            (val) => setState(() => analytics = val),
            isMobile,
          ),
          _buildSwitchRow(
            'Crash Reporting',
            'Automatically send crash reports',
            crashReporting,
            (val) => setState(() => crashReporting = val),
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard(Color cardColor, Color textColor, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.075),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📊 Settings Preview',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          SizedBox(height: isMobile ? 2 : 4),
          Text(
            'A preview of your current settings',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: const Color(0xFF6C757D),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildPreviewRow('Theme', '$theme Theme', isMobile),
          _buildPreviewRow('Language', language, isMobile),
          _buildPreviewRow('Currency', currency, isMobile),
          _buildPreviewRow('Date Format', dateFormat, isMobile),
          _buildPreviewRow('Time Format', timeFormat, isMobile),
          _buildPreviewRow(
            'Notifications',
            [
              if (pushNotifications) 'Push',
              if (emailNotifications) 'Email',
              if (smsNotifications) 'SMS',
            ].join(', '),
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewRow(String label, String value, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 6 : 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFDEE2E6))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isMobile ? 12 : 14)),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: isMobile ? 12 : 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButtons(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: isMobile ? 0 : 16,
      ),
      child: isMobile
          ? Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        theme = 'Light';
                        compactView = false;
                        animations = true;
                        soundEffects = true;
                        pushNotifications = true;
                        emailNotifications = true;
                        smsNotifications = false;
                        language = 'English';
                        currency = '₹ INR';
                        dateFormat = 'DD/MM/YYYY';
                        timeFormat = '12-hour';
                        analytics = true;
                        crashReporting = true;
                      });
                    },
                    icon: const Icon(Icons.restore, size: 16),
                    label: const Text('Reset to Defaults'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF212529),
                      backgroundColor: const Color(0xFFE9ECEF),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveSettings,
                    icon: const Icon(Icons.check_circle, size: 16),
                    label: const Text('Save Settings'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF900603),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      theme = 'Light';
                      compactView = false;
                      animations = true;
                      soundEffects = true;
                      pushNotifications = true;
                      emailNotifications = true;
                      smsNotifications = false;
                      language = 'English';
                      currency = '₹ INR';
                      dateFormat = 'DD/MM/YYYY';
                      timeFormat = '12-hour';
                      analytics = true;
                      crashReporting = true;
                    });
                  },
                  icon: const Icon(Icons.restore),
                  label: const Text('Reset to Defaults'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF212529),
                    backgroundColor: const Color(0xFFE9ECEF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _saveSettings,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Save Settings'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF900603),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
