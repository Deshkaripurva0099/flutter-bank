import 'package:flutter/material.dart';
import 'account_type_screen_style.dart'; // ✅ Import your style file
import 'customer_id_screen.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  // Step management
  String currentStep = 'account-type';
  Map<String, dynamic> userData = {};

  void setCurrentStep(String step) {
    setState(() {
      currentStep = step;
    });
    debugPrint("Navigating to step: $step");
  }

  void updateUserData(Map<String, dynamic> data) {
    setState(() {
      userData.addAll(data);
    });
    debugPrint("User Data Updated: $userData");
  }

  // Account Types
  final List<Map<String, dynamic>> accountTypes = [
    {
      'type': 'savings',
      'icon': '💰',
      'title': 'Savings Account',
      'description': 'For personal banking and daily transactions',
      'features': ['4% interest p.a.', 'Free debit card', 'No minimum balance'],
    },
    {
      'type': 'current',
      'icon': '💼',
      'title': 'Current Account',
      'description': 'For business and professional needs',
      'features': [
        'Unlimited transactions',
        'Overdraft facility',
        'Business tools',
      ],
    },
    {
      'type': 'business',
      'icon': '🏢',
      'title': 'Business Account',
      'description': 'For enterprises and large businesses',
      'features': ['Multi-user access', 'API integration', 'Priority support'],
    },
  ];

  void handleSelect(String type) {
    updateUserData({'accountType': type});
    // Navigate to CustomerIDScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CustomerIDScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AccountTypeStyle.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: AccountTypeStyle.pagePadding,
            child: Column(
              children: [
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Text(
                      '←',
                      style: AccountTypeStyle.backIconStyle,
                    ),
                    label: const Text(
                      'Back',
                      style: AccountTypeStyle.backTextStyle,
                    ),
                  ),
                ), // ✅ Fixed: Added missing parenthesis

                const SizedBox(height: 10),

                // Card Container
                Expanded(
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 800),
                    decoration: AccountTypeStyle.cardBoxDecoration,
                    padding: AccountTypeStyle.cardPadding,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Header
                          const Text(
                            'Choose Account Type',
                            style: AccountTypeStyle.headerTitleStyle,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Select the account that best fits your needs',
                            style: AccountTypeStyle.headerSubtitleStyle,
                          ),

                          const SizedBox(height: 20),

                          // Progress Bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              4,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: 30,
                                height: 6,
                                decoration:
                                    AccountTypeStyle.progressBarDecoration,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Account List
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: accountTypes.map((account) {
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => handleSelect(account['type']),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 10,
                                    ),
                                    padding:
                                        AccountTypeStyle.accountCardPadding,
                                    decoration:
                                        AccountTypeStyle.accountCardDecoration,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          account['icon'],
                                          style: const TextStyle(fontSize: 32),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          account['title'],
                                          style: AccountTypeStyle
                                              .accountTitleStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          account['description'],
                                          style:
                                              AccountTypeStyle.accountDescStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),

                                        // Features List
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: (account['features'] as List<dynamic>)
                                              .map(
                                                (feature) => Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                      ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 6,
                                                        height: 6,
                                                        margin:
                                                            const EdgeInsets.only(
                                                              right: 4,
                                                            ),
                                                        decoration:
                                                            AccountTypeStyle
                                                                .dotDecoration,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          feature,
                                                          style: AccountTypeStyle
                                                              .featureTextStyle,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),

                                        const SizedBox(height: 10),

                                        // Select Row
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'Select',
                                              style: AccountTypeStyle
                                                  .selectTextStyle,
                                            ),
                                            Text(
                                              '→',
                                              style: AccountTypeStyle
                                                  .selectArrowStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 16),

                          // Footer Note
                          const Text(
                            'You can upgrade or change your account type anytime from settings',
                            textAlign: TextAlign.center,
                            style: AccountTypeStyle.footerNoteStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
