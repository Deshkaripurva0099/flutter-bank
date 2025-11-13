class NotificationSettings {
  bool globalEnabled;
  NotificationChannels channels;
  Map<String, NotificationChannels> categories;
  String frequency;

  NotificationSettings({
    required this.globalEnabled,
    required this.channels,
    required this.categories,
    required this.frequency,
  });

  factory NotificationSettings.defaultSettings() {
    return NotificationSettings(
      globalEnabled: true,
      channels: NotificationChannels(email: true, sms: true, push: true),
      categories: {
        'transaction': NotificationChannels(email: true, sms: true, push: true),
        'security': NotificationChannels(email: true, sms: true, push: true),
        'offers': NotificationChannels(email: false, sms: false, push: false),
        'product': NotificationChannels(email: true, sms: false, push: true),
      },
      frequency: 'immediate',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'globalEnabled': globalEnabled,
      'channels': channels.toJson(),
      'categories': categories.map((key, value) => MapEntry(key, value.toJson())),
      'frequency': frequency,
    };
  }

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      globalEnabled: json['globalEnabled'] ?? true,
      channels: NotificationChannels.fromJson(json['channels'] ?? {}),
      categories: (json['categories'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, NotificationChannels.fromJson(value)),
          ) ??
          {},
      frequency: json['frequency'] ?? 'immediate',
    );
  }
}

class NotificationChannels {
  bool email;
  bool sms;
  bool push;

  NotificationChannels({
    required this.email,
    required this.sms,
    required this.push,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'sms': sms,
      'push': push,
    };
  }

  factory NotificationChannels.fromJson(Map<String, dynamic> json) {
    return NotificationChannels(
      email: json['email'] ?? false,
      sms: json['sms'] ?? false,
      push: json['push'] ?? false,
    );
  }
}

class SecuritySettings {
  bool twoFactorAuth;
  bool smsAlerts;
  bool emailAlerts;
  bool loginNotifications;
  bool biometricLogin;
  bool sessionTimeout;

  SecuritySettings({
    required this.twoFactorAuth,
    required this.smsAlerts,
    required this.emailAlerts,
    required this.loginNotifications,
    required this.biometricLogin,
    required this.sessionTimeout,
  });

  factory SecuritySettings.defaultSettings() {
    return SecuritySettings(
      twoFactorAuth: true,
      smsAlerts: true,
      emailAlerts: true,
      loginNotifications: true,
      biometricLogin: false,
      sessionTimeout: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'twoFactorAuth': twoFactorAuth,
      'smsAlerts': smsAlerts,
      'emailAlerts': emailAlerts,
      'loginNotifications': loginNotifications,
      'biometricLogin': biometricLogin,
      'sessionTimeout': sessionTimeout,
    };
  }

  factory SecuritySettings.fromJson(Map<String, dynamic> json) {
    return SecuritySettings(
      twoFactorAuth: json['twoFactorAuth'] ?? true,
      smsAlerts: json['smsAlerts'] ?? true,
      emailAlerts: json['emailAlerts'] ?? true,
      loginNotifications: json['loginNotifications'] ?? true,
      biometricLogin: json['biometricLogin'] ?? false,
      sessionTimeout: json['sessionTimeout'] ?? true,
    );
  }
}

class ProfileData {
  String firstName;
  String middleName;
  String lastName;
  String dateOfBirth;
  String gender;
  String maritalStatus;
  String nationality;
  String accountNumber;
  String accountType;
  String balance;
  String status;
  String lastLogin;
  String email;
  String phoneNumber;
  String address;
  String emergencyName;
  String emergencyRelation;
  String emergencyPhone;
  String panNumber;
  String aadharNumber;
  String passportNumber;

  ProfileData({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.maritalStatus,
    required this.nationality,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.status,
    required this.lastLogin,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.emergencyName,
    required this.emergencyRelation,
    required this.emergencyPhone,
    required this.panNumber,
    required this.aadharNumber,
    required this.passportNumber,
  });

  factory ProfileData.defaultProfile() {
    return ProfileData(
      firstName: 'Rajesh',
      middleName: '',
      lastName: 'Sharma',
      dateOfBirth: '1990-05-15',
      gender: 'Male',
      maritalStatus: 'Married',
      nationality: 'Indian',
      accountNumber: '123456789012',
      accountType: 'Premium Savings',
      balance: '₹1,25,000',
      status: 'Active',
      lastLogin: 'Today',
      email: 'rajesh.sharma@email.com',
      phoneNumber: '9876543210',
      address: '123, MG Road, Sector 14, Near City Mall, Gurgaon, Haryana - 122001',
      emergencyName: 'Priya Sharma',
      emergencyRelation: 'Spouse',
      emergencyPhone: '9876543212',
      panNumber: 'ABCPK1234F',
      aadharNumber: '123456789012',
      passportNumber: 'A1234567',
    );
  }
}

class ActivityItem {
  final int id;
  final String action;
  final String device;
  final String location;
  final String time;
  final String status;

  ActivityItem({
    required this.id,
    required this.action,
    required this.device,
    required this.location,
    required this.time,
    required this.status,
  });
}

class SessionItem {
  final int id;
  final String device;
  final String browser;
  final String location;
  final String lastActive;
  final bool current;

  SessionItem({
    required this.id,
    required this.device,
    required this.browser,
    required this.location,
    required this.lastActive,
    required this.current,
  });
}