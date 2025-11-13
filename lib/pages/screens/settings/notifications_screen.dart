import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/settings_models.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationSettings settings;
  String savedMsg = '';

  @override
  void initState() {
    super.initState();
    settings = NotificationSettings.defaultSettings();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString('nb_notify_settings');
    if (settingsJson != null) {
      try {
        setState(() {
          settings = NotificationSettings.fromJson(jsonDecode(settingsJson));
        });
      } catch (e) {
        setState(() {
          settings = NotificationSettings.defaultSettings();
        });
      }
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nb_notify_settings', jsonEncode(settings.toJson()));
    
    setState(() => savedMsg = '✅ Settings saved successfully');
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => savedMsg = '');
    });
  }

  void _resetDefaults() {
    setState(() {
      settings = NotificationSettings.defaultSettings();
      savedMsg = '🔄 Restored default settings';
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => savedMsg = '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(isMobile),
                Padding(
                  padding: EdgeInsets.all(isMobile ? 12 : 20),
                  child: Column(
                    children: [
                      _buildChannelsCard(isMobile),
                      SizedBox(height: isMobile ? 16 : 20),
                      _buildCategoriesCard(isMobile),
                      SizedBox(height: isMobile ? 16 : 20),
                      _buildPreviewCard(isMobile),
                      if (savedMsg.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: isMobile ? 8 : 10),
                          padding: EdgeInsets.all(isMobile ? 8 : 10),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            savedMsg,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 12 : 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 20 : 27,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF900603),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 10 : 14,
                    vertical: isMobile ? 6 : 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  '← Back',
                  style: TextStyle(fontSize: isMobile ? 12 : 14),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSwitch(
                    settings.globalEnabled,
                    () => setState(
                        () => settings.globalEnabled = !settings.globalEnabled),
                    isMobile,
                  ),
                  SizedBox(height: isMobile ? 2 : 4),
                  Text(
                    'All ${settings.globalEnabled ? "ON" : "OFF"}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 10 : 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: isMobile ? 10 : 16),
          Text(
            'Manage Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 4 : 4),
          Text(
            'Choose how you receive alerts for transactions, security, offers, and more.',
            style: TextStyle(
              color: const Color(0xFFF8F8F8),
              fontSize: isMobile ? 11 : 15,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChannelsCard(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Channels',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF900603),
            ),
          ),
          SizedBox(height: isMobile ? 3 : 5),
          Text(
            'Enable or disable channels across all notifications',
            style: TextStyle(
              color: Colors.grey,
              fontSize: isMobile ? 12 : 14,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 15),
          ...[
            {
              'key': 'email',
              'label': 'EMAIL',
              'desc': 'Receive Email Notifications'
            },
            {'key': 'sms', 'label': 'SMS', 'desc': 'Receive SMS Alerts'},
            {
              'key': 'push',
              'label': 'PUSH',
              'desc': 'Receive Push Notifications'
            },
          ].map((ch) {
            bool value = ch['key'] == 'email'
                ? settings.channels.email
                : ch['key'] == 'sms'
                    ? settings.channels.sms
                    : settings.channels.push;

            return Container(
              margin: EdgeInsets.only(bottom: isMobile ? 10 : 12),
              padding: EdgeInsets.all(isMobile ? 10 : 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFEEEEEE)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ch['label'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 13 : 14,
                          ),
                        ),
                        Text(
                          ch['desc'] as String,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: isMobile ? 11 : 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSwitch(
                    value,
                    () {
                      setState(() {
                        if (ch['key'] == 'email') {
                          settings.channels.email = !settings.channels.email;
                        } else if (ch['key'] == 'sms') {
                          settings.channels.sms = !settings.channels.sms;
                        } else {
                          settings.channels.push = !settings.channels.push;
                        }
                      });
                    },
                    isMobile,
                    enabled: settings.globalEnabled,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoriesCard(bool isMobile) {
    final categories = [
      {
        'key': 'transaction',
        'icon': '💳',
        'title': 'Transaction Alerts',
        'desc': 'Debit/Credit, UPI, NEFT, IMPS, RTGS'
      },
      {
        'key': 'security',
        'icon': '🔒',
        'title': 'Security Alerts',
        'desc': 'Login attempts, password changes, suspicious activity'
      },
      {
        'key': 'offers',
        'icon': '🎁',
        'title': 'Offers & Promotions',
        'desc': 'New offers, partner deals, promotional messages'
      },
      {
        'key': 'product',
        'icon': '🧭',
        'title': 'Product Updates',
        'desc': 'New features & announcements'
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notification Categories',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF900603),
            ),
          ),
          SizedBox(height: isMobile ? 3 : 5),
          Text(
            'Manage per-category preferences',
            style: TextStyle(
              color: Colors.grey,
              fontSize: isMobile ? 12 : 14,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 15),
          ...categories.map((cat) {
            final catSettings = settings.categories[cat['key']]!;
            return Container(
              margin: EdgeInsets.only(bottom: isMobile ? 10 : 12),
              padding: EdgeInsets.all(isMobile ? 10 : 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFEEEEEE)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        cat['icon'] as String,
                        style: TextStyle(fontSize: isMobile ? 20 : 24),
                      ),
                      SizedBox(width: isMobile ? 8 : 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cat['title'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 14 : 16,
                              ),
                            ),
                            Text(
                              cat['desc'] as String,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: isMobile ? 10 : 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 8 : 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCategorySwitch(
                        'Email',
                        catSettings.email,
                        () => setState(() {
                          catSettings.email = !catSettings.email;
                        }),
                        isMobile,
                        enabled: settings.globalEnabled &&
                            settings.channels.email,
                      ),
                      _buildCategorySwitch(
                        'SMS',
                        catSettings.sms,
                        () => setState(() {
                          catSettings.sms = !catSettings.sms;
                        }),
                        isMobile,
                        enabled: settings.globalEnabled && settings.channels.sms,
                      ),
                      _buildCategorySwitch(
                        'Push',
                        catSettings.push,
                        () => setState(() {
                          catSettings.push = !catSettings.push;
                        }),
                        isMobile,
                        enabled:
                            settings.globalEnabled && settings.channels.push,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          Divider(height: isMobile ? 24 : 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Digest Frequency',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    SizedBox(height: isMobile ? 2 : 4),
                    Text(
                      'How often you receive non-critical messages',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: isMobile ? 10 : 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Row(
            children: ['immediate', 'daily', 'weekly'].map((freq) {
              final isActive = settings.frequency == freq;
              return Expanded(
                child: GestureDetector(
                  onTap: settings.globalEnabled
                      ? () => setState(() => settings.frequency = freq)
                      : null,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: isMobile ? 3 : 4),
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 8 : 10,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF900603)
                          : Colors.transparent,
                      border: Border.all(
                        color: isActive
                            ? const Color(0xFF900603)
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      freq,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 11 : 13,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySwitch(
    String label,
    bool value,
    VoidCallback onChanged,
    bool isMobile, {
    bool enabled = true,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 11 : 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: isMobile ? 4 : 6),
        _buildSmallSwitch(value, onChanged, isMobile, enabled: enabled),
      ],
    );
  }

  Widget _buildPreviewCard(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preview',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF900603),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 15),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildBadge('✉️ EMAIL', isMobile),
              _buildBadge('📱 SMS', isMobile),
              _buildBadge('🔔 PUSH', isMobile),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 15),
          _buildPreviewRow(
            'Global:',
            settings.globalEnabled ? 'Enabled' : 'Disabled',
            isMobile,
          ),
          _buildPreviewRow(
            'Active Channels:',
            [
              if (settings.channels.email) 'EMAIL',
              if (settings.channels.sms) 'SMS',
              if (settings.channels.push) 'PUSH',
            ].join(', '),
            isMobile,
          ),
          _buildPreviewRow('Frequency:', settings.frequency, isMobile),
          SizedBox(height: isMobile ? 15 : 20),
          if (isMobile)
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveSettings,
                    icon: const Icon(Icons.save, size: 16),
                    label: const Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF900603),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _resetDefaults,
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Restore Defaults'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF900603),
                      side:
                          const BorderSide(color: Color(0xFF900603), width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _saveSettings,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF900603),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _resetDefaults,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Restore Defaults'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF900603),
                      side:
                          const BorderSide(color: Color(0xFF900603), width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 10,
        vertical: isMobile ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF900603),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: isMobile ? 10 : 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPreviewRow(String label, String value, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 3 : 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 12 : 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: isMobile ? 12 : 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitch(
    bool value,
    VoidCallback onChanged,
    bool isMobile, {
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onChanged : null,
      child: Container(
        width: isMobile ? 40 : 46,
        height: isMobile ? 20 : 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: (enabled && value)
              ? const Color(0xFF900603)
              : const Color(0xFFCCCCCC),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: isMobile ? 16 : 18,
            height: isMobile ? 16 : 18,
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

  Widget _buildSmallSwitch(
    bool value,
    VoidCallback onChanged,
    bool isMobile, {
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onChanged : null,
      child: Container(
        width: isMobile ? 28 : 32,
        height: isMobile ? 16 : 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: (enabled && value)
              ? const Color(0xFF900603)
              : const Color(0xFFCCCCCC),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: isMobile ? 12 : 14,
            height: isMobile ? 12 : 14,
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