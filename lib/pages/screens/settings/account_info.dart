import 'package:flutter/material.dart';

class AccountInfoItem {
  final String label;
  final String value;
  final String status;

  AccountInfoItem({
    required this.label,
    required this.value,
    required this.status,
  });
}

class AccountInfo extends StatelessWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountInfo = [
      AccountInfoItem(
        label: 'Account Status',
        value: 'Active',
        status: 'success',
      ),
      AccountInfoItem(
        label: 'Last Login',
        value: 'Today, 10:30 AM',
        status: 'muted',
      ),
      AccountInfoItem(
        label: 'KYC Status',
        value: 'Verified',
        status: 'success',
      ),
      AccountInfoItem(
        label: 'Mobile Verified',
        value: 'Yes',
        status: 'success',
      ),
      AccountInfoItem(
        label: 'Two-Factor Auth',
        value: 'Disabled',
        status: 'danger',
      ),
      AccountInfoItem(
        label: 'Email Verified',
        value: 'Yes',
        status: 'success',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

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
                'Account Information',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isMobile ? 4 : 6),
              Text(
                'Overview of your account settings and status',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: isMobile ? 16 : 20),

              // Mobile: Simple list, Desktop: Grid
              if (isMobile)
                Column(
                  children: accountInfo
                      .map((item) => _buildInfoCard(item, isMobile))
                      .toList(),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.8,
                  ),
                  itemCount: accountInfo.length,
                  itemBuilder: (context, index) {
                    final item = accountInfo[index];
                    return _buildInfoCard(item, isMobile);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(AccountInfoItem item, bool isMobile) {
    Color valueColor;
    IconData? statusIcon;

    switch (item.status) {
      case 'success':
        valueColor = const Color(0xFF198754);
        statusIcon = Icons.check_circle;
        break;
      case 'danger':
        valueColor = const Color(0xFFDC3545);
        statusIcon = Icons.cancel;
        break;
      default:
        valueColor = const Color(0xFF6C757D);
        statusIcon = Icons.info;
    }

    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 10 : 0),
      padding: EdgeInsets.all(isMobile ? 14 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isMobile
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.label,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF555555),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            statusIcon,
                            size: 16,
                            color: valueColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.value,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: valueColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: 14,
                      color: valueColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.value,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: valueColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
