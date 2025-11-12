import 'package:flutter/material.dart';
import 'package:neobank/pages/Money/dashboard.dart';
import 'signup_screen_styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Form Data
  final _formKey = GlobalKey<FormState>();
  String customerId = '';
  String password = '';

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      debugPrint("Form Submitted:");
      debugPrint("Customer ID: $customerId");
      debugPrint("Password: $password");

      // Demo login check
      if (customerId == 'custm123456' && password == 'User123') {
        // Navigate to the dashboard page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else {
        // Show error for invalid credentials
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid customer ID or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: SignupScreenStyles.containerGradient,
        ),
        child: Column(
          children: [
            // 🔹 Back and Next Buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      // setCurrentStep('welcome');
                      Navigator.pop(context);
                    },
                    child: const Text('← Back'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      // setCurrentStep('updateKYC33');
                      // Example navigation
                      debugPrint('Next pressed');
                    },
                    child: const Text('Next →'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: // 🔹 Card
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: SignupScreenStyles.cardDecoration,
                      padding: SignupScreenStyles.cardPadding,
                      constraints: BoxConstraints(
                        maxWidth: SignupScreenStyles.cardMaxWidth,
                      ),
                      child: Column(
                        children: [
                          // Header
                          Text('Sign In', style: SignupScreenStyles.title),
                          const SizedBox(height: 8),
                          Text('', style: SignupScreenStyles.subtitle),
                          const SizedBox(height: 24),

                          // 🔹 Form
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Customer ID
                                Text(
                                  'Customer ID',
                                  style: SignupScreenStyles.label,
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  decoration:
                                      SignupScreenStyles.inputDecoration(
                                        'Enter your customer ID',
                                      ),
                                  style: SignupScreenStyles.inputText,
                                  validator: (value) => value!.isEmpty
                                      ? 'Enter your customer ID'
                                      : null,
                                  onSaved: (value) => customerId = value!,
                                ),
                                const SizedBox(height: 16),

                                // Password
                                Text(
                                  'Password',
                                  style: SignupScreenStyles.label,
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  obscureText: true,
                                  decoration:
                                      SignupScreenStyles.inputDecoration(
                                        'Enter your password',
                                      ),
                                  style: SignupScreenStyles.inputText,
                                  validator: (value) => value!.isEmpty
                                      ? 'Enter your password'
                                      : null,
                                  onSaved: (value) => password = value!,
                                ),
                                const SizedBox(height: 24),

                                // Sign In Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style:
                                        SignupScreenStyles.continueButtonStyle,
                                    onPressed: handleSubmit,
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Don’t have an account? Sign Up',
                            textAlign: TextAlign.center,
                            style: SignupScreenStyles.termsText,
                          ),

                          const SizedBox(height: 8),

                          TextButton(
                            onPressed: () {
                              // Handle forgot password
                              debugPrint('Forgot Password clicked');
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),

                          const SizedBox(height: 8),

                          const SelectableText(
                            'Use Custm123456 / User123 for Demo Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
