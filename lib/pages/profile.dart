import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:neobank/widgets/layout.dart';
import 'package:neobank/widgets/topbar.dart';

const Color primaryColor = Color(0xFF900603);
const Color secondaryColor = Color(0xFFb91c1c);
const Color successColor = Color(0xFF065f46);
const Color dangerColor = Color(0xFF991b1b);
const Color backgroundColor = Color(0xFFF8F9FA);

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  // UI state
  String activeTab = 'overview';
  bool showBalance = false;

  // Form controllers / state
  final _editNameController = TextEditingController();
  final _editEmailController = TextEditingController();
  final _editAddressController = TextEditingController();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _currentPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  // Settings state
  bool _pushNotifications = true;
  bool _biometricLogin = false;
  String _language = 'English (US)';
  String _theme = 'system';
  bool _emailAlerts = true;
  bool _promoOffers = false;
  bool _deactivateAccount = false;

  // Image
  File? _profileImageFile;
  final ImagePicker _picker = ImagePicker();

  // Sample user
  Map<String, dynamic> user = {
    'name': 'Purva Deshkari',
    'email': 'deshkaripurva@gmail.com',
    'phone': '8830325970',
    'address': 'Mumbai, Maharashtra, India',
    'dateOfBirth': '15/08/1990',
    'accountNumber': '****1234',
    'accountType': 'Premium Savings',
    'balance': 48748.00,
    'ifscCode': 'ABCD0001234',
    'kycStatus': 'Verified',
    'profileImage': null,
  };

  List<Map<String, dynamic>> autoDebits = [
    {
      'id': 1,
      'name': 'Electricity Bill - MSEB',
      'category': 'utilities',
      'amount': 2500,
      'frequency': 'Monthly',
      'nextDate': '2025-02-05',
      'status': 'active',
    },
    {
      'id': 2,
      'name': 'Mobile Postpaid - Airtel',
      'category': 'telecom',
      'amount': 999,
      'frequency': 'Monthly',
      'nextDate': '2025-02-10',
      'status': 'active',
    },
    {
      'id': 3,
      'name': 'Home Loan EMI - HDFC',
      'category': 'loans',
      'amount': 45000,
      'frequency': 'Monthly',
      'nextDate': '2025-02-07',
      'status': 'paused',
    },
    {
      'id': 4,
      'name': 'Netflix Subscription',
      'category': 'entertainment',
      'amount': 645,
      'frequency': 'Monthly',
      'nextDate': '2025-02-15',
      'status': 'active',
    },
    {
      'id': 5,
      'name': 'Life Insurance Premium',
      'category': 'insurance',
      'amount': 12000,
      'frequency': 'Quarterly',
      'nextDate': '2025-03-01',
      'status': 'active',
    },
  ];

  final List<Map<String, dynamic>> recentTransactions = [
    {
      'id': 1,
      'type': 'credit',
      'amount': 5000,
      'description': 'Salary Credit',
      'date': '2025-01-15',
      'time': '09:30 AM',
    },
    {
      'id': 2,
      'type': 'debit',
      'amount': 1200,
      'description': 'Online Shopping',
      'date': '2025-01-14',
      'time': '02:15 PM',
    },
    {
      'id': 3,
      'type': 'debit',
      'amount': 800,
      'description': 'Utility Bills',
      'date': '2025-01-13',
      'time': '11:45 AM',
    },
    {
      'id': 4,
      'type': 'credit',
      'amount': 2500,
      'description': 'Investment Return',
      'date': '2025-01-12',
      'time': '04:20 PM',
    },
  ];

  final List<Map<String, dynamic>> loginActivity = [
    {
      'id': 1,
      'device': 'Mobile App (Current Session)',
      'location': 'Mumbai, India',
      'time': 'Just now',
      'status': 'success',
    },
    {
      'id': 2,
      'device': 'Web Browser',
      'location': 'Delhi, India',
      'time': 'Yesterday, 10:00 PM',
      'status': 'success',
    },
    {
      'id': 3,
      'device': 'Tablet',
      'location': 'Mumbai, India',
      'time': '3 days ago, 03:45 PM',
      'status': 'failed',
    },
  ];

  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  //Lifecycle
  @override
  void dispose() {
    _editNameController.dispose();
    _editEmailController.dispose();
    _editAddressController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  // Actions
  Future<void> _pickProfileImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (picked != null) {
      setState(() {
        _profileImageFile = File(picked.path);
      });
    }
  }

  void _openEditProfileModal() {
    _editNameController.text = user['name'] ?? '';
    _editEmailController.text = user['email'] ?? '';
    _editAddressController.text = user['address'] ?? '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Personal Information'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _editNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _editEmailController,
                decoration: const InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _editAddressController,
                decoration: const InputDecoration(labelText: 'Address'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () {
              if (_editNameController.text.isEmpty ||
                  _editEmailController.text.isEmpty ||
                  _editAddressController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
                return;
              }
              setState(() {
                user['name'] = _editNameController.text.trim();
                user['email'] = _editEmailController.text.trim();
                user['address'] = _editAddressController.text.trim();
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
            },
            child: const Text(
              'Save Changes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _openChangePasswordModal() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Change Login Password'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _currentPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password (Min 8 characters)',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                ),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () {
              final newP = _newPasswordController.text;
              final confirmP = _confirmPasswordController.text;
              if (newP != confirmP) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New passwords do not match')),
                );
                return;
              }
              if (newP.length < 8) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password must be at least 8 characters'),
                  ),
                );
                return;
              }
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed successfully')),
              );
            },
            child: const Text(
              'Change Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _openChangePinModal() {
    _currentPinController.clear();
    _newPinController.clear();
    _confirmPinController.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Change Transaction PIN'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _currentPinController,
                decoration: const InputDecoration(labelText: 'Current PIN'),
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _newPinController,
                decoration: const InputDecoration(labelText: 'New 4-Digit PIN'),
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPinController,
                decoration: const InputDecoration(labelText: 'Confirm New PIN'),
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () {
              final newPin = _newPinController.text;
              final confirmPin = _confirmPinController.text;
              if (newPin != confirmPin) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PINs do not match')),
                );
                return;
              }
              if (newPin.length != 4 || int.tryParse(newPin) == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PIN must be exactly 4 digits')),
                );
                return;
              }
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Transaction PIN changed successfully'),
                ),
              );
            },
            child: const Text(
              'Change PIN',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'transfer':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Redirecting to Money Transfer...')),
        );
        break;
      case 'statement':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Downloading account statement...')),
        );
        break;
      case 'investments':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening investment portfolio...')),
        );
        break;
      case 'auto-debit':
        setState(() {
          activeTab = 'auto-debit';
        });
        break;
      default:
        break;
    }
  }

  void _handleAutoDebitAction(String action, int id) {
    if (action == 'add') {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Opening Add New Auto Debit form...'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (action == 'edit') {
      // ✅ FIX: ensure Snackbar is shown after frame is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final messenger = ScaffoldMessenger.maybeOf(context);
        if (messenger != null) {
          messenger.removeCurrentSnackBar();
          messenger.showSnackBar(
            SnackBar(
              content: Text('Editing Auto Debit ID: $id'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          debugPrint("⚠️ ScaffoldMessenger not found for this context");
        }
      });
    } else if (action == 'pause_toggle') {
      setState(() {
        autoDebits = autoDebits.map((d) {
          if (d['id'] == id) {
            return {
              ...d,
              'status': d['status'] == 'active' ? 'paused' : 'active',
            };
          }
          return d;
        }).toList();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Auto Debit ${autoDebits.firstWhere((d) => d['id'] == id)['name']} '
              '${autoDebits.firstWhere((d) => d['id'] == id)['status']}',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    } else if (action == 'delete') {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Delete Auto Debit'),
          content: const Text(
            'Are you sure you want to delete this auto debit?',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: dangerColor),
              onPressed: () {
                setState(() {
                  autoDebits.removeWhere((d) => d['id'] == id);
                });
                Navigator.of(context).pop();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Auto Debit deleted'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                });
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
  }

  //UI helpers
  Widget _tabButton(String id, IconData icon, String label) {
    final bool active = activeTab == id;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => activeTab = id),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? primaryColor.withOpacity(0.05) : Colors.transparent,
            border: active
                ? const Border(
                    bottom: BorderSide(width: 3, color: primaryColor),
                  )
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: active ? primaryColor : Colors.grey[700],
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: active ? primaryColor : Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Profile Info
  Widget _buildProfileHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
        bottom: 8.0,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Stack(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: primaryColor.withOpacity(0.1),
                    backgroundImage: _profileImageFile != null
                        ? FileImage(_profileImageFile!) as ImageProvider
                        : (user['profileImage'] != null
                              ? NetworkImage(user['profileImage'])
                              : const AssetImage('assets/default_avatar.png')
                                    as ImageProvider),
                    child:
                        _profileImageFile == null &&
                            user['profileImage'] == null
                        ? Icon(Icons.person, size: 40, color: primaryColor)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _pickProfileImage,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: primaryColor,
                        child: Icon(Icons.edit, size: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name'] ?? 'Guest User',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user['email'] ?? 'N/A',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    // Balance Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Balance',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              showBalance
                                  ? _formatCurrency(user['balance'])
                                  : '₹ ••••••',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            showBalance
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              showBalance = !showBalance;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 20),
        ],
      ),
    );
  }

  // Placeholder for Overview Tab
  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // Quick Action Grid (Placeholder)
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: 0.8,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _buildQuickActionButton(
              Icons.send,
              'Transfer',
              'transfer',
              primaryColor,
            ),
            _buildQuickActionButton(
              Icons.description,
              'Statement',
              'statement',
              secondaryColor,
            ),
            _buildQuickActionButton(
              Icons.trending_up,
              'Invest',
              'investments',
              successColor,
            ),
            _buildQuickActionButton(
              Icons.schedule,
              'Auto Debit',
              'auto-debit',
              dangerColor,
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Personal Details Card
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Personal Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _openEditProfileModal,
                      icon: const Icon(
                        Icons.edit,
                        size: 16,
                        color: primaryColor,
                      ),
                      label: const Text(
                        'Edit',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                _buildSummaryRow('Full Name', user['name']),
                _buildSummaryRow('Email', user['email']),
                _buildSummaryRow('Phone', user['phone']),
                _buildSummaryRow('Address', user['address']),
                _buildSummaryRow('Date of Birth', user['dateOfBirth']),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Recent Transactions Card
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Divider(height: 20),
                ...recentTransactions
                    .take(3)
                    .map(
                      (txn) => ListTile(
                        leading: Icon(
                          txn['type'] == 'credit'
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: txn['type'] == 'credit'
                              ? successColor
                              : dangerColor,
                        ),
                        title: Text(txn['description']),
                        subtitle: Text('${txn['date']} - ${txn['time']}'),
                        trailing: Text(
                          (txn['type'] == 'credit' ? '+' : '-') +
                              _formatCurrency(txn['amount']),
                          style: TextStyle(
                            color: txn['type'] == 'credit'
                                ? successColor
                                : dangerColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                if (recentTransactions.length > 3)
                  Center(
                    child: TextButton(
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Viewing all transactions'),
                            ),
                          ),
                      child: const Text('View All Transactions'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
    IconData icon,
    String label,
    String action,
    Color color,
  ) {
    return InkWell(
      onTap: () => _handleQuickAction(action),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isGradient = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isGradient ? Colors.white70 : Colors.grey[700],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? (isGradient ? Colors.white : Colors.black87),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Setting Row
  Widget _buildSettingRow({
    required String title,
    required String description,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            trailing,
          ],
        ),
      ),
    );
  }

  String _formatCurrency(num amount) => _currencyFormat.format(amount);

  Color _statusColor(String status) {
    if (status == 'active') return successColor;
    if (status == 'paused') return Colors.orange.shade800;
    return dangerColor;
  }

  Color _statusBackgroundColor(String status) {
    if (status == 'active') return successColor.withOpacity(0.1);
    if (status == 'paused') return Colors.orange.shade100;
    return dangerColor.withOpacity(0.1);
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildAccountDetailsTab() {
    return Column(
      children: [
        // --- Account Summary ---
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account Summary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.white54, height: 20),
              _buildSummaryRow(
                'Account Number',
                user['accountNumber'] ?? 'N/A',
                isGradient: true,
              ),
              _buildSummaryRow(
                'IFSC Code',
                user['ifscCode'] ?? 'N/A',
                isGradient: true,
              ),
              _buildSummaryRow(
                'Account Type',
                user['accountType'] ?? 'N/A',
                isGradient: true,
              ),
              _buildSummaryRow(
                'KYC Status',
                user['kycStatus'] ?? 'Pending',
                isGradient: true,
                valueColor: user['kycStatus'] == 'Verified'
                    ? successColor
                    : dangerColor,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // --- Banking Services + Account Limits Card ---
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Banking Services ---
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Banking Services',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildRow('Internet Banking', 'Active'),
                      _buildRow('Mobile Banking', 'Active'),
                      _buildRow('SMS Alerts', 'Enabled'),
                      _buildRow('Email Notifications', 'Enabled'),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // --- Account Limits ---
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Account Limits',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildRow('Daily Transfer Limit', '₹1,00,000'),
                      _buildRow('ATM Withdrawal Limit', '₹50,000'),
                      _buildRow('Online Purchase Limit', '₹2,00,000'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAutoDebitTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Active Auto Debits',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () => _handleAutoDebitAction('add', 0),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Add New',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (autoDebits.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'No active auto debits found.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          ...autoDebits.map((debit) {
            final isPaused = debit['status'] == 'paused';
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.repeat, color: primaryColor),
                ),
                title: Text(
                  debit['name'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${debit['frequency']} - ${_formatCurrency(debit['amount'])}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _statusBackgroundColor(debit['status']),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            debit['status'].toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _statusColor(debit['status']),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Next: ${debit['nextDate']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.grey[600], size: 20),
                      onPressed: () =>
                          _handleAutoDebitAction('edit', debit['id']),
                    ),
                    IconButton(
                      icon: Icon(
                        isPaused ? Icons.play_arrow : Icons.pause,
                        color: isPaused ? successColor : Colors.orange,
                        size: 20,
                      ),
                      onPressed: () =>
                          _handleAutoDebitAction('pause_toggle', debit['id']),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: dangerColor, size: 20),
                      onPressed: () =>
                          _handleAutoDebitAction('delete', debit['id']),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildSecurityTab() {
    return Column(
      children: [
        // --- Two-Factor Authentication ---
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Two-Factor Authentication',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Add an extra layer of security to your account',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Manage Settings',
                        style: TextStyle(
                          color: Color(0xFF900603),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: const Text(
                    'Enabled',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // --- Change Password ---
        _buildSecurityActionCard(
          title: 'Login Password',
          description: 'Change your main login password for secure access.',
          buttonText: 'Change Password',
          onTap: _openChangePasswordModal,
          lastUpdated: 'Last updated 30 days ago',
        ),

        const SizedBox(height: 16),

        // --- Change PIN ---
        _buildSecurityActionCard(
          title: 'Transaction PIN',
          description:
              'Update your 4-digit PIN used for financial transactions.',
          buttonText: 'Change PIN',
          onTap: _openChangePinModal,
          lastUpdated: 'Last updated 15 days ago',
        ),

        const SizedBox(height: 16),

        // --- Recent Login Activity ---
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Login Activity',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Divider(height: 20),
                ...loginActivity.map((activity) {
                  final isCurrent = activity['device'].toString().contains(
                    'Current',
                  );
                  final isSuccess = activity['status'] == 'success';

                  return ListTile(
                    leading: Icon(
                      activity['device'].toString().contains('Mobile')
                          ? Icons.smartphone
                          : activity['device'].toString().contains('Tablet')
                          ? Icons.tablet
                          : Icons.web,
                      color: isCurrent ? primaryColor : Colors.grey[700],
                    ),
                    title: Text(activity['device']),
                    subtitle: Text(
                      '${activity['location']} - ${activity['time']}',
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                        color: isSuccess ? Colors.green[100] : Colors.red[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      child: Text(
                        isSuccess ? 'Successful' : 'Failed',
                        style: TextStyle(
                          color: isSuccess ? Colors.green : Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logging out all other devices...'),
                    ),
                  ),
                  icon: const Icon(Icons.logout, color: dangerColor),
                  label: const Text(
                    'Log out all other devices',
                    style: TextStyle(color: dangerColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityActionCard({
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
    String? lastUpdated,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  if (lastUpdated != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      lastUpdated,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 9,
                ),
                minimumSize: const Size(0, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13, // smaller text
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTab() {
    final primaryColor = const Color(0xFF900603);
    // const dangerColor = Colors.red;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Application & Communication Settings",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              //NOTIFICATIONS SECTION
              const Text(
                "Notifications",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              _buildSettingRow(
                title: 'Email Transaction Alerts',
                description:
                    'Receive email notifications for all transactions.',
                trailing: Switch(
                  value: _emailAlerts,
                  onChanged: (val) => setState(() => _emailAlerts = val),
                  activeColor: primaryColor,
                ),
              ),
              _buildSettingRow(
                title: 'Promotional Offers',
                description:
                    'Receive special offers and marketing communication.',
                trailing: Switch(
                  value: _promoOffers,
                  onChanged: (val) => setState(() => _promoOffers = val),
                  activeColor: primaryColor,
                ),
              ),
              _buildSettingRow(
                title: 'Push Notifications',
                description:
                    'Allow app to send push notifications for banking activities.',
                trailing: Switch(
                  value: _pushNotifications,
                  onChanged: (val) => setState(() => _pushNotifications = val),
                  activeColor: primaryColor,
                ),
              ),

              const Divider(height: 32),

              //ACCOUNT MANAGEMENT SECTION
              const Text(
                "Account Management",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              _buildSettingRow(
                title: 'Set Default Language',
                description: 'Choose preferred display language.',
                trailing: DropdownButton<String>(
                  value: _language,
                  items: ['English (US)', 'Hindi (IN)', 'Marathi (IN)']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: primaryColor),
                          ),
                        );
                      })
                      .toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _language = newValue;
                      });
                    }
                  },
                  underline: Container(),
                ),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Download Terms & Conditions"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.download, color: Colors.black54),
                    SizedBox(width: 5),
                    Text("Download PDF"),
                  ],
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading PDF...')),
                  );
                },
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  "Deactivate Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Permanently close your account and end all services.",
                ),
                trailing: Switch(
                  value: _deactivateAccount,
                  onChanged: (val) => setState(() => _deactivateAccount = val),
                  activeColor: Color(0xFF900603),
                ),
              ),

              const Divider(height: 32),

              // EXISTING SETTINGS (Biometric, Theme, Logout)
              const Text(
                "App Preferences",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              _buildSettingRow(
                title: 'Biometric Login (Face ID/Fingerprint)',
                description:
                    'Use your device\'s biometrics for quick and secure sign-in.',
                trailing: Switch(
                  value: _biometricLogin,
                  onChanged: (val) => setState(() => _biometricLogin = val),
                  activeColor: primaryColor,
                ),
              ),
              _buildSettingRow(
                title: 'App Theme',
                description:
                    'Switch between light, dark, or system default mode.',
                trailing: DropdownButton<String>(
                  value: _theme,
                  items: ['system', 'light', 'dark']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value.toUpperCase(),
                            style: TextStyle(color: primaryColor),
                          ),
                        );
                      })
                      .toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _theme = newValue;
                      });
                    }
                  },
                  underline: Container(),
                ),
              ),

              const Divider(height: 20),
              Center(
                child: TextButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logging out...')),
                  ),
                  icon: const Icon(Icons.logout, color: Color(0xFF900603)),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Color(0xFF900603),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTabContent() {
    switch (activeTab) {
      case 'overview':
        return _buildOverviewTab();
      case 'account':
        return _buildAccountDetailsTab();
      case 'auto-debit':
        return _buildAutoDebitTab();
      case 'security':
        return _buildSecurityTab();
      case 'settings':
        return _buildSettingsTab();
      default:
        return const Center(child: Text('Select a tab.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Column(
        children: [
          // Profile header
          _buildProfileHeader(),

          // Tab buttons
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tabButton('overview', Icons.person_outline, 'Overview'),
                _tabButton(
                  'account',
                  Icons.account_balance_wallet_outlined,
                  'Account',
                ),
                _tabButton('auto-debit', Icons.schedule, 'Auto Debit'),
                _tabButton('security', Icons.security, 'Security'),
                _tabButton('settings', Icons.settings_outlined, 'Settings'),
              ],
            ),
          ),

          // Active tab content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: _buildActiveTabContent(),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:neobank/widgets/topbar.dart';

// // Primary Color from CSS: #900603 (Deep Maroon)
// const Color primaryColor = Color(0xFF900603);
// // Secondary/Highlight Color from CSS: #b91c1c
// const Color secondaryColor = Color(0xFFb91c1c);
// // Success Color from CSS: #065f46
// const Color successColor = Color(0xFF065f46);
// // Danger Color from CSS: #991b1b
// const Color dangerColor = Color(0xFF991b1b);
// // Background Color from CSS: #f8f9fa
// const Color backgroundColor = Color(0xFFF8F9FA);

// class ProfileSection extends StatefulWidget {
//   const ProfileSection({super.key});

//   @override
//   State<ProfileSection> createState() => _ProfileSectionState();
// }

// class _ProfileSectionState extends State<ProfileSection> {
//   // UI state
//   String activeTab = 'overview';
//   bool showBalance = false;

//   // Form controllers / state
//   final _editNameController = TextEditingController();
//   final _editEmailController = TextEditingController();
//   final _editAddressController = TextEditingController();

//   final _currentPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   final _currentPinController = TextEditingController();
//   final _newPinController = TextEditingController();
//   final _confirmPinController = TextEditingController();

//   // Settings state
//   bool _pushNotifications = true;
//   bool _biometricLogin = false;
//   String _language = 'English (US)';
//   String _theme = 'system';

//   // Image
//   File? _profileImageFile;
//   final ImagePicker _picker = ImagePicker();

//   // Sample user / data (mirrors React defaults)
//   Map<String, dynamic> user = {
//     'name': 'Amit Rajput',
//     'email': 'amit.rajput@email.com',
//     'phone': '+91 98765 43210',
//     'address': 'Mumbai, Maharashtra, India',
//     'dateOfBirth': '15/08/1990',
//     'accountNumber': '****1234',
//     'accountType': 'Premium Savings',
//     'balance': 48748.00,
//     'ifscCode': 'ABCD0001234',
//     'kycStatus': 'Verified',
//     'profileImage': null,
//   };

//   List<Map<String, dynamic>> autoDebits = [
//     {
//       'id': 1,
//       'name': 'Electricity Bill - MSEB',
//       'category': 'utilities',
//       'amount': 2500,
//       'frequency': 'Monthly',
//       'nextDate': '2025-02-05',
//       'status': 'active',
//     },
//     {
//       'id': 2,
//       'name': 'Mobile Postpaid - Airtel',
//       'category': 'telecom',
//       'amount': 999,
//       'frequency': 'Monthly',
//       'nextDate': '2025-02-10',
//       'status': 'active',
//     },
//     {
//       'id': 3,
//       'name': 'Home Loan EMI - HDFC',
//       'category': 'loans',
//       'amount': 45000,
//       'frequency': 'Monthly',
//       'nextDate': '2025-02-07',
//       'status': 'paused',
//     },
//     {
//       'id': 4,
//       'name': 'Netflix Subscription',
//       'category': 'entertainment',
//       'amount': 645,
//       'frequency': 'Monthly',
//       'nextDate': '2025-02-15',
//       'status': 'active',
//     },
//     {
//       'id': 5,
//       'name': 'Life Insurance Premium',
//       'category': 'insurance',
//       'amount': 12000,
//       'frequency': 'Quarterly',
//       'nextDate': '2025-03-01',
//       'status': 'active',
//     },
//   ];

//   final List<Map<String, dynamic>> recentTransactions = [
//     {
//       'id': 1,
//       'type': 'credit',
//       'amount': 5000,
//       'description': 'Salary Credit',
//       'date': '2025-01-15',
//       'time': '09:30 AM',
//     },
//     {
//       'id': 2,
//       'type': 'debit',
//       'amount': 1200,
//       'description': 'Online Shopping',
//       'date': '2025-01-14',
//       'time': '02:15 PM',
//     },
//     {
//       'id': 3,
//       'type': 'debit',
//       'amount': 800,
//       'description': 'Utility Bills',
//       'date': '2025-01-13',
//       'time': '11:45 AM',
//     },
//     {
//       'id': 4,
//       'type': 'credit',
//       'amount': 2500,
//       'description': 'Investment Return',
//       'date': '2025-01-12',
//       'time': '04:20 PM',
//     },
//   ];

//   final List<Map<String, dynamic>> loginActivity = [
//     {
//       'id': 1,
//       'device': 'Mobile App (Current Session)',
//       'location': 'Mumbai, India',
//       'time': 'Just now',
//       'status': 'success',
//     },
//     {
//       'id': 2,
//       'device': 'Web Browser',
//       'location': 'Delhi, India',
//       'time': 'Yesterday, 10:00 PM',
//       'status': 'success',
//     },
//     {
//       'id': 3,
//       'device': 'Tablet',
//       'location': 'Mumbai, India',
//       'time': '3 days ago, 03:45 PM',
//       'status': 'failed',
//     },
//   ];

//   final NumberFormat _currencyFormat = NumberFormat.currency(
//     locale: 'en_IN',
//     symbol: '₹',
//     decimalDigits: 2,
//   );

//   // --- Lifecycle ---
//   @override
//   void dispose() {
//     _editNameController.dispose();
//     _editEmailController.dispose();
//     _editAddressController.dispose();
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     _currentPinController.dispose();
//     _newPinController.dispose();
//     _confirmPinController.dispose();
//     super.dispose();
//   }

//   // --- Actions ---
//   Future<void> _pickProfileImage() async {
//     final XFile? picked = await _picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 800,
//       maxHeight: 800,
//     );
//     if (picked != null) {
//       setState(() {
//         _profileImageFile = File(picked.path);
//       });
//     }
//   }

//   void _openEditProfileModal() {
//     _editNameController.text = user['name'] ?? '';
//     _editEmailController.text = user['email'] ?? '';
//     _editAddressController.text = user['address'] ?? '';

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Edit Personal Information'),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _editNameController,
//                 decoration: const InputDecoration(labelText: 'Full Name'),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _editEmailController,
//                 decoration: const InputDecoration(labelText: 'Email Address'),
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _editAddressController,
//                 decoration: const InputDecoration(labelText: 'Address'),
//                 maxLines: 3,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//             onPressed: () {
//               if (_editNameController.text.isEmpty ||
//                   _editEmailController.text.isEmpty ||
//                   _editAddressController.text.isEmpty) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Please fill in all fields')),
//                 );
//                 return;
//               }
//               setState(() {
//                 user['name'] = _editNameController.text.trim();
//                 user['email'] = _editEmailController.text.trim();
//                 user['address'] = _editAddressController.text.trim();
//                 // In a real app, you'd handle the image upload here
//               });
//               Navigator.of(context).pop();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Profile updated successfully')),
//               );
//             },
//             child: const Text(
//               'Save Changes',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _openChangePasswordModal() {
//     _currentPasswordController.clear();
//     _newPasswordController.clear();
//     _confirmPasswordController.clear();

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Change Login Password'),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _currentPasswordController,
//                 decoration: const InputDecoration(
//                   labelText: 'Current Password',
//                 ),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _newPasswordController,
//                 decoration: const InputDecoration(
//                   labelText: 'New Password (Min 8 characters)',
//                 ),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _confirmPasswordController,
//                 decoration: const InputDecoration(
//                   labelText: 'Confirm New Password',
//                 ),
//                 obscureText: true,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//             onPressed: () {
//               final newP = _newPasswordController.text;
//               final confirmP = _confirmPasswordController.text;
//               if (newP != confirmP) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('New passwords do not match')),
//                 );
//                 return;
//               }
//               if (newP.length < 8) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Password must be at least 8 characters'),
//                   ),
//                 );
//                 return;
//               }
//               Navigator.of(context).pop();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Password changed successfully')),
//               );
//             },
//             child: const Text(
//               'Change Password',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _openChangePinModal() {
//     _currentPinController.clear();
//     _newPinController.clear();
//     _confirmPinController.clear();

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Change Transaction PIN'),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _currentPinController,
//                 decoration: const InputDecoration(labelText: 'Current PIN'),
//                 keyboardType: TextInputType.number,
//                 obscureText: true,
//                 maxLength: 4,
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _newPinController,
//                 decoration: const InputDecoration(labelText: 'New 4-Digit PIN'),
//                 keyboardType: TextInputType.number,
//                 obscureText: true,
//                 maxLength: 4,
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _confirmPinController,
//                 decoration: const InputDecoration(labelText: 'Confirm New PIN'),
//                 keyboardType: TextInputType.number,
//                 obscureText: true,
//                 maxLength: 4,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//             onPressed: () {
//               final newPin = _newPinController.text;
//               final confirmPin = _confirmPinController.text;
//               if (newPin != confirmPin) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('PINs do not match')),
//                 );
//                 return;
//               }
//               if (newPin.length != 4 || int.tryParse(newPin) == null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('PIN must be exactly 4 digits')),
//                 );
//                 return;
//               }
//               Navigator.of(context).pop();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Transaction PIN changed successfully'),
//                 ),
//               );
//             },
//             child: const Text(
//               'Change PIN',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _handleQuickAction(String action) {
//     switch (action) {
//       case 'transfer':
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Redirecting to Money Transfer...')),
//         );
//         break;
//       case 'statement':
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Downloading account statement...')),
//         );
//         break;
//       case 'investments':
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Opening investment portfolio...')),
//         );
//         break;
//       case 'auto-debit':
//         setState(() {
//           activeTab = 'auto-debit';
//         });
//         break;
//       default:
//         break;
//     }
//   }

//   void _handleAutoDebitAction(String action, int id) {
//     if (action == 'add') {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Opening Add New Auto Debit form...')),
//       );
//     } else if (action == 'edit') {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Editing Auto Debit ID: $id')));
//     } else if (action == 'pause_toggle') {
//       setState(() {
//         autoDebits = autoDebits.map((d) {
//           if (d['id'] == id) {
//             return {
//               ...d,
//               'status': d['status'] == 'active' ? 'paused' : 'active',
//             };
//           }
//           return d;
//         }).toList();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Auto Debit ${autoDebits.firstWhere((d) => d['id'] == id)['name']} ${autoDebits.firstWhere((d) => d['id'] == id)['status']}',
//             ),
//           ),
//         );
//       });
//     } else if (action == 'delete') {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text('Delete Auto Debit'),
//           content: const Text(
//             'Are you sure you want to delete this auto debit?',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: dangerColor),
//               onPressed: () {
//                 setState(() {
//                   autoDebits.removeWhere((d) => d['id'] == id);
//                 });
//                 Navigator.of(context).pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Auto Debit deleted')),
//                 );
//               },
//               child: const Text(
//                 'Delete',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   // --- UI helpers ---
//   Widget _tabButton(String id, IconData icon, String label) {
//     final bool active = activeTab == id;
//     return Expanded(
//       child: InkWell(
//         onTap: () => setState(() => activeTab = id),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//             color: active ? primaryColor.withOpacity(0.05) : Colors.transparent,
//             border: active
//                 ? const Border(
//                     bottom: BorderSide(width: 3, color: primaryColor),
//                   )
//                 : null,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 icon,
//                 size: 18,
//                 color: active ? primaryColor : Colors.grey[700],
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: active ? primaryColor : Colors.grey[800],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String _formatCurrency(num amount) => _currencyFormat.format(amount);

//   Color _statusColor(String status) {
//     if (status == 'active') return successColor;
//     if (status == 'paused') return Colors.orange.shade800;
//     return dangerColor;
//   }

//   Color _statusBackgroundColor(String status) {
//     if (status == 'active') return successColor.withOpacity(0.1);
//     if (status == 'paused') return Colors.orange.shade100;
//     return dangerColor.withOpacity(0.1);
//   }

//   // --- Tab Content Builders ---

//   Widget _buildAccountDetailsTab() {
//     return Column(
//       children: [
//         // Account Summary Card
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: primaryColor,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 8,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Account Summary',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Divider(color: Colors.white54, height: 20),
//               _buildSummaryRow(
//                 'Account Number',
//                 user['accountNumber'] ?? 'N/A',
//                 isGradient: true,
//               ),
//               _buildSummaryRow(
//                 'IFSC Code',
//                 user['ifscCode'] ?? 'N/A',
//                 isGradient: true,
//               ),
//               _buildSummaryRow(
//                 'Account Type',
//                 user['accountType'] ?? 'N/A',
//                 isGradient: true,
//               ),
//               _buildSummaryRow(
//                 'KYC Status',
//                 user['kycStatus'] ?? 'Pending',
//                 isGradient: true,
//                 valueColor: user['kycStatus'] == 'Verified'
//                     ? successColor
//                     : dangerColor,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         // Other Services / Actions
//         Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Account Services',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const Divider(height: 20),
//                 _buildSettingRow(
//                   title: 'Request Cheque Book',
//                   description: 'Order a new cheque book for your account.',
//                   trailing: const Icon(Icons.chevron_right),
//                   onTap: () => ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Cheque book requested')),
//                   ),
//                 ),
//                 _buildSettingRow(
//                   title: 'Generate Mini Statement',
//                   description: 'View the last 10 transactions instantly.',
//                   trailing: const Icon(Icons.chevron_right),
//                   onTap: () => ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Mini statement generated')),
//                   ),
//                 ),
//                 _buildSettingRow(
//                   title: 'Update Nominee Details',
//                   description: 'Review or update your nominated beneficiary.',
//                   trailing: const Icon(Icons.chevron_right),
//                   onTap: () => ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Opening Nominee form')),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAutoDebitTab() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Active Auto Debits',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             ElevatedButton.icon(
//               onPressed: () => _handleAutoDebitAction('add', 0),
//               icon: const Icon(Icons.add, color: Colors.white),
//               label: const Text(
//                 'Add New',
//                 style: TextStyle(color: Colors.white),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         if (autoDebits.isEmpty)
//           const Center(
//             child: Padding(
//               padding: EdgeInsets.all(32.0),
//               child: Text(
//                 'No active auto debits found.',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           )
//         else
//           ...autoDebits.map((debit) {
//             final isPaused = debit['status'] == 'paused';
//             return Card(
//               margin: const EdgeInsets.only(bottom: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ListTile(
//                 leading: Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Icon(Icons.repeat, color: primaryColor),
//                 ),
//                 title: Text(
//                   debit['name'],
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${debit['frequency']} - ${_formatCurrency(debit['amount'])}',
//                       style: TextStyle(color: Colors.grey[700]),
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: _statusBackgroundColor(debit['status']),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             debit['status'].toString().toUpperCase(),
//                             style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                               color: _statusColor(debit['status']),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Next: ${debit['nextDate']}',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit, color: Colors.grey[600], size: 20),
//                       onPressed: () =>
//                           _handleAutoDebitAction('edit', debit['id']),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         isPaused ? Icons.play_arrow : Icons.pause,
//                         color: isPaused ? successColor : Colors.orange,
//                         size: 20,
//                       ),
//                       onPressed: () =>
//                           _handleAutoDebitAction('pause_toggle', debit['id']),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete, color: dangerColor, size: 20),
//                       onPressed: () =>
//                           _handleAutoDebitAction('delete', debit['id']),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//       ],
//     );
//   }

//   Widget _buildSecurityTab() {
//     return Column(
//       children: [
//         // Change Password
//         _buildSecurityActionCard(
//           title: 'Login Password',
//           description: 'Change your main login password for secure access.',
//           buttonText: 'Change Password',
//           onTap: _openChangePasswordModal,
//         ),
//         const SizedBox(height: 16),
//         // Change PIN
//         _buildSecurityActionCard(
//           title: 'Transaction PIN',
//           description:
//               'Update your 4-digit PIN used for financial transactions.',
//           buttonText: 'Change PIN',
//           onTap: _openChangePinModal,
//         ),
//         const SizedBox(height: 16),
//         // Login Activity
//         Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Recent Login Activity',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const Divider(height: 20),
//                 ...loginActivity.map((activity) {
//                   final isCurrent = activity['device'].toString().contains(
//                     'Current',
//                   );
//                   final isSuccess = activity['status'] == 'success';
//                   return ListTile(
//                     leading: Icon(
//                       activity['device'].toString().contains('Mobile')
//                           ? Icons.smartphone
//                           : Icons.web,
//                       color: isCurrent ? primaryColor : Colors.grey[700],
//                     ),
//                     title: Text(activity['device']),
//                     subtitle: Text(
//                       '${activity['location']} - ${activity['time']}',
//                     ),
//                     trailing: Text(
//                       isSuccess ? 'Success' : 'Failed',
//                       style: TextStyle(
//                         color: isSuccess ? successColor : dangerColor,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   );
//                 }),
//                 const SizedBox(height: 8),
//                 TextButton.icon(
//                   onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Logging out all other devices...'),
//                     ),
//                   ),
//                   icon: const Icon(Icons.logout, color: dangerColor),
//                   label: const Text(
//                     'Log out all other devices',
//                     style: TextStyle(color: dangerColor),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSecurityActionCard({
//     required String title,
//     required String description,
//     required String buttonText,
//     required VoidCallback onTap,
//   }) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     description,
//                     style: TextStyle(color: Colors.grey[600], fontSize: 13),
//                   ),
//                 ],
//               ),
//             ),
//             ElevatedButton(
//               onPressed: onTap,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 buttonText,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSettingsTab() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Push Notifications
//             _buildSettingRow(
//               title: 'Push Notifications',
//               description:
//                   'Receive instant alerts for transactions and updates.',
//               trailing: Switch(
//                 value: _pushNotifications,
//                 onChanged: (val) => setState(() => _pushNotifications = val),
//                 activeColor: primaryColor,
//               ),
//             ),
//             // Biometric Login
//             _buildSettingRow(
//               title: 'Biometric Login (Face ID/Fingerprint)',
//               description:
//                   'Use your device\'s biometrics for quick and secure sign-in.',
//               trailing: Switch(
//                 value: _biometricLogin,
//                 onChanged: (val) => setState(() => _biometricLogin = val),
//                 activeColor: primaryColor,
//               ),
//             ),
//             // Language
//             _buildSettingRow(
//               title: 'App Language',
//               description:
//                   'Select your preferred language for the application interface.',
//               trailing: DropdownButton<String>(
//                 value: _language,
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     setState(() => _language = newValue);
//                   }
//                 },
//                 items: <String>['English (US)', 'Hindi', 'Marathi']
//                     .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     })
//                     .toList(),
//               ),
//             ),
//             // Theme
//             _buildSettingRow(
//               title: 'App Theme',
//               description:
//                   'Switch between light, dark, or system default theme.',
//               trailing: DropdownButton<String>(
//                 value: _theme,
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     setState(() => _theme = newValue);
//                   }
//                 },
//                 items: <String>['system', 'light', 'dark']
//                     .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value.toUpperCase()),
//                       );
//                     })
//                     .toList(),
//               ),
//             ),
//             // Log Out Button
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: Align(
//                 alignment: Alignment.center,
//                 child: TextButton.icon(
//                   onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Logging out...')),
//                   ),
//                   icon: const Icon(Icons.logout, color: dangerColor),
//                   label: const Text(
//                     'Log Out',
//                     style: TextStyle(color: dangerColor),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryRow(
//     String label,
//     String value, {
//     bool isGradient = false,
//     Color? valueColor,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               color: isGradient ? Colors.white70 : Colors.grey[600],
//               fontSize: 14,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               color: valueColor ?? (isGradient ? Colors.white : Colors.black),
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               fontFamily: (label == 'Account Number' || label == 'IFSC Code')
//                   ? 'monospace'
//                   : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSettingRow({
//     required String title,
//     required String description,
//     required Widget trailing,
//     VoidCallback? onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 15,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     description,
//                     style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 16),
//             trailing,
//           ],
//         ),
//       ),
//     );
//   }

//   // --- Build ---
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const NavbarTop(), // Custom top bar
//       backgroundColor: const Color(0xFFF8F9FA),
//       resizeToAvoidBottomInset: true,
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//           child: Column(
//             children: [
//               // --- Profile Header ---
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [primaryColor, secondaryColor],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     // Avatar + edit icon wrapped in fixed SizedBox
//                     SizedBox(
//                       width: 72,
//                       height: 72,
//                       child: Stack(
//                         children: [
//                           CircleAvatar(
//                             radius: 36,
//                             backgroundColor: Colors.white24,
//                             backgroundImage: _profileImageFile != null
//                                 ? FileImage(_profileImageFile!)
//                                 : (user['profileImage'] != null
//                                           ? NetworkImage(user['profileImage'])
//                                           : null)
//                                       as ImageProvider<Object>?,
//                             child:
//                                 (_profileImageFile == null &&
//                                     user['profileImage'] == null)
//                                 ? const Icon(
//                                     Icons.person,
//                                     size: 36,
//                                     color: Colors.white,
//                                   )
//                                 : null,
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: GestureDetector(
//                               // ⭐ ADD THIS LINE ⭐
//                               behavior: HitTestBehavior.translucent,
//                               onTap: _pickProfileImage,
//                               child: Container(
//                                 padding: const EdgeInsets.all(4),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                     color: Colors.white,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 child: const Icon(
//                                   Icons.edit,
//                                   size: 16,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     // User Info
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             user['name'] ?? '',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             user['accountType'] ?? '',
//                             style: const TextStyle(
//                               color: Colors.white70,
//                               fontSize: 13,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             user['email'] ?? '',
//                             style: const TextStyle(
//                               color: Colors.white60,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Balance
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         const Text(
//                           'Available Balance',
//                           style: TextStyle(fontSize: 12, color: Colors.white70),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           showBalance
//                               ? _formatCurrency(user['balance'])
//                               : '••••••',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // --- Tabs Row ---
//               Container(
//                 color: Colors.white,
//                 child: Row(
//                   children: [
//                     _tabButton('overview', Icons.person_outline, 'Overview'),
//                     _tabButton('account', Icons.credit_card, 'Account'),
//                     _tabButton('auto-debit', Icons.autorenew, 'Auto Debit'),
//                     _tabButton('security', Icons.shield_outlined, 'Security'),
//                     _tabButton('settings', Icons.settings_outlined, 'Settings'),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Main content
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (activeTab == 'overview') ...[
//                         // Uses ps-grid layout (2:1 or 1fr)
//                         LayoutBuilder(
//                           builder: (context, constraints) {
//                             final isWide = constraints.maxWidth > 800;
//                             return isWide
//                                 ? Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Expanded(
//                                         flex: 2,
//                                         child: _buildOverviewDetails(),
//                                       ),
//                                       const SizedBox(width: 16),
//                                       Expanded(
//                                         flex: 1,
//                                         child: _buildQuickActions(),
//                                       ),
//                                     ],
//                                   )
//                                 : Column(
//                                     children: [
//                                       _buildOverviewDetails(),
//                                       const SizedBox(height: 16),
//                                       _buildQuickActions(),
//                                     ],
//                                   );
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         _buildRecentTransactions(),
//                       ] else if (activeTab == 'account')
//                         _buildAccountDetailsTab()
//                       else if (activeTab == 'auto-debit')
//                         _buildAutoDebitTab()
//                       else if (activeTab == 'security')
//                         _buildSecurityTab()
//                       else if (activeTab == 'settings')
//                         _buildSettingsTab(),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper for Overview Tab (Personal Info)
//   Widget _buildOverviewDetails() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Expanded(
//                   child: Text(
//                     'Personal Information',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 TextButton.icon(
//                   onPressed: _openEditProfileModal,
//                   icon: const Icon(Icons.edit, size: 18, color: primaryColor),
//                   label: const Text(
//                     'Edit',
//                     style: TextStyle(color: primaryColor),
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 20),
//             _buildDetailRow([
//               _buildDetailItem('Full Name', user['name']),
//               _buildDetailItem('Email Address', user['email']),
//             ]),
//             _buildDetailRow([
//               _buildDetailItem('Phone Number', user['phone']),
//               _buildDetailItem('Date of Birth', user['dateOfBirth']),
//             ]),
//             _buildDetailRow([
//               _buildDetailItem('Address', user['address'], isFullWidth: true),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper for Overview Tab (Quick Actions)
//   Widget _buildQuickActions() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Quick Actions',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const Divider(height: 20),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 _buildQuickActionButton(
//                   'transfer',
//                   Icons.currency_rupee,
//                   'Transfer',
//                 ),
//                 _buildQuickActionButton(
//                   'auto-debit',
//                   Icons.autorenew,
//                   'Manage Auto Debit',
//                 ),
//                 _buildQuickActionButton(
//                   'statement',
//                   Icons.download,
//                   'Download Statement',
//                 ),
//                 _buildQuickActionButton(
//                   'investments',
//                   Icons.trending_up,
//                   'View Investments',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper for Overview Tab (Recent Transactions)
//   Widget _buildRecentTransactions() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Expanded(
//                   child: Text(
//                     'Recent Transactions',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 TextButton.icon(
//                   onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Showing all transactions')),
//                   ),
//                   icon: const Icon(Icons.chevron_right, color: primaryColor),
//                   label: const Text(
//                     'View All',
//                     style: TextStyle(color: primaryColor),
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 20),
//             Column(
//               children: recentTransactions.map((tx) {
//                 final bool credit = tx['type'] == 'credit';
//                 return ListTile(
//                   leading: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: credit
//                           ? successColor.withOpacity(0.1)
//                           : dangerColor.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       credit ? Icons.arrow_upward : Icons.arrow_downward,
//                       color: credit ? successColor : dangerColor,
//                       size: 20,
//                     ),
//                   ),
//                   title: Text(tx['description']),
//                   subtitle: Text(
//                     '${tx['date']} • ${tx['time']}',
//                     style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                   ),
//                   trailing: Text(
//                     (credit ? '+' : '-') + _formatCurrency(tx['amount']),
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: credit ? successColor : dangerColor,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(List<Widget> children) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: children.map((item) => Expanded(child: item)).toList(),
//       ),
//     );
//   }

//   Widget _buildDetailItem(
//     String label,
//     String? value, {
//     bool isFullWidth = false,
//   }) {
//     return Padding(
//       padding: EdgeInsets.only(right: isFullWidth ? 0 : 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//           const SizedBox(height: 4),
//           Text(
//             value ?? 'N/A',
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuickActionButton(String action, IconData icon, String label) {
//     return ElevatedButton.icon(
//       onPressed: () => _handleQuickAction(action),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         elevation: 2,
//       ),
//       icon: Icon(icon, size: 18),
//       label: Text(
//         label,
//         style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//       ),
//     );
//   }
// }

// // The rest of the main Widget (build method) is included above.
// // The code now compiles and implements all requested tabs and functionality.

// // import 'dart:io';

// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:intl/intl.dart';

// // class ProfileSection extends StatefulWidget {
// //   const ProfileSection({super.key});

// //   @override
// //   State<ProfileSection> createState() => _ProfileSectionState();
// // }

// // class _ProfileSectionState extends State<ProfileSection> {
// //   // UI state
// //   String activeTab = 'overview';
// //   bool showBalance = false;

// //   // Form controllers / state
// //   final _editNameController = TextEditingController();
// //   final _editEmailController = TextEditingController();
// //   final _editAddressController = TextEditingController();

// //   final _currentPasswordController = TextEditingController();
// //   final _newPasswordController = TextEditingController();
// //   final _confirmPasswordController = TextEditingController();

// //   final _currentPinController = TextEditingController();
// //   final _newPinController = TextEditingController();
// //   final _confirmPinController = TextEditingController();

// //   // Image
// //   File? _profileImageFile;
// //   final ImagePicker _picker = ImagePicker();

// //   // Sample user / data (mirrors React defaults)
// //   Map<String, dynamic> user = {
// //     'name': 'Amit Rajput',
// //     'email': 'amit.rajput@email.com',
// //     'phone': '+91 98765 43210',
// //     'address': 'Mumbai, Maharashtra, India',
// //     'dateOfBirth': '15/08/1990',
// //     'accountNumber': '****1234',
// //     'accountType': 'Premium Savings',
// //     'balance': 48748.00,
// //     'profileImage':
// //         'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&dpr=1',
// //   };

// //   List<Map<String, dynamic>> autoDebits = [
// //     {
// //       'id': 1,
// //       'name': 'Electricity Bill - MSEB',
// //       'category': 'utilities',
// //       'amount': 2500,
// //       'frequency': 'Monthly',
// //       'nextDate': '2025-02-05',
// //       'status': 'active',
// //     },
// //     {
// //       'id': 2,
// //       'name': 'Mobile Postpaid - Airtel',
// //       'category': 'telecom',
// //       'amount': 999,
// //       'frequency': 'Monthly',
// //       'nextDate': '2025-02-10',
// //       'status': 'active',
// //     },
// //     {
// //       'id': 3,
// //       'name': 'Home Loan EMI - HDFC',
// //       'category': 'loans',
// //       'amount': 45000,
// //       'frequency': 'Monthly',
// //       'nextDate': '2025-02-07',
// //       'status': 'active',
// //     },
// //     {
// //       'id': 4,
// //       'name': 'Netflix Subscription',
// //       'category': 'entertainment',
// //       'amount': 645,
// //       'frequency': 'Monthly',
// //       'nextDate': '2025-02-15',
// //       'status': 'active',
// //     },
// //     {
// //       'id': 5,
// //       'name': 'Life Insurance Premium',
// //       'category': 'insurance',
// //       'amount': 12000,
// //       'frequency': 'Quarterly',
// //       'nextDate': '2025-03-01',
// //       'status': 'active',
// //     },
// //   ];

// //   final List<Map<String, dynamic>> recentTransactions = [
// //     {
// //       'id': 1,
// //       'type': 'credit',
// //       'amount': 5000,
// //       'description': 'Salary Credit',
// //       'date': '2025-01-15',
// //       'time': '09:30 AM',
// //     },
// //     {
// //       'id': 2,
// //       'type': 'debit',
// //       'amount': 1200,
// //       'description': 'Online Shopping',
// //       'date': '2025-01-14',
// //       'time': '02:15 PM',
// //     },
// //     {
// //       'id': 3,
// //       'type': 'debit',
// //       'amount': 800,
// //       'description': 'Utility Bills',
// //       'date': '2025-01-13',
// //       'time': '11:45 AM',
// //     },
// //     {
// //       'id': 4,
// //       'type': 'credit',
// //       'amount': 2500,
// //       'description': 'Investment Return',
// //       'date': '2025-01-12',
// //       'time': '04:20 PM',
// //     },
// //   ];

// //   final List<Map<String, dynamic>> loginActivity = [
// //     {
// //       'id': 1,
// //       'device': 'Mobile App',
// //       'location': 'Delhi, India',
// //       'time': 'Yesterday, 10:00 PM',
// //       'status': 'success',
// //     },
// //     {
// //       'id': 2,
// //       'device': 'Web Browser',
// //       'location': 'Mumbai, India',
// //       'time': '2 days ago, 09:15 AM',
// //       'status': 'success',
// //     },
// //     {
// //       'id': 3,
// //       'device': 'Tablet',
// //       'location': 'Mumbai, India',
// //       'time': '3 days ago, 03:45 PM',
// //       'status': 'failed',
// //     },
// //   ];

// //   final NumberFormat _currencyFormat = NumberFormat.currency(
// //     locale: 'en_IN',
// //     symbol: '₹',
// //   );

// //   // --- Lifecycle ---
// //   @override
// //   void dispose() {
// //     _editNameController.dispose();
// //     _editEmailController.dispose();
// //     _editAddressController.dispose();
// //     _currentPasswordController.dispose();
// //     _newPasswordController.dispose();
// //     _confirmPasswordController.dispose();
// //     _currentPinController.dispose();
// //     _newPinController.dispose();
// //     _confirmPinController.dispose();
// //     super.dispose();
// //   }

// //   // --- Actions ---
// //   Future<void> _pickProfileImage() async {
// //     final XFile? picked = await _picker.pickImage(
// //       source: ImageSource.gallery,
// //       maxWidth: 800,
// //       maxHeight: 800,
// //     );
// //     if (picked != null) {
// //       setState(() {
// //         _profileImageFile = File(picked.path);
// //       });
// //     }
// //   }

// //   void _openEditProfileModal() {
// //     _editNameController.text = user['name'] ?? '';
// //     _editEmailController.text = user['email'] ?? '';
// //     _editAddressController.text = user['address'] ?? '';

// //     showDialog(
// //       context: context,
// //       builder: (_) => AlertDialog(
// //         title: const Text('Edit Personal Information'),
// //         content: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               TextField(
// //                 controller: _editNameController,
// //                 decoration: const InputDecoration(labelText: 'Full Name'),
// //               ),
// //               const SizedBox(height: 8),
// //               TextField(
// //                 controller: _editEmailController,
// //                 decoration: const InputDecoration(labelText: 'Email Address'),
// //                 keyboardType: TextInputType.emailAddress,
// //               ),
// //               const SizedBox(height: 8),
// //               TextField(
// //                 controller: _editAddressController,
// //                 decoration: const InputDecoration(labelText: 'Address'),
// //                 maxLines: 3,
// //               ),
// //             ],
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(),
// //             child: const Text('Cancel'),
// //           ),
// //           ElevatedButton(
// //             onPressed: () {
// //               if (_editNameController.text.isEmpty ||
// //                   _editEmailController.text.isEmpty ||
// //                   _editAddressController.text.isEmpty) {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(content: Text('Please fill in all fields')),
// //                 );
// //                 return;
// //               }
// //               setState(() {
// //                 user['name'] = _editNameController.text.trim();
// //                 user['email'] = _editEmailController.text.trim();
// //                 user['address'] = _editAddressController.text.trim();
// //                 if (_profileImageFile != null) {
// //                   // In a real app you'd upload and get a URL. We'll keep file locally.
// //                   user['profileImage'] = null;
// //                 }
// //               });
// //               Navigator.of(context).pop();
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 const SnackBar(content: Text('Profile updated successfully')),
// //               );
// //             },
// //             child: const Text('Save Changes'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _openChangePasswordModal() {
// //     _currentPasswordController.clear();
// //     _newPasswordController.clear();
// //     _confirmPasswordController.clear();

// //     showDialog(
// //       context: context,
// //       builder: (_) => AlertDialog(
// //         title: const Text('Change Login Password'),
// //         content: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               TextField(
// //                 controller: _currentPasswordController,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Current Password',
// //                 ),
// //                 obscureText: true,
// //               ),
// //               const SizedBox(height: 8),
// //               TextField(
// //                 controller: _newPasswordController,
// //                 decoration: const InputDecoration(
// //                   labelText: 'New Password (Min 8 characters)',
// //                 ),
// //                 obscureText: true,
// //               ),
// //               const SizedBox(height: 8),
// //               TextField(
// //                 controller: _confirmPasswordController,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Confirm New Password',
// //                 ),
// //                 obscureText: true,
// //               ),
// //             ],
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(),
// //             child: const Text('Cancel'),
// //           ),
// //           ElevatedButton(
// //             onPressed: () {
// //               final newP = _newPasswordController.text;
// //               final confirmP = _confirmPasswordController.text;
// //               if (newP != confirmP) {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(content: Text('New passwords do not match')),
// //                 );
// //                 return;
// //               }
// //               if (newP.length < 8) {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(
// //                     content: Text('Password must be at least 8 characters'),
// //                   ),
// //                 );
// //                 return;
// //               }
// //               Navigator.of(context).pop();
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 const SnackBar(content: Text('Password changed successfully')),
// //               );
// //             },
// //             child: const Text('Change Password'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _openChangePinModal() {
// //     _currentPinController.clear();
// //     _newPinController.clear();
// //     _confirmPinController.clear();

// //     showDialog(
// //       context: context,
// //       builder: (_) => AlertDialog(
// //         title: const Text('Change Transaction PIN'),
// //         content: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               TextField(
// //                 controller: _currentPinController,
// //                 decoration: const InputDecoration(labelText: 'Current PIN'),
// //                 keyboardType: TextInputType.number,
// //                 obscureText: true,
// //                 maxLength: 4,
// //               ),
// //               const SizedBox(height: 8),
// //               TextField(
// //                 controller: _newPinController,
// //                 decoration: const InputDecoration(labelText: 'New 4-Digit PIN'),
// //                 keyboardType: TextInputType.number,
// //                 obscureText: true,
// //                 maxLength: 4,
// //               ),
// //               const SizedBox(height: 8),
// //               TextField(
// //                 controller: _confirmPinController,
// //                 decoration: const InputDecoration(labelText: 'Confirm New PIN'),
// //                 keyboardType: TextInputType.number,
// //                 obscureText: true,
// //                 maxLength: 4,
// //               ),
// //             ],
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(),
// //             child: const Text('Cancel'),
// //           ),
// //           ElevatedButton(
// //             onPressed: () {
// //               final newPin = _newPinController.text;
// //               final confirmPin = _confirmPinController.text;
// //               if (newPin != confirmPin) {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(content: Text('PINs do not match')),
// //                 );
// //                 return;
// //               }
// //               if (newPin.length != 4 || int.tryParse(newPin) == null) {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(content: Text('PIN must be exactly 4 digits')),
// //                 );
// //                 return;
// //               }
// //               Navigator.of(context).pop();
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 const SnackBar(
// //                   content: Text('Transaction PIN changed successfully'),
// //                 ),
// //               );
// //             },
// //             child: const Text('Change PIN'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _handleQuickAction(String action) {
// //     switch (action) {
// //       case 'transfer':
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Redirecting to Money Transfer...')),
// //         );
// //         break;
// //       case 'statement':
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Downloading account statement...')),
// //         );
// //         break;
// //       case 'investments':
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Opening investment portfolio...')),
// //         );
// //         break;
// //       case 'auto-debit':
// //         setState(() {
// //           activeTab = 'auto-debit';
// //         });
// //         break;
// //       default:
// //         break;
// //     }
// //   }

// //   void _handleAutoDebitAction(String action, int id) {
// //     if (action == 'add') {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Opening Add New Auto Debit form...')),
// //       );
// //     } else if (action == 'edit') {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text('Editing Auto Debit ID: $id')));
// //     } else if (action == 'pause') {
// //       setState(() {
// //         autoDebits = autoDebits.map((d) {
// //           if (d['id'] == id) {
// //             return {
// //               ...d,
// //               'status': d['status'] == 'active' ? 'paused' : 'active',
// //             };
// //           }
// //           return d;
// //         }).toList();
// //       });
// //     } else if (action == 'delete') {
// //       showDialog(
// //         context: context,
// //         builder: (_) => AlertDialog(
// //           title: const Text('Delete Auto Debit'),
// //           content: const Text(
// //             'Are you sure you want to delete this auto debit?',
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.of(context).pop(),
// //               child: const Text('Cancel'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 setState(() {
// //                   autoDebits.removeWhere((d) => d['id'] == id);
// //                 });
// //                 Navigator.of(context).pop();
// //               },
// //               child: const Text('Delete'),
// //             ),
// //           ],
// //         ),
// //       );
// //     }
// //   }

// //   // --- UI helpers ---
// //   Widget _tabButton(String id, IconData icon, String label) {
// //     final bool active = activeTab == id;
// //     return Expanded(
// //       child: InkWell(
// //         onTap: () => setState(() => activeTab = id),
// //         child: Container(
// //           padding: const EdgeInsets.symmetric(vertical: 10),
// //           decoration: BoxDecoration(
// //             color: active ? Colors.blue.shade50 : Colors.transparent,
// //             border: active
// //                 ? Border(bottom: BorderSide(width: 3, color: Colors.blue))
// //                 : null,
// //           ),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Icon(
// //                 icon,
// //                 size: 18,
// //                 color: active ? Colors.blue : Colors.grey[700],
// //               ),
// //               const SizedBox(height: 4),
// //               Text(
// //                 label,
// //                 style: TextStyle(
// //                   fontSize: 12,
// //                   color: active ? Colors.blue : Colors.grey[800],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   String _formatCurrency(num amount) => _currencyFormat.format(amount);

// //   Color _statusColor(String status) {
// //     if (status == 'active') return Colors.green;
// //     if (status == 'paused') return Colors.orange;
// //     return Colors.red;
// //   }

// //   // --- Build ---
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Profile'),
// //         centerTitle: true,
// //         actions: [
// //           IconButton(
// //             onPressed: () {
// //               setState(() {
// //                 showBalance = !showBalance;
// //               });
// //             },
// //             icon: Icon(showBalance ? Icons.visibility : Icons.visibility_off),
// //           ),
// //           const SizedBox(width: 8),
// //         ],
// //         bottom: PreferredSize(
// //           preferredSize: const Size.fromHeight(62),
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //             child: Row(
// //               children: [
// //                 // Avatar + summary
// //                 GestureDetector(
// //                   onTap: _pickProfileImage,
// //                   child: CircleAvatar(
// //                     radius: 28,
// //                     backgroundImage: _profileImageFile != null
// //                         ? FileImage(_profileImageFile!)
// //                         : (user['profileImage'] != null
// //                                   ? NetworkImage(user['profileImage'])
// //                                   : null)
// //                               as ImageProvider<Object>?,
// //                     child:
// //                         (_profileImageFile == null &&
// //                             user['profileImage'] == null)
// //                         ? const Icon(Icons.person, size: 28)
// //                         : null,
// //                   ),
// //                 ),
// //                 const SizedBox(width: 12),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         user['name'] ?? '',
// //                         style: const TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 2),
// //                       Text(
// //                         'Savings Account',
// //                         style: TextStyle(color: Colors.grey[700]),
// //                       ),
// //                       const SizedBox(height: 2),
// //                       Text(
// //                         user['email'] ?? '',
// //                         style: TextStyle(color: Colors.grey[600], fontSize: 12),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.end,
// //                   children: [
// //                     const Text(
// //                       'Available Balance',
// //                       style: TextStyle(fontSize: 12),
// //                     ),
// //                     const SizedBox(height: 6),
// //                     Text(
// //                       showBalance ? _formatCurrency(user['balance']) : '••••••',
// //                       style: const TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: Column(
// //         children: [
// //           // Tabs (row)
// //           Container(
// //             color: Colors.grey[100],
// //             child: Row(
// //               children: [
// //                 _tabButton('overview', Icons.person, 'Overview'),
// //                 _tabButton('account', Icons.credit_card, 'Account Details'),
// //                 _tabButton('auto-debit', Icons.autorenew, 'Auto Debit'),
// //                 _tabButton('security', Icons.shield, 'Security'),
// //                 _tabButton('settings', Icons.settings, 'Settings'),
// //               ],
// //             ),
// //           ),

// //           // Main content
// //           Expanded(
// //             child: SingleChildScrollView(
// //               padding: const EdgeInsets.all(12),
// //               child: Column(
// //                 children: [
// //                   if (activeTab == 'overview') ...[
// //                     // Personal info card
// //                     Card(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(12),
// //                         child: Column(
// //                           children: [
// //                             Row(
// //                               children: [
// //                                 const Expanded(
// //                                   child: Text(
// //                                     'Personal Information',
// //                                     style: TextStyle(
// //                                       fontSize: 16,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 TextButton.icon(
// //                                   onPressed: _openEditProfileModal,
// //                                   icon: const Icon(Icons.edit, size: 18),
// //                                   label: const Text('Edit'),
// //                                 ),
// //                               ],
// //                             ),
// //                             const SizedBox(height: 8),
// //                             Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text(
// //                                         'Full Name',
// //                                         style: TextStyle(
// //                                           fontSize: 12,
// //                                           color: Colors.grey,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(height: 4),
// //                                       Text(
// //                                         user['name'] ?? '',
// //                                         style: const TextStyle(fontSize: 14),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text(
// //                                         'Email Address',
// //                                         style: TextStyle(
// //                                           fontSize: 12,
// //                                           color: Colors.grey,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(height: 4),
// //                                       Text(
// //                                         user['email'] ?? '',
// //                                         style: const TextStyle(fontSize: 14),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             const SizedBox(height: 12),
// //                             Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text(
// //                                         'Phone Number',
// //                                         style: TextStyle(
// //                                           fontSize: 12,
// //                                           color: Colors.grey,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(height: 4),
// //                                       Text(
// //                                         user['phone'] ?? '',
// //                                         style: const TextStyle(fontSize: 14),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text(
// //                                         'Date of Birth',
// //                                         style: TextStyle(
// //                                           fontSize: 12,
// //                                           color: Colors.grey,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(height: 4),
// //                                       Text(
// //                                         user['dateOfBirth'] ?? '',
// //                                         style: const TextStyle(fontSize: 14),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             const SizedBox(height: 12),
// //                             Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text(
// //                                         'Address',
// //                                         style: TextStyle(
// //                                           fontSize: 12,
// //                                           color: Colors.grey,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(height: 4),
// //                                       Text(
// //                                         user['address'] ?? '',
// //                                         style: const TextStyle(fontSize: 14),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(height: 12),

// //                     // Quick actions
// //                     Card(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(12),
// //                         child: Column(
// //                           children: [
// //                             const Align(
// //                               alignment: Alignment.centerLeft,
// //                               child: Text(
// //                                 'Quick Actions',
// //                                 style: TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 8),
// //                             Wrap(
// //                               spacing: 8,
// //                               runSpacing: 8,
// //                               children: [
// //                                 ElevatedButton.icon(
// //                                   onPressed: () =>
// //                                       _handleQuickAction('transfer'),
// //                                   icon: const Icon(Icons.currency_rupee),
// //                                   label: const Text('Transfer'),
// //                                 ),
// //                                 ElevatedButton.icon(
// //                                   onPressed: () =>
// //                                       _handleQuickAction('auto-debit'),
// //                                   icon: const Icon(Icons.autorenew),
// //                                   label: const Text('Manage Auto Debit'),
// //                                 ),
// //                                 ElevatedButton.icon(
// //                                   onPressed: () =>
// //                                       _handleQuickAction('statement'),
// //                                   icon: const Icon(Icons.download),
// //                                   label: const Text('Download Statement'),
// //                                 ),
// //                                 ElevatedButton.icon(
// //                                   onPressed: () =>
// //                                       _handleQuickAction('investments'),
// //                                   icon: const Icon(Icons.trending_up),
// //                                   label: const Text('View Investments'),
// //                                 ),
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(height: 12),

// //                     // Recent transactions
// //                     Card(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(12),
// //                         child: Column(
// //                           children: [
// //                             Row(
// //                               children: [
// //                                 const Expanded(
// //                                   child: Text(
// //                                     'Recent Transactions',
// //                                     style: TextStyle(
// //                                       fontSize: 16,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 TextButton(
// //                                   onPressed: () => ScaffoldMessenger.of(context)
// //                                       .showSnackBar(
// //                                         const SnackBar(
// //                                           content: Text(
// //                                             'Showing all transactions',
// //                                           ),
// //                                         ),
// //                                       ),
// //                                   child: Row(
// //                                     children: const [
// //                                       Text('View All'),
// //                                       SizedBox(width: 4),
// //                                       Icon(Icons.chevron_right),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             const SizedBox(height: 8),
// //                             Column(
// //                               children: recentTransactions.map((tx) {
// //                                 final bool credit = tx['type'] == 'credit';
// //                                 return ListTile(
// //                                   leading: CircleAvatar(
// //                                     backgroundColor: credit
// //                                         ? Colors.green.shade50
// //                                         : Colors.red.shade50,
// //                                     child: Icon(
// //                                       credit
// //                                           ? Icons.arrow_upward
// //                                           : Icons.arrow_downward,
// //                                       color: credit ? Colors.green : Colors.red,
// //                                     ),
// //                                   ),
// //                                   title: Text(tx['description']),
// //                                   subtitle: Text(
// //                                     '${tx['date']} • ${tx['time']}',
// //                                   ),
// //                                   trailing: Text(
// //                                     '${credit ? '+' : '-'}${_formatCurrency(tx['amount'])}',
// //                                     style: TextStyle(
// //                                       color: credit ? Colors.green : Colors.red,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
// //                                 );
// //                               }).toList(),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ] else if (activeTab == 'account') ...[
// //                     Card(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(12),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             const Text(
// //                               'Account Details',
// //                               style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 12),
// //                             Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text(
// //                                         'Account Number',
// //                                         style: TextStyle(color: Colors.grey),
// //                                       ),
// //                                       const SizedBox(height: 4),
// //                                       Text(
// //                                         user['accountNumber'] ?? '',
// //                                         style: const TextStyle(
// //                                           fontFamily: 'monospace',
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text(
// //                                         'Account Type',
// //                                         style: TextStyle(color: Colors.grey),
// //                                       ),
// //                                       const SizedBox(height: 4),
// //                                       Text(user['accountType'] ?? ''),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             const SizedBox(height: 12),
// //                             Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: Card(
// //                                     color: Colors.blue.shade50,
// //                                     child: Padding(
// //                                       padding: const EdgeInsets.all(12),
// //                                       child: Column(
// //                                         crossAxisAlignment:
// //                                             CrossAxisAlignment.start,
// //                                         children: const [
// //                                           Text(
// //                                             'Banking Services',
// //                                             style: TextStyle(
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                           SizedBox(height: 8),
// //                                           Text('Internet Banking: Active'),
// //                                           Text('Mobile Banking: Active'),
// //                                           Text('SMS Alerts: Enabled'),
// //                                           Text('Email Notifications: Enabled'),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 const SizedBox(width: 8),
// //                                 Expanded(
// //                                   child: Card(
// //                                     child: Padding(
// //                                       padding: const EdgeInsets.all(12),
// //                                       child: Column(
// //                                         crossAxisAlignment:
// //                                             CrossAxisAlignment.start,
// //                                         children: const [
// //                                           Text(
// //                                             'Account Limits',
// //                                             style: TextStyle(
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                           SizedBox(height: 8),
// //                                           Text(
// //                                             'Daily Transfer Limit: ₹1,00,000',
// //                                           ),
// //                                           Text('ATM Withdrawal Limit: ₹50,000'),
// //                                           Text(
// //                                             'Online Purchase Limit: ₹2,00,000',
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ] else if (activeTab == 'auto-debit') ...[
// //                     Card(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(12),
// //                         child: Column(
// //                           children: [
// //                             Row(
// //                               children: [
// //                                 const Expanded(
// //                                   child: Text(
// //                                     'Auto Debit Management',
// //                                     style: TextStyle(
// //                                       fontSize: 16,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 ElevatedButton.icon(
// //                                   onPressed: () =>
// //                                       _handleAutoDebitAction('add', -1),
// //                                   icon: const Icon(Icons.add),
// //                                   label: const Text('Add New'),
// //                                 ),
// //                               ],
// //                             ),
// //                             const SizedBox(height: 12),
// //                             Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: Column(
// //                                     children: [
// //                                       Card(
// //                                         child: ListTile(
// //                                           leading: const Icon(Icons.autorenew),
// //                                           title: const Text(
// //                                             'Active Auto Debits',
// //                                           ),
// //                                           subtitle: Text(
// //                                             '${autoDebits.where((d) => d['status'] == 'active').length}',
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   child: Card(
// //                                     child: ListTile(
// //                                       leading: const Icon(Icons.currency_rupee),
// //                                       title: const Text('Monthly Total'),
// //                                       subtitle: Text(
// //                                         _formatCurrency(
// //                                           autoDebits
// //                                               .where(
// //                                                 (d) =>
// //                                                     d['status'] == 'active' &&
// //                                                     d['frequency'] == 'Monthly',
// //                                               )
// //                                               .fold(
// //                                                 0,
// //                                                 (p, c) => p + c['amount'],
// //                                               ),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   child: Card(
// //                                     child: ListTile(
// //                                       leading: const Icon(Icons.calendar_today),
// //                                       title: const Text('Next Payment'),
// //                                       subtitle: const Text('Feb 01, 2025'),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             const SizedBox(height: 8),
// //                             Column(
// //                               children: autoDebits.map((d) {
// //                                 return Card(
// //                                   child: ListTile(
// //                                     leading: CircleAvatar(
// //                                       child: const Icon(Icons.money),
// //                                     ),
// //                                     title: Text(d['name']),
// //                                     subtitle: Text(
// //                                       '${_formatCurrency(d['amount'])} • ${d['frequency']} • Next: ${d['nextDate']}',
// //                                     ),
// //                                     trailing: Row(
// //                                       mainAxisSize: MainAxisSize.min,
// //                                       children: [
// //                                         Container(
// //                                           padding: const EdgeInsets.symmetric(
// //                                             horizontal: 8,
// //                                             vertical: 4,
// //                                           ),
// //                                           decoration: BoxDecoration(
// //                                             color: _statusColor(
// //                                               d['status'],
// //                                             ).withOpacity(0.12),
// //                                             borderRadius: BorderRadius.circular(
// //                                               12,
// //                                             ),
// //                                           ),
// //                                           child: Row(
// //                                             children: [
// //                                               Icon(
// //                                                 d['status'] == 'active'
// //                                                     ? Icons.check_circle
// //                                                     : d['status'] == 'paused'
// //                                                     ? Icons.pause_circle
// //                                                     : Icons.error,
// //                                                 size: 14,
// //                                                 color: _statusColor(
// //                                                   d['status'],
// //                                                 ),
// //                                               ),
// //                                               const SizedBox(width: 4),
// //                                               Text(
// //                                                 d['status']
// //                                                     .toString()
// //                                                     .toUpperCase(),
// //                                                 style: TextStyle(
// //                                                   color: _statusColor(
// //                                                     d['status'],
// //                                                   ),
// //                                                   fontSize: 12,
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                         const SizedBox(width: 8),
// //                                         IconButton(
// //                                           onPressed: () =>
// //                                               _handleAutoDebitAction(
// //                                                 'edit',
// //                                                 d['id'],
// //                                               ),
// //                                           icon: const Icon(Icons.edit),
// //                                         ),
// //                                         IconButton(
// //                                           onPressed: () =>
// //                                               _handleAutoDebitAction(
// //                                                 'pause',
// //                                                 d['id'],
// //                                               ),
// //                                           icon: Icon(
// //                                             d['status'] == 'active'
// //                                                 ? Icons.pause
// //                                                 : Icons.play_arrow,
// //                                           ),
// //                                         ),
// //                                         IconButton(
// //                                           onPressed: () =>
// //                                               _handleAutoDebitAction(
// //                                                 'delete',
// //                                                 d['id'],
// //                                               ),
// //                                           icon: const Icon(
// //                                             Icons.delete,
// //                                             color: Colors.red,
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 );
// //                               }).toList(),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ] else if (activeTab == 'security') ...[
// //                     Card(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(12),
// //                         child: Column(
// //                           children: [
// //                             const Text(
// //                               'Security Settings',
// //                               style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 12),
// //                             ListTile(
// //                               leading: const Icon(Icons.lock),
// //                               title: const Text('Two-Factor Authentication'),
// //                               subtitle: const Text(
// //                                 'Add an extra layer of security to your account',
// //                               ),
// //                               trailing: Container(
// //                                 padding: const EdgeInsets.symmetric(
// //                                   horizontal: 8,
// //                                   vertical: 4,
// //                                 ),
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.green.withOpacity(0.12),
// //                                   borderRadius: BorderRadius.circular(8),
// //                                 ),
// //                                 child: const Text(
// //                                   'Enabled',
// //                                   style: TextStyle(color: Colors.green),
// //                                 ),
// //                               ),
// //                             ),
// //                             ListTile(
// //                               leading: const Icon(Icons.key),
// //                               title: const Text('Login Password'),
// //                               subtitle: const Text('Last updated 30 days ago'),
// //                               trailing: TextButton(
// //                                 onPressed: _openChangePasswordModal,
// //                                 child: const Text('Change Password'),
// //                               ),
// //                             ),
// //                             ListTile(
// //                               leading: const Icon(Icons.pin),
// //                               title: const Text('Transaction PIN'),
// //                               subtitle: const Text('Last updated 15 days ago'),
// //                               trailing: TextButton(
// //                                 onPressed: _openChangePinModal,
// //                                 child: const Text('Change PIN'),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 12),
// //                             const Align(
// //                               alignment: Alignment.centerLeft,
// //                               child: Text(
// //                                 'Recent Login Activity',
// //                                 style: TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 8),
// //                             Card(
// //                               child: ListTile(
// //                                 leading: const Icon(Icons.web),
// //                                 title: const Text('Web Browser'),
// //                                 subtitle: const Text('Chrome on Windows'),
// //                                 trailing: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.end,
// //                                   children: const [
// //                                     Text(
// //                                       'Current Session',
// //                                       style: TextStyle(fontSize: 12),
// //                                     ),
// //                                     SizedBox(height: 4),
// //                                     Text(
// //                                       'Mumbai, India',
// //                                       style: TextStyle(fontSize: 12),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                             Column(
// //                               children: loginActivity.map((act) {
// //                                 return Card(
// //                                   child: ListTile(
// //                                     leading: CircleAvatar(
// //                                       child: Icon(
// //                                         act['status'] == 'success'
// //                                             ? Icons.check_circle
// //                                             : Icons.error,
// //                                         color: act['status'] == 'success'
// //                                             ? Colors.green
// //                                             : Colors.red,
// //                                       ),
// //                                     ),
// //                                     title: Text(act['device']),
// //                                     subtitle: Text(act['location']),
// //                                     trailing: Column(
// //                                       crossAxisAlignment:
// //                                           CrossAxisAlignment.end,
// //                                       children: [
// //                                         Text(
// //                                           act['status'] == 'success'
// //                                               ? 'Successful'
// //                                               : 'Failed',
// //                                           style: TextStyle(
// //                                             color: act['status'] == 'success'
// //                                                 ? Colors.green
// //                                                 : Colors.red,
// //                                           ),
// //                                         ),
// //                                         const SizedBox(height: 6),
// //                                         Text(
// //                                           act['time'],
// //                                           style: const TextStyle(fontSize: 12),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 );
// //                               }).toList(),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ] else if (activeTab == 'settings') ...[
// //                     Card(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(12),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             const Text(
// //                               'Application & Communication Settings',
// //                               style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 12),
// //                             Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text('Email Transaction Alerts'),
// //                                       const SizedBox(height: 4),
// //                                       const Text(
// //                                         'Receive email notification for all transactions.',
// //                                         style: TextStyle(color: Colors.grey),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Switch(
// //                                   value: true,
// //                                   onChanged: (v) =>
// //                                       ScaffoldMessenger.of(
// //                                         context,
// //                                       ).showSnackBar(
// //                                         const SnackBar(
// //                                           content: Text(
// //                                             'Toggling email-alerts',
// //                                           ),
// //                                         ),
// //                                       ),
// //                                 ),
// //                               ],
// //                             ),
// //                             const Divider(),
// //                             Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text('Promotional Offers'),
// //                                       const SizedBox(height: 4),
// //                                       const Text(
// //                                         'Receive special offers and marketing communication.',
// //                                         style: TextStyle(color: Colors.grey),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Switch(
// //                                   value: false,
// //                                   onChanged: (v) =>
// //                                       ScaffoldMessenger.of(
// //                                         context,
// //                                       ).showSnackBar(
// //                                         const SnackBar(
// //                                           content: Text(
// //                                             'Toggling promotional-offers',
// //                                           ),
// //                                         ),
// //                                       ),
// //                                 ),
// //                               ],
// //                             ),
// //                             const Divider(),
// //                             Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text('Push Notifications'),
// //                                       const SizedBox(height: 4),
// //                                       const Text(
// //                                         'Allow app to send push notifications for banking activities.',
// //                                         style: TextStyle(color: Colors.grey),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Switch(
// //                                   value: true,
// //                                   onChanged: (v) =>
// //                                       ScaffoldMessenger.of(
// //                                         context,
// //                                       ).showSnackBar(
// //                                         const SnackBar(
// //                                           content: Text(
// //                                             'Toggling push-notifications',
// //                                           ),
// //                                         ),
// //                                       ),
// //                                 ),
// //                               ],
// //                             ),
// //                             const SizedBox(height: 12),
// //                             Row(
// //                               children: [
// //                                 const Expanded(
// //                                   child: Text('Set Default Language'),
// //                                 ),
// //                                 DropdownButton<String>(
// //                                   value: 'en',
// //                                   items: const [
// //                                     DropdownMenuItem(
// //                                       value: 'en',
// //                                       child: Text('English (US)'),
// //                                     ),
// //                                     DropdownMenuItem(
// //                                       value: 'hi',
// //                                       child: Text('Hindi (IN)'),
// //                                     ),
// //                                     DropdownMenuItem(
// //                                       value: 'mr',
// //                                       child: Text('Marathi (IN)'),
// //                                     ),
// //                                   ],
// //                                   onChanged: (_) {},
// //                                 ),
// //                               ],
// //                             ),
// //                             const SizedBox(height: 12),
// //                             Row(
// //                               children: [
// //                                 ElevatedButton.icon(
// //                                   onPressed: () => ScaffoldMessenger.of(context)
// //                                       .showSnackBar(
// //                                         const SnackBar(
// //                                           content: Text('Downloading PDF'),
// //                                         ),
// //                                       ),
// //                                   icon: const Icon(Icons.download),
// //                                   label: const Text('Download T&C'),
// //                                 ),
// //                                 const SizedBox(width: 12),
// //                                 ElevatedButton.icon(
// //                                   onPressed: () => ScaffoldMessenger.of(context)
// //                                       .showSnackBar(
// //                                         const SnackBar(
// //                                           content: Text('Deactivate flow'),
// //                                         ),
// //                                       ),
// //                                   icon: const Icon(Icons.close),
// //                                   label: const Text('Deactivate'),
// //                                   style: ElevatedButton.styleFrom(
// //                                     backgroundColor: Colors.red,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: activeTab == 'overview'
// //           ? FloatingActionButton.extended(
// //               onPressed: () => _handleQuickAction('transfer'),
// //               label: const Text('Transfer'),
// //               icon: const Icon(Icons.send),
// //             )
// //           : null,
// //     );
// //   }
// // }
