import 'package:flutter/material.dart';
import 'aadhar_verification_form.dart';

class NeobankAccountOpenForm extends StatefulWidget {
  const NeobankAccountOpenForm({super.key});

  @override
  State<NeobankAccountOpenForm> createState() => _NeobankAccountOpenFormState();
}

class _NeobankAccountOpenFormState extends State<NeobankAccountOpenForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isFormValid() {
    return _fullNameController.text.trim().isNotEmpty &&
        _mobileController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/neobank_logo.png', // Assuming a logo asset exists
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width:
              MediaQuery.of(context).size.width * 0.9, // Increased width to 90%
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            // Re-adding SingleChildScrollView to prevent overflow if content exceeds height
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "NeoBank Account Open",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 148, 12, 3),
                    ),
                  ),
                  const Text(
                    "Complete your account setup in easy steps",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStepIndicator(1, "Personal", true),
                        _buildConnector(true), // Active for step 1
                        _buildStepIndicator(2, "Aadhar", false),
                        _buildConnector(false),
                        _buildStepIndicator(3, "PAN", false),
                        _buildConnector(false),
                        _buildStepIndicator(4, "Video KYC", false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Personal Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    "Full Name",
                    "Enter your full name",
                    _fullNameController,
                    onChanged: (value) => setState(() {}),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    "Mobile Number",
                    "Enter your mobile number",
                    _mobileController,
                    onChanged: (value) => setState(() {}),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    "Email",
                    "Enter your email",
                    _emailController,
                    onChanged: (value) => setState(() {}),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Back"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            148,
                            12,
                            3,
                          ),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _isFormValid()
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AadharVerificationForm(),
                                  ),
                                );
                              }
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Next"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            148,
                            12,
                            3,
                          ),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
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
    );
  }

  Widget _buildStepIndicator(int step, String title, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive
              ? const Color.fromARGB(255, 148, 12, 3)
              : Colors.grey.shade300,
          child: Text(
            '$step',
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(bool isActive) {
    return Container(
      width: 20,
      height: 2,
      color: isActive
          ? const Color.fromARGB(255, 148, 12, 3)
          : Colors.grey.shade300,
    );
  }
}
