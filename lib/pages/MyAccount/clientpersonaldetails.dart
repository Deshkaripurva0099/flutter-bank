import 'package:flutter/material.dart';
import '../../../widgets/layout.dart'; // 🔹 correct relative import path

class PersonalDetailsPage extends StatefulWidget {
  final String accountType;
  const PersonalDetailsPage({super.key, this.accountType = ''});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final Color primaryRed = const Color(0xFF900603);

  bool get isFormValid =>
      fullNameController.text.isNotEmpty &&
      mobileController.text.isNotEmpty &&
      emailController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // ✅ Wrap Scaffold inside AppLayout to show Topbar + Drawer
    return AppLayout(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth > 800 ? 550 : screenWidth * 0.9,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.account_balance, color: primaryRed, size: 60),
                      const SizedBox(height: 16),
                      const Text(
                        'NeoBank Account Open',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF900603),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Complete your account setup in easy steps',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      _buildProgressIndicator(currentStep: 1),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Personal Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[900],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInputField(
                        label: "Full Name",
                        hint: "Enter your full name",
                        controller: fullNameController,
                        icon: Icons.person_outline,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 18),
                      _buildInputField(
                        label: "Mobile Number",
                        hint: "Enter your mobile number",
                        keyboardType: TextInputType.phone,
                        controller: mobileController,
                        icon: Icons.phone_android_outlined,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 18),
                      _buildInputField(
                        label: "Email",
                        hint: "Enter your email",
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        icon: Icons.email_outlined,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                            label: const Text("Back"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: primaryRed,
                              side: BorderSide(color: primaryRed, width: 1.5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: isFormValid
                                ? () {
                                    Navigator.pushNamed(
                                      context,
                                      '/aadharVerification',
                                      arguments: {
                                        'fullName': fullNameController.text,
                                        'mobile': mobileController.text,
                                        'email': emailController.text,
                                      },
                                    );
                                  }
                                : null,
                            icon: const Icon(Icons.arrow_forward_ios, size: 18),
                            label: const Text("Next"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isFormValid
                                  ? primaryRed
                                  : Colors.grey.shade300,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator({int currentStep = 1}) {
    Color activeColor = primaryRed;
    Color inactiveColor = Colors.grey.shade300;

    Widget buildStep(int step, String label) {
      bool isCompleted = step < currentStep;
      bool isActive = step == currentStep;
      Color circleColor = isActive || isCompleted ? activeColor : inactiveColor;
      Color textColor = isActive || isCompleted ? activeColor : Colors.grey;

      return Column(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: circleColor,
            child: Text(
              "$step",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: textColor,
            ),
          ),
        ],
      );
    }

    Widget buildLine(bool isActive) {
      return Expanded(
        child: Container(
          height: 2,
          color: isActive ? activeColor : inactiveColor,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildStep(1, "Personal"),
        buildLine(currentStep > 1),
        buildStep(2, "Aadhar"),
        buildLine(currentStep > 2),
        buildStep(3, "PAN"),
        buildLine(currentStep > 3),
        buildStep(4, "Video KYC"),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    IconData? icon,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            )),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon:
                icon != null ? Icon(icon, color: Colors.grey[600]) : null,
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF900603), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
