import 'package:flutter/material.dart';
import 'package:neobank/widgets/layout.dart';

class DomesticTransferPage extends StatefulWidget {
  const DomesticTransferPage({super.key});

  @override
  State<DomesticTransferPage> createState() => _DomesticTransferPageState();
}

class _DomesticTransferPageState extends State<DomesticTransferPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Button style
    ButtonStyle transferButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF900603),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
    );

    return AppLayout(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon Circle
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFF900603),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.send, color: Colors.white, size: 28),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  const Text(
                    "Domestic Transfers",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  const Text(
                    "Choose from NEFT, IMPS, RTGS, or UPI for sending money within India.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Buttons Grid
                  Wrap(
                    spacing: 30,
                    runSpacing: 25,
                    alignment: WrapAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth < 480 ? double.infinity : 140,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/pages/neft");
                          },
                          style: transferButtonStyle,
                          child: const Text("NEFT"),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth < 480 ? double.infinity : 160,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/pages/imps");
                          },
                          style: transferButtonStyle,
                          child: const Text("IMPS"),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth < 480 ? double.infinity : 160,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/pages/rtgs");
                          },
                          style: transferButtonStyle,
                          child: const Text("RTGS"),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth < 480 ? double.infinity : 160,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/pages/send_money_page",
                            );
                          },
                          style: transferButtonStyle,
                          child: const Text("UPI"),
                        ),
                      ),

                      // Back button (commented out in original)
                      // SizedBox(
                      //   width: screenWidth < 480 ? double.infinity : 160,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //     style: transferButtonStyle,
                      //     child: const Text("Back"),
                      //   ),
                      // ),
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
}
