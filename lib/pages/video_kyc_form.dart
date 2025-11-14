import 'package:flutter/material.dart';

class VideoKycForm extends StatefulWidget {
  const VideoKycForm({super.key});

  @override
  State<VideoKycForm> createState() => _VideoKycFormState();
}

class _VideoKycFormState extends State<VideoKycForm> {
  bool _kycStarted = false;
  bool _kycCompleted = false;

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
          width: MediaQuery.of(context).size.width * 0.9,
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
                        _buildStepIndicator(1, "Personal", false),
                        _buildConnector(true), // Active for step 1-2-3-4
                        _buildStepIndicator(2, "Aadhar", false),
                        _buildConnector(true), // Active for step 2-3-4
                        _buildStepIndicator(3, "PAN", false),
                        _buildConnector(true), // Active for step 3-4
                        _buildStepIndicator(4, "Video KYC", true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Video KYC",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Please ensure you are in a well-lit area and have your ID ready.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  if (!_kycStarted)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _kycStarted = true;
                        });
                        // Handle Start Video KYC
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 148, 12, 3),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Start Video KYC"),
                    ),
                  if (_kycStarted && !_kycCompleted) ...[
                    const SizedBox(height: 20),
                    const Text(
                      "Video KYC in progress...",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _kycCompleted = true;
                        });
                        // Handle Complete Video KYC
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 148, 12, 3),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Complete Video KYC"),
                    ),
                  ],
                  if (_kycCompleted) ...[
                    const SizedBox(height: 20),
                    const Text(
                      "Video KYC completed successfully!",
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ],
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
                        onPressed: _kycCompleted
                            ? () {
                                // Handle Next action, e.g., navigate to next form or complete
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
