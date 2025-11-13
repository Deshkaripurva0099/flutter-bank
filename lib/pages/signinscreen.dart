import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'signinscreen_style.dart';
import 'dashboard.dart';
import 'signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
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
      if (customerId == 'Custm123456' && password == 'User123') {
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
          gradient: SigninScreenStyles.containerGradient,
        ),
        child: Column(
          children: [
            // 🔹 Back Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white;
                          }
                          return const Color(0xFF900603);
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.black;
                          }
                          return Colors.white;
                        },
                      ),
                    ),
                    onPressed: () {
                      // setCurrentStep('welcome');
                      Navigator.pop(context);
                    },
                    child: const Text('← Back'),
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
                      decoration: SigninScreenStyles.cardDecoration,
                      padding: SigninScreenStyles.cardPadding,
                      constraints: BoxConstraints(
                        maxWidth: SigninScreenStyles.cardMaxWidth,
                      ),
                      child: Column(
                        children: [
                          // Header
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/logo.png'),
                          ),
                          const SizedBox(height: 0),
                          Text('Log In', style: SigninScreenStyles.title),
                          const SizedBox(height: 4),
                          Text('', style: SigninScreenStyles.subtitle),
                          const SizedBox(height: 0),

                          // 🔹 Form
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Customer ID
                                Text(
                                  'Customer ID',
                                  style: SigninScreenStyles.label,
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  decoration:
                                      SigninScreenStyles.inputDecoration(
                                        'Enter your customer ID',
                                      ),
                                  style: SigninScreenStyles.inputText,
                                  validator: (value) => value!.isEmpty
                                      ? 'Enter your customer ID'
                                      : null,
                                  onSaved: (value) => customerId = value!,
                                ),
                                const SizedBox(height: 16),

                                // Password
                                Text(
                                  'Password',
                                  style: SigninScreenStyles.label,
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  obscureText: true,
                                  decoration:
                                      SigninScreenStyles.inputDecoration(
                                        'Enter your password',
                                      ),
                                  style: SigninScreenStyles.inputText,
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
                                        SigninScreenStyles.continueButtonStyle,
                                    onPressed: handleSubmit,
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Don’t have an account? ',
                              style: SigninScreenStyles.termsText,
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: SigninScreenStyles.termsText.copyWith(
                                    color: const Color.fromARGB(
                                      255,
                                      218,
                                      93,
                                      65,
                                    ),
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextButton(
                            onPressed: () {
                              // Handle forgot password
                              debugPrint('Forgot Password clicked');
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color.fromARGB(255, 232, 238, 243),
                              ),
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
