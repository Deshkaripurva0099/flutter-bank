import 'package:flutter/material.dart';

/// MenuItemModel represents a navigation menu item
/// Can be a simple item or have dropdown sub-items
class MenuItemModel {
  /// Display name of the menu item
  final String name;
  
  /// Icon to display for the menu item
  final IconData icon;
  
  /// Navigation path/route for the menu item
  final String? path;
  
  /// List of sub-menu items (for dropdown menus)
  final List<MenuItemModel>? dropdown;
  
  /// Optional badge text to display (e.g., "New", "3")
  final String? badge;
  
  /// Optional badge color
  final Color? badgeColor;

  MenuItemModel({
    required this.name,
    required this.icon,
    this.path,
    this.dropdown,
    this.badge,
    this.badgeColor,
  });

  /// Check if this menu item has a dropdown
  bool get hasDropdown => dropdown != null && dropdown!.isNotEmpty;
  
  /// Check if this menu item has a badge
  bool get hasBadge => badge != null && badge!.isNotEmpty;

  /// Create a copy of this menu item with updated fields
  MenuItemModel copyWith({
    String? name,
    IconData? icon,
    String? path,
    List<MenuItemModel>? dropdown,
    String? badge,
    Color? badgeColor,
  }) {
    return MenuItemModel(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      path: path ?? this.path,
      dropdown: dropdown ?? this.dropdown,
      badge: badge ?? this.badge,
      badgeColor: badgeColor ?? this.badgeColor,
    );
  }

  /// Convert to JSON (useful for storing in preferences)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon.codePoint,
      'path': path,
      'dropdown': dropdown?.map((item) => item.toJson()).toList(),
      'badge': badge,
      'badgeColor': badgeColor?.value,
    };
  }

  /// Create from JSON
  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      name: json['name'] as String,
      icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
      path: json['path'] as String?,
      dropdown: json['dropdown'] != null
          ? (json['dropdown'] as List)
              .map((item) => MenuItemModel.fromJson(item))
              .toList()
          : null,
      badge: json['badge'] as String?,
      badgeColor: json['badgeColor'] != null
          ? Color(json['badgeColor'] as int)
          : null,
    );
  }

  @override
  String toString() {
    return 'MenuItemModel(name: $name, path: $path, hasDropdown: $hasDropdown)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MenuItemModel &&
      other.name == name &&
      other.icon == icon &&
      other.path == path;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      icon.hashCode ^
      path.hashCode;
  }
}

/// Helper class to build common menu structures
class MenuBuilder {
  /// Build client menu items
  static List<MenuItemModel> buildClientMenu() {
    return [
      MenuItemModel(
        name: 'Dashboard',
        icon: Icons.dashboard_outlined,
        path: '/client/dashboard',
      ),
      MenuItemModel(
        name: 'My Account',
        icon: Icons.account_balance_outlined,
        path: '/client/account',
      ),
      MenuItemModel(
        name: 'Wallet',
        icon: Icons.account_balance_wallet_outlined,
        path: '/client/wallet',
      ),
      MenuItemModel(
        name: 'Transactions',
        icon: Icons.receipt_long_outlined,
        path: '/client/transactions',
      ),
      MenuItemModel(
        name: 'Money Transfer',
        icon: Icons.send_outlined,
        path: '/client/transfer',
      ),
      MenuItemModel(
        name: 'Bill Payments',
        icon: Icons.receipt_outlined,
        path: '/client/bills',
      ),
      MenuItemModel(
        name: 'Loans',
        icon: Icons.attach_money_outlined,
        path: '/client/loans',
        badge: 'New',
        badgeColor: const Color(0xFF900603),
      ),
      MenuItemModel(
        name: 'Cards',
        icon: Icons.credit_card_outlined,
        path: '/client/cards',
      ),
      MenuItemModel(
        name: 'Investments',
        icon: Icons.trending_up_outlined,
        path: '/client/investments',
      ),
      MenuItemModel(
        name: 'Insurance',
        icon: Icons.shield_outlined,
        path: '/client/insurance',
      ),
      MenuItemModel(
        name: 'Support',
        icon: Icons.support_agent_outlined,
        path: '/client/support',
      ),
      MenuItemModel(
        name: 'Settings',
        icon: Icons.settings_outlined,
        path: '/client/settings',
      ),
    ];
  }

  /// Build admin menu items
  static List<MenuItemModel> buildAdminMenu() {
    return [
      MenuItemModel(
        name: 'Dashboard',
        icon: Icons.dashboard_outlined,
        path: '/admin/',
      ),
      MenuItemModel(
        name: 'Users',
        icon: Icons.people_outline,
        path: '/admin/users',
      ),
      MenuItemModel(
        name: 'KYC',
        icon: Icons.description_outlined,
        path: '/admin/kyc',
      ),
      MenuItemModel(
        name: 'Accounts & Wallets',
        icon: Icons.account_balance_wallet_outlined,
        path: '/admin/accountsdashboard',
      ),
      MenuItemModel(
        name: 'Transactions',
        icon: Icons.credit_card_outlined,
        path: '/admin/transactions',
      ),
      MenuItemModel(
        name: 'Money Transfer Request',
        icon: Icons.send_outlined,
        path: '/admin/moneyrequest',
      ),
      MenuItemModel(
        name: 'Deposit Management',
        icon: Icons.account_balance_outlined,
        path: '/admin/depositmanagement',
      ),
      MenuItemModel(
        name: 'Investment Products',
        icon: Icons.bar_chart_outlined,
        path: '/admin/investment_products',
      ),
      MenuItemModel(
        name: 'Complaints & Support',
        icon: Icons.support_agent_outlined,
        path: '/admin/complaints&support',
      ),
      MenuItemModel(
        name: 'Reports & Analytics',
        icon: Icons.analytics_outlined,
        path: '/admin/reports',
      ),
      MenuItemModel(
        name: 'Loans',
        icon: Icons.attach_money_outlined,
        path: '/admin/loans',
      ),
      MenuItemModel(
        name: 'Cards',
        icon: Icons.credit_card,
        path: '/admin/cards',
      ),
      MenuItemModel(
        name: 'Setting',
        icon: Icons.settings,
        path: '/admin/settings',
      ),
    ];
  }

  /// Build loan submenu items
  static List<MenuItemModel> buildLoanSubmenu() {
    return [
      MenuItemModel(
        name: 'Apply for Loan',
        icon: Icons.add_circle_outline,
        path: '/client/loan-products',
      ),
      MenuItemModel(
        name: 'My Loans',
        icon: Icons.account_balance_outlined,
        path: '/client/loans',
      ),
      MenuItemModel(
        name: 'Loan Statement',
        icon: Icons.receipt_long_outlined,
        path: '/client/loan-statement',
      ),
      MenuItemModel(
        name: 'EMI Calculator',
        icon: Icons.calculate_outlined,
        path: '/client/loan-calculator',
      ),
    ];
  }
}