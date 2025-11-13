import 'package:flutter/material.dart';

class SecurityOption {
  final String title;
  final String description;
  final IconData icon;
  final String buttonText;
  final Color color;

  SecurityOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.buttonText,
    required this.color,
  });
}

class SecurityOptions extends StatelessWidget {
  const SecurityOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = [
      SecurityOption(
        title: 'Enable Two-Factor Authentication',
        description: 'Add an extra layer of security to your account',
        icon: Icons.warning_amber,
        buttonText: 'Enable',
        color: const Color(0xFFFFC107),
      ),
      SecurityOption(
        title: 'Update Password',
        description: 'Your password was last changed 6 months ago',
        icon: Icons.vpn_key,
        buttonText: 'Update',
        color: const Color(0xFF0D6EFD),
      ),
      SecurityOption(
        title: 'Enable Biometric Login',
        description: 'Use fingerprint or face recognition for quick access',
        icon: Icons.fingerprint,
        buttonText: 'Setup',
        color: const Color(0xFF198754),
      ),
    ];

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
                'Security Recommendations',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isMobile ? 3 : 5),
              Text(
                'Improve your account security with these suggestions',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: isMobile ? 12 : 15),
              ...options.map((option) => _buildSecurityCard(context, option, isMobile)).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSecurityCard(BuildContext context, SecurityOption option, bool isMobile) {
    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 10 : 12),
      padding: EdgeInsets.all(isMobile ? 12 : 15),
      decoration: BoxDecoration(
        color: option.color.withOpacity(0.05),
        border: Border(
          left: BorderSide(
            color: option.color,
            width: 5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      option.icon,
                      size: 24,
                      color: option.color,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            option.description,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: _buildButton(context, option, isMobile),
                ),
              ],
            )
          : Row(
              children: [
                Icon(
                  option.icon,
                  size: 30,
                  color: option.color,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        option.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                _buildButton(context, option, isMobile),
              ],
            ),
    );
  }

  Widget _buildButton(BuildContext context, SecurityOption option, bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${option.buttonText} clicked'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 12,
            vertical: isMobile ? 8 : 6,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: option.color),
            color: Colors.transparent,
          ),
          child: Text(
            option.buttonText,
            style: TextStyle(
              color: option.color,
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 12 : 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}