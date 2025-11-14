import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/settings_models.dart';
import '../../../widgets/layout.dart'; // Import AppLayout

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  String newPassword = '';
  String confirmPassword = '';
  String passwordError = '';
  bool passwordUpdated = false;

  late SecuritySettings securitySettings;
  int securityScore = 0;

  final List<ActivityItem> recentActivity = [
    ActivityItem(
      id: 1,
      action: 'Successful Login',
      device: 'iPhone 14 Pro',
      location: 'Mumbai, India',
      time: '2025-01-10 14:30',
      status: 'success',
    ),
    ActivityItem(
      id: 2,
      action: 'Password Changed',
      device: 'MacBook Pro',
      location: 'Mumbai, India',
      time: '2025-01-08 09:15',
      status: 'success',
    ),
    ActivityItem(
      id: 3,
      action: 'Failed Login Attempt',
      device: 'Unknown Device',
      location: 'Delhi, India',
      time: '2025-01-07 22:45',
      status: 'warning',
    ),
  ];

  final List<SessionItem> activeSessions = [
    SessionItem(
      id: 1,
      device: 'iPhone 14 Pro',
      browser: 'Safari',
      location: 'Mumbai, India',
      lastActive: '2 minutes ago',
      current: true,
    ),
    SessionItem(
      id: 2,
      device: 'MacBook Pro',
      browser: 'Chrome',
      location: 'Mumbai, India',
      lastActive: '1 hour ago',
      current: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    securitySettings = SecuritySettings.defaultSettings();
    _loadSettings();
    _calculateSecurityScore();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString('security_settings');
    if (settingsJson != null) {
      setState(() {
        securitySettings = SecuritySettings.fromJson(jsonDecode(settingsJson));
      });
    }
    _calculateSecurityScore();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'security_settings',
      jsonEncode(securitySettings.toJson()),
    );
  }

  void _calculateSecurityScore() {
    int totalItems = 7;
    int enabledItems = 0;

    if (securitySettings.twoFactorAuth) enabledItems++;
    if (securitySettings.smsAlerts) enabledItems++;
    if (securitySettings.emailAlerts) enabledItems++;
    if (securitySettings.loginNotifications) enabledItems++;
    if (securitySettings.biometricLogin) enabledItems++;
    if (securitySettings.sessionTimeout) enabledItems++;
    if (passwordUpdated) enabledItems++;

    setState(() {
      securityScore = ((enabledItems / totalItems) * 100).round();
    });
  }

  bool _validatePassword(String password) {
    final regex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$',
    );
    return regex.hasMatch(password);
  }

  void _handlePasswordUpdate() {
    if (!_validatePassword(newPassword)) {
      setState(() {
        passwordError = 'Use at least 8 characters, 1 number & 1 symbol.';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        passwordError = 'New Password and Confirm Password must match!';
      });
      return;
    }

    setState(() {
      passwordError = '';
      passwordUpdated = true;
      newPassword = '';
      confirmPassword = '';
    });

    _calculateSecurityScore();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Password updated successfully!'),
        backgroundColor: Color(0xFF900603),
      ),
    );
  }

  void _toggleSetting(String setting) {
    setState(() {
      switch (setting) {
        case 'twoFactorAuth':
          securitySettings.twoFactorAuth = !securitySettings.twoFactorAuth;
          break;
        case 'smsAlerts':
          securitySettings.smsAlerts = !securitySettings.smsAlerts;
          break;
        case 'emailAlerts':
          securitySettings.emailAlerts = !securitySettings.emailAlerts;
          break;
        case 'loginNotifications':
          securitySettings.loginNotifications =
              !securitySettings.loginNotifications;
          break;
        case 'biometricLogin':
          securitySettings.biometricLogin = !securitySettings.biometricLogin;
          break;
        case 'sessionTimeout':
          securitySettings.sessionTimeout = !securitySettings.sessionTimeout;
          break;
      }
    });
    _calculateSecurityScore();
    _saveSettings();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(isMobile),
                Padding(
                  padding: EdgeInsets.all(isMobile ? 12 : 16),
                  child: isMobile
                      ? _buildMobileLayout()
                      : _buildDesktopLayout(),
                ),
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
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 15 : 25,
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
                  'Security',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 22 : 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: isMobile ? 3 : 6),
                Text(
                  'Manage your account security and privacy',
                  style: TextStyle(
                    color: const Color(0xFFF8F8F8),
                    fontSize: isMobile ? 12 : 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: isMobile ? 8 : 16),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, size: isMobile ? 14 : 16),
            label: const Text('Back'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF960603),
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 2),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 8 : 16,
                vertical: isMobile ? 6 : 8,
              ),
              textStyle: TextStyle(fontSize: isMobile ? 12 : 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildSecurityScoreCard(true),
        const SizedBox(height: 16),
        _buildChangePasswordCard(true),
        const SizedBox(height: 16),
        _buildSecurityPreferencesCard(true),
        const SizedBox(height: 16),
        _buildRecentActivityCard(true),
        const SizedBox(height: 16),
        _buildActiveSessionsCard(true),
        const SizedBox(height: 16),
        _buildSecurityTipsCard(true),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildSecurityScoreCard(false),
              const SizedBox(height: 25),
              _buildChangePasswordCard(false),
              const SizedBox(height: 25),
              _buildSecurityPreferencesCard(false),
            ],
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          child: Column(
            children: [
              _buildRecentActivityCard(false),
              const SizedBox(height: 25),
              _buildActiveSessionsCard(false),
              const SizedBox(height: 25),
              _buildSecurityTipsCard(false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityScoreCard(bool isMobile) {
    String scoreText = securityScore >= 90
        ? 'Excellent'
        : securityScore >= 70
        ? 'Strong'
        : 'Weak';

    return _buildCard(
      isMobile: isMobile,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shield,
                color: const Color(0xFF900603),
                size: isMobile ? 18 : 20,
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                'Security Score',
                style: TextStyle(
                  color: const Color(0xFF900603),
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Container(
            width: isMobile ? 80 : 100,
            height: isMobile ? 80 : 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFF6600),
                width: isMobile ? 4 : 5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$securityScore%',
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF900603),
                  ),
                ),
                Text(
                  scoreText,
                  style: TextStyle(
                    fontSize: isMobile ? 10 : 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Enable more options or update your password to improve your security score.',
            style: TextStyle(fontSize: isMobile ? 11 : 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChangePasswordCard(bool isMobile) {
    return _buildCard(
      isMobile: isMobile,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.vpn_key,
                color: const Color(0xFF900603),
                size: isMobile ? 18 : 20,
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                'Change Password',
                style: TextStyle(
                  color: const Color(0xFF900603),
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 15 : 20),
          _buildPasswordField(
            'Current Password',
            showCurrentPassword,
            () => setState(() => showCurrentPassword = !showCurrentPassword),
            isMobile,
          ),
          SizedBox(height: isMobile ? 12 : 15),
          _buildPasswordField(
            'New Password',
            showNewPassword,
            () => setState(() => showNewPassword = !showNewPassword),
            isMobile,
            onChanged: (val) => setState(() => newPassword = val),
          ),
          SizedBox(height: isMobile ? 12 : 15),
          _buildPasswordField(
            'Confirm Password',
            showConfirmPassword,
            () => setState(() => showConfirmPassword = !showConfirmPassword),
            isMobile,
            onChanged: (val) => setState(() => confirmPassword = val),
          ),
          if (passwordError.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: isMobile ? 8 : 10),
              padding: EdgeInsets.all(isMobile ? 8 : 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                border: Border.all(color: const Color(0xFFFFD54F)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: const Color(0xFFC77F00),
                    size: isMobile ? 16 : 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      passwordError,
                      style: TextStyle(
                        color: const Color(0xFFC77F00),
                        fontSize: isMobile ? 11 : 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: isMobile ? 12 : 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handlePasswordUpdate,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                padding: EdgeInsets.symmetric(vertical: isMobile ? 10 : 12),
              ),
              child: Text(
                'Update Password',
                style: TextStyle(fontSize: isMobile ? 13 : 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    bool showPassword,
    VoidCallback toggleVisibility,
    bool isMobile, {
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: isMobile ? 12 : 14,
          ),
        ),
        SizedBox(height: isMobile ? 4 : 6),
        TextField(
          obscureText: !showPassword,
          onChanged: onChanged,
          style: TextStyle(fontSize: isMobile ? 13 : 14),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isDense: isMobile,
            contentPadding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 12,
              vertical: isMobile ? 10 : 12,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
                size: isMobile ? 18 : 20,
              ),
              onPressed: toggleVisibility,
              color: const Color(0xFF900603),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityPreferencesCard(bool isMobile) {
    final preferences = [
      {'key': 'twoFactorAuth', 'label': 'Two Factor Auth'},
      {'key': 'smsAlerts', 'label': 'SMS Alerts'},
      {'key': 'emailAlerts', 'label': 'Email Alerts'},
      {'key': 'loginNotifications', 'label': 'Login Notifications'},
      {'key': 'biometricLogin', 'label': 'Biometric Login'},
      {'key': 'sessionTimeout', 'label': 'Session Timeout'},
    ];

    return _buildCard(
      isMobile: isMobile,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.settings,
                color: const Color(0xFF900603),
                size: isMobile ? 18 : 20,
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                'Security Preferences',
                style: TextStyle(
                  color: const Color(0xFF900603),
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 15 : 20),
          ...preferences.map((pref) {
            bool value = false;
            switch (pref['key']) {
              case 'twoFactorAuth':
                value = securitySettings.twoFactorAuth;
                break;
              case 'smsAlerts':
                value = securitySettings.smsAlerts;
                break;
              case 'emailAlerts':
                value = securitySettings.emailAlerts;
                break;
              case 'loginNotifications':
                value = securitySettings.loginNotifications;
                break;
              case 'biometricLogin':
                value = securitySettings.biometricLogin;
                break;
              case 'sessionTimeout':
                value = securitySettings.sessionTimeout;
                break;
            }

            return Container(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 10 : 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFDEE2E6))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pref['label'] as String,
                    style: TextStyle(fontSize: isMobile ? 13 : 14),
                  ),
                  Transform.scale(
                    scale: isMobile ? 0.8 : 1.0,
                    child: Switch(
                      value: value,
                      onChanged: (val) => _toggleSetting(pref['key'] as String),
                      activeColor: const Color(0xFF900603),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRecentActivityCard(bool isMobile) {
    return _buildCard(
      isMobile: isMobile,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: const Color(0xFF900603),
                    size: isMobile ? 18 : 20,
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Text(
                    'Recent Activity',
                    style: TextStyle(
                      color: const Color(0xFF900603),
                      fontSize: isMobile ? 16 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (!isMobile)
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, size: 16),
                  label: const Text('Export'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF900603),
                    side: const BorderSide(color: Color(0xFF900603)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: isMobile ? 15 : 20),
          ...recentActivity.map((activity) {
            final isWarning = activity.status == 'warning';
            return Container(
              margin: EdgeInsets.only(bottom: isMobile ? 8 : 10),
              padding: EdgeInsets.all(isMobile ? 10 : 12),
              decoration: BoxDecoration(
                color: isWarning
                    ? const Color(0xFFFFF8E1)
                    : const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          activity.action,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 13 : 14,
                          ),
                        ),
                      ),
                      Icon(
                        isWarning ? Icons.warning : Icons.check_circle,
                        color: isWarning
                            ? const Color(0xFF8A6D3B)
                            : const Color(0xFF256029),
                        size: isMobile ? 18 : 20,
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 2 : 4),
                  Text(
                    '${activity.device} • ${activity.location}',
                    style: TextStyle(fontSize: isMobile ? 11 : 12),
                  ),
                  Text(
                    activity.time,
                    style: TextStyle(
                      fontSize: isMobile ? 10 : 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildActiveSessionsCard(bool isMobile) {
    return _buildCard(
      isMobile: isMobile,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.devices,
                    color: const Color(0xFF900603),
                    size: isMobile ? 18 : 20,
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Text(
                    'Active Sessions',
                    style: TextStyle(
                      color: const Color(0xFF900603),
                      fontSize: isMobile ? 16 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (!isMobile)
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.restart_alt, size: 16),
                  label: const Text('End All'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF900603),
                    side: const BorderSide(color: Color(0xFF900603)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: isMobile ? 15 : 20),
          ...activeSessions.map((session) {
            return Container(
              margin: EdgeInsets.only(bottom: isMobile ? 6 : 8),
              padding: EdgeInsets.all(isMobile ? 10 : 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone_android,
                        color: const Color(0xFF900603),
                        size: isMobile ? 18 : 20,
                      ),
                      SizedBox(width: isMobile ? 8 : 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${session.device} — ${session.browser}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 12 : 14,
                              ),
                            ),
                            Text(
                              '${session.location} • Last active ${session.lastActive}',
                              style: TextStyle(
                                fontSize: isMobile ? 10 : 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!session.current) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF900603),
                          side: const BorderSide(color: Color(0xFF900603)),
                          padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 6 : 8,
                          ),
                        ),
                        child: Text(
                          'End Session',
                          style: TextStyle(fontSize: isMobile ? 11 : 12),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSecurityTipsCard(bool isMobile) {
    return _buildCard(
      isMobile: isMobile,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lightbulb,
                color: const Color(0xFF900603),
                size: isMobile ? 18 : 20,
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                'Security Tips',
                style: TextStyle(
                  color: const Color(0xFF900603),
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 15 : 20),
          ...[
            'Use strong passwords with symbols.',
            'Enable Two-Factor Authentication.',
            'Review login devices regularly.',
            'Keep your app updated.',
          ].map((tip) {
            return Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 6 : 8),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: isMobile ? 16 : 20,
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Expanded(
                    child: Text(
                      tip,
                      style: TextStyle(fontSize: isMobile ? 12 : 14),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child, required bool isMobile}) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
