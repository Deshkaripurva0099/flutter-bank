import 'package:flutter/material.dart';
import 'package:neobank/widgets/layout.dart';
import 'package:neobank/widgets/topbar.dart';

class ImpsFormPage extends StatefulWidget {
  const ImpsFormPage({super.key});

  @override
  State<ImpsFormPage> createState() => _ImpsFormPageState();
}

class _ImpsFormPageState extends State<ImpsFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _beneficiaryName = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _ifsc = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _mmid = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _remarks = TextEditingController();

  final RegExp _ifscRegex = RegExp(r'^[A-Za-z]{4}0[A-Za-z0-9]{6}$');
  final RegExp _mobileRegex = RegExp(r'^[6-9]\d{9}$');
  final RegExp _mmidRegex = RegExp(r'^\d{7}$');

  bool _submitted = false;

  void _submitForm() {
    final hasAccountRoute =
        _accountNumber.text.trim().isNotEmpty && _ifsc.text.trim().isNotEmpty;
    final hasMobileRoute =
        _mobile.text.trim().isNotEmpty && _mmid.text.trim().isNotEmpty;

    if (!hasAccountRoute && !hasMobileRoute) {
      _showMessage(
        "Please fill either Account + IFSC or Mobile + MMID fields.",
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() => _submitted = true);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("IMPS Transfer Initiated"),
          content: Text(
            "Beneficiary: ${_beneficiaryName.text}\n"
            "Amount: ₹${_amount.text}\n"
            "Mode: ${hasAccountRoute ? "Account + IFSC" : "Mobile + MMID"}",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 30),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "IMPS Transfer Form",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF900603),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Beneficiary Name
                  TextFormField(
                    controller: _beneficiaryName,
                    decoration: const InputDecoration(
                      labelText: "Beneficiary Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter beneficiary name"
                        : null,
                  ),
                  const SizedBox(height: 18),

                  // Account Number
                  TextFormField(
                    controller: _accountNumber,
                    decoration: const InputDecoration(
                      labelText: "Account Number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15),

                  // IFSC
                  TextFormField(
                    controller: _ifsc,
                    decoration: const InputDecoration(
                      labelText: "IFSC Code",
                      hintText: "e.g. HDFC0001234",
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.characters,
                    maxLength: 11,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          !_ifscRegex.hasMatch(value.toUpperCase())) {
                        return "Invalid IFSC format";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),

                  const Center(
                    child: Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Mobile
                  TextFormField(
                    controller: _mobile,
                    decoration: const InputDecoration(
                      labelText: "Mobile Number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          !_mobileRegex.hasMatch(value)) {
                        return "Invalid mobile number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  // MMID
                  TextFormField(
                    controller: _mmid,
                    decoration: const InputDecoration(
                      labelText: "MMID (7-digit)",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          !_mmidRegex.hasMatch(value)) {
                        return "Invalid MMID";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // Amount
                  TextFormField(
                    controller: _amount,
                    decoration: const InputDecoration(
                      labelText: "Amount (₹)",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter amount";
                      } else if (double.tryParse(value) == null) {
                        return "Invalid amount";
                      } else if (double.parse(value) > 200000) {
                        return "IMPS limit is ₹2,00,000";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // Remarks
                  TextFormField(
                    controller: _remarks,
                    decoration: const InputDecoration(
                      labelText: "Remarks (optional)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF900603),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Submit IMPS",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Expanded(
                      //   child: ElevatedButton(
                      //     onPressed: () => Navigator.pop(context),
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.grey.shade400,
                      //       foregroundColor: Colors.black,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(30),
                      //       ),
                      //       padding: const EdgeInsets.symmetric(vertical: 14),
                      //     ),
                      //     child: const Text(
                      //       "Back",
                      //       style: TextStyle(fontSize: 16),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),

                  if (_submitted) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFD4EDDA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "✅ IMPS Transfer of ₹${_amount.text} to ${_beneficiaryName.text} initiated successfully!",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF155724),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:neobank/widgets/topbar.dart';

// class ImpsFormPage extends StatefulWidget {
//   const ImpsFormPage({super.key});

//   @override
//   State<ImpsFormPage> createState() => _ImpsFormPageState();
// }

// class _ImpsFormPageState extends State<ImpsFormPage> {
//   final _formKey = GlobalKey<FormState>();

//   String name = "";
//   String accountNumber = "";
//   String ifsc = "";
//   String mobileNumber = "";
//   String mmid = "";
//   String amount = "";
//   String remark = "";
//   bool submitted = false;

//   void handleSubmit() {
//     if ((accountNumber.isEmpty || ifsc.isEmpty) &&
//         (mobileNumber.isEmpty || mmid.isEmpty)) {
//       _showAlert(
//         "Please provide either Account Number + IFSC OR Mobile Number + MMID",
//       );
//       return;
//     }
//     if (amount.isEmpty) {
//       _showAlert("Please enter an amount");
//       return;
//     }
//     if (double.tryParse(amount)! > 200000) {
//       _showAlert(
//         "IMPS daily transfer limit is ₹2,00,000. Please enter a smaller amount.",
//       );
//       return;
//     }
//     if (name.isEmpty) {
//       _showAlert("Please enter the beneficiary name");
//       return;
//     }

//     setState(() => submitted = true);
//   }

//   void _showAlert(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(msg),
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.redAccent,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: NavbarTop(),
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         title: const Text(
//           "IMPS Transfer",
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//             color: Color(0xFF950606),
//           ),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false, // ❌ No back arrow
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Container(
//             constraints: const BoxConstraints(maxWidth: 600),
//             padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.15),
//                   blurRadius: 20,
//                   offset: const Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Beneficiary Name
//                   _buildInputField(
//                     label: "Beneficiary Name",
//                     hint: "Enter beneficiary name",
//                     onChanged: (v) => name = v,
//                   ),

//                   // Account + IFSC
//                   _buildInputField(
//                     label: "Account Number",
//                     hint: "Enter account number",
//                     onChanged: (v) => accountNumber = v,
//                   ),
//                   _buildInputField(
//                     label: "IFSC Code",
//                     hint: "Enter IFSC code",
//                     onChanged: (v) => ifsc = v,
//                   ),

//                   const SizedBox(height: 6),
//                   const Center(
//                     child: Text(
//                       "OR",
//                       style: TextStyle(
//                         color: Color(0xFF6C757D),
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 6),

//                   // Mobile + MMID
//                   _buildInputField(
//                     label: "Mobile Number",
//                     hint: "Enter mobile number",
//                     onChanged: (v) => mobileNumber = v,
//                   ),
//                   _buildInputField(
//                     label: "MMID",
//                     hint: "Enter MMID",
//                     onChanged: (v) => mmid = v,
//                   ),

//                   // Amount
//                   _buildInputField(
//                     label: "Amount",
//                     hint: "Enter amount (max ₹2,00,000)",
//                     keyboardType: TextInputType.number,
//                     onChanged: (v) => amount = v,
//                   ),

//                   // Remark
//                   _buildInputField(
//                     label: "Remark",
//                     hint: "Enter remark",
//                     onChanged: (v) => remark = v,
//                   ),

//                   const SizedBox(height: 16),

//                   // Buttons
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: handleSubmit,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF950606),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                           ),
//                           child: const Text(
//                             "Submit IMPS",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () => Navigator.pop(context),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF950606),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                           ),
//                           child: const Text(
//                             "Back",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   if (submitted) ...[
//                     const SizedBox(height: 16),
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFD4EDDA),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         "✅ IMPS Transfer of ₹$amount to $name has been initiated successfully!",
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Color(0xFF155724),
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField({
//     required String label,
//     required String hint,
//     TextInputType keyboardType = TextInputType.text,
//     required Function(String) onChanged,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 15,
//               color: Color(0xFF1A202C),
//             ),
//           ),
//           const SizedBox(height: 4),
//           TextField(
//             keyboardType: keyboardType,
//             onChanged: onChanged,
//             decoration: InputDecoration(
//               hintText: hint,
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 10,
//                 horizontal: 12,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(color: Color(0xFFCED4DA)),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(color: Color(0xFF950606)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
