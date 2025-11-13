import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../models/settings_models.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  String activeTab = 'personal';
  Map<String, bool> editMode = {
    'personal': false,
    'contact': false,
  };
  Map<String, bool> showSensitive = {
    'account': false,
    'pan': false,
    'aadhar': false,
  };

  bool copySuccess = false;
  String? profileImagePath;
  Map<String, String> uploadedDocs = {};
  String? viewDoc;

  late ProfileData profileData;

  @override
  void initState() {
    super.initState();
    profileData = ProfileData.defaultProfile();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        profileImagePath = image.path;
      });
    }
  }

  String maskData(String value, String type) {
    if (showSensitive[type] == true) return value;
    if (type == 'pan') {
      return '${value.substring(0, 2)}******${value.substring(value.length - 1)}';
    }
    if (type == 'aadhar' || type == 'account') {
      return '********${value.substring(value.length - 4)}';
    }
    return value;
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    setState(() => copySuccess = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => copySuccess = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(isMobile),
                    _buildTabs(isMobile),
                    Padding(
                      padding: EdgeInsets.all(isMobile ? 12 : 16),
                      child: _buildTabContent(isMobile),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              if (copySuccess)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Text(
                      '✓ Copied to clipboard!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 16 : 30,
        isMobile ? 12 : 30,
        isMobile ? 16 : 30,
        isMobile ? 12 : 30,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF900603),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Image with Camera Icon
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: isMobile ? 32 : 50,
                  backgroundImage: profileImagePath != null
                      ? FileImage(File(profileImagePath!))
                      : const NetworkImage(
                          'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg',
                        ) as ImageProvider,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: isMobile ? 14 : 18,
                      color: const Color(0xFF900603),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 8 : 16),

          // User Info Below Profile Picture
          Column(
            children: [
              Text(
                '${profileData.firstName} ${profileData.lastName}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 16 : 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                profileData.accountType,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: isMobile ? 12 : 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                alignment: WrapAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.lightGreen),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.verified,
                          color: Colors.lightGreen,
                          size: 12,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Verified',
                          style: TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 12,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Premium',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Back Button
          SizedBox(height: isMobile ? 10 : 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, size: isMobile ? 16 : 18),
              label: const Text('Back'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 2),
                padding: EdgeInsets.symmetric(vertical: isMobile ? 10 : 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(fontSize: isMobile ? 13 : 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(bool isMobile) {
    final tabs = [
      {'key': 'personal', 'label': 'Personal', 'icon': Icons.person_outline},
      {'key': 'contact', 'label': 'Contact', 'icon': Icons.phone_outlined},
      {
        'key': 'documents',
        'label': 'Documents',
        'icon': Icons.description_outlined
      },
      {
        'key': 'financial',
        'label': 'Financial',
        'icon': Icons.account_balance_outlined
      },
    ];

    return Container(
      margin: EdgeInsets.all(isMobile ? 12 : 16),
      child: isMobile
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    tabs.map((tab) => _buildTabButton(tab, isMobile)).toList(),
              ),
            )
          : Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  tabs.map((tab) => _buildTabButton(tab, isMobile)).toList(),
            ),
    );
  }

  Widget _buildTabButton(Map<String, dynamic> tab, bool isMobile) {
    final isActive = activeTab == tab['key'];

    return GestureDetector(
      onTap: () => setState(() => activeTab = tab['key'] as String),
      child: Container(
        margin: EdgeInsets.only(right: isMobile ? 8 : 0),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 20,
          vertical: isMobile ? 12 : 14,
        ),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF900603) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? const Color(0xFF900603) : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: const Color(0xFF900603).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              tab['icon'] as IconData,
              size: isMobile ? 18 : 20,
              color: isActive ? Colors.white : const Color(0xFF900603),
            ),
            const SizedBox(width: 8),
            Text(
              tab['label'] as String,
              style: TextStyle(
                fontSize: isMobile ? 14 : 15,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? Colors.white : const Color(0xFF900603),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(bool isMobile) {
    switch (activeTab) {
      case 'personal':
        return _buildPersonalInfo(isMobile);
      case 'contact':
        return _buildContactDetails(isMobile);
      case 'documents':
        return _buildDocuments(isMobile);
      case 'financial':
        return _buildFinancialInfo(isMobile);
      default:
        return const SizedBox();
    }
  }

  Widget _buildPersonalInfo(bool isMobile) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Personal Info',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF900603),
                ),
              ),
              if (!editMode['personal']!)
                IconButton(
                  onPressed: () => setState(() => editMode['personal'] = true),
                  icon: const Icon(Icons.edit, color: Color(0xFF900603)),
                  tooltip: 'Edit',
                ),
            ],
          ),
          const Divider(height: 24),
          if (!editMode['personal']!) ...[
            _buildInfoRow(
                'Name',
                '${profileData.firstName} ${profileData.middleName} ${profileData.lastName}',
                isMobile),
            _buildInfoRow('Date of Birth', profileData.dateOfBirth, isMobile),
            _buildInfoRow('Gender', profileData.gender, isMobile),
            _buildInfoRow(
                'Marital Status', profileData.maritalStatus, isMobile),
            _buildInfoRow('Nationality', profileData.nationality, isMobile),
          ] else
            _buildPersonalEditForm(isMobile),
        ],
      ),
    );
  }

  Widget _buildPersonalEditForm(bool isMobile) {
    return Column(
      children: [
        _buildTextField('First Name', profileData.firstName, isMobile),
        const SizedBox(height: 12),
        _buildTextField('Middle Name', profileData.middleName, isMobile),
        const SizedBox(height: 12),
        _buildTextField('Last Name', profileData.lastName, isMobile),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: profileData.dateOfBirth,
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          style: TextStyle(fontSize: isMobile ? 14 : 15),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: profileData.gender,
          decoration: InputDecoration(
            labelText: 'Gender',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          items: ['Male', 'Female', 'Other'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (val) {},
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: profileData.maritalStatus,
          decoration: InputDecoration(
            labelText: 'Marital Status',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          items: ['Single', 'Married', 'Other'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (val) {},
        ),
        const SizedBox(height: 12),
        _buildTextField('Nationality', profileData.nationality, isMobile),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => editMode['personal'] = false),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey,
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => setState(() => editMode['personal'] = false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF900603),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactDetails(bool isMobile) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contact Details',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF900603),
                ),
              ),
              if (!editMode['contact']!)
                IconButton(
                  onPressed: () => setState(() => editMode['contact'] = true),
                  icon: const Icon(Icons.edit, color: Color(0xFF900603)),
                  tooltip: 'Edit',
                ),
            ],
          ),
          const Divider(height: 24),
          if (!editMode['contact']!) ...[
            _buildInfoRow('Email', profileData.email, isMobile),
            _buildInfoRow('Phone', profileData.phoneNumber, isMobile),
            _buildInfoRow('Address', profileData.address, isMobile),
          ] else
            _buildContactEditForm(isMobile),
        ],
      ),
    );
  }

  Widget _buildContactEditForm(bool isMobile) {
    return Column(
      children: [
        _buildTextField('Email', profileData.email, isMobile),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: profileData.address,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Address',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          style: TextStyle(fontSize: isMobile ? 14 : 15),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => editMode['contact'] = false),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey,
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => setState(() => editMode['contact'] = false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF900603),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDocuments(bool isMobile) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Identity Documents',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF900603),
            ),
          ),
          const Divider(height: 24),
          _buildDocCard('PAN Number', profileData.panNumber, 'pan', isMobile),
          const SizedBox(height: 12),
          _buildDocCard(
              'Aadhar Number', profileData.aadharNumber, 'aadhar', isMobile),
          const SizedBox(height: 12),
          _buildDocCard('Passport Number', profileData.passportNumber,
              'passport', isMobile),
        ],
      ),
    );
  }

  Widget _buildDocCard(String label, String value, String type, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 13 : 14,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  type == 'passport' ? value : maskData(value, type),
                  style: TextStyle(
                    fontSize: isMobile ? 15 : 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              if (type != 'passport')
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        showSensitive[type]!
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                        color: const Color(0xFF900603),
                      ),
                      onPressed: () {
                        setState(() {
                          showSensitive[type] = !showSensitive[type]!;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(
                        Icons.copy,
                        size: 20,
                        color: Color(0xFF900603),
                      ),
                      onPressed: () => copyToClipboard(value),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialInfo(bool isMobile) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Financial Info',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF900603),
            ),
          ),
          const Divider(height: 24),
          _buildInfoRow('Account Number',
              maskData(profileData.accountNumber, 'account'), isMobile),
          _buildInfoRow('Account Type', profileData.accountType, isMobile),
          _buildInfoRow('Balance', profileData.balance, isMobile),
          _buildInfoRow('Status', profileData.status, isMobile),
          _buildInfoRow('Last Login', profileData.lastLogin, isMobile),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: isMobile ? 110 : 140,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? 13 : 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: isMobile ? 14 : 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue, bool isMobile) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      style: TextStyle(fontSize: isMobile ? 14 : 15),
    );
  }
}
