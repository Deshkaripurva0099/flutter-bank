import 'package:flutter/material.dart';
import 'package:neobank/widgets/topbar.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  String recipientType = "mobile";
  String mobile = "";
  String upiId = "";
  Map<String, String> bank = {"acc": "", "confirmAcc": "", "ifsc": ""};
  String amount = "";
  String remark = "";
  String error = "";

  bool validate() {
    setState(() {
      error = "";
    });
    if (amount.isEmpty ||
        double.tryParse(amount) == null ||
        double.parse(amount) <= 0) {
      setState(() {
        error = "Enter valid amount.";
      });
      return false;
    }
    if (recipientType == "mobile" && !RegExp(r'^\d{10}$').hasMatch(mobile)) {
      setState(() {
        error = "Enter valid 10-digit mobile number.";
      });
      return false;
    }
    if (recipientType == "upi" &&
        !RegExp(r'^[\w.+-]+@[\w]+$').hasMatch(upiId)) {
      setState(() {
        error = "Enter valid UPI ID.";
      });
      return false;
    }
    if (recipientType == "bank") {
      if (bank["acc"]!.isEmpty ||
          bank["confirmAcc"]!.isEmpty ||
          bank["acc"] != bank["confirmAcc"]) {
        setState(() {
          error = "Account numbers do not match.";
        });
        return false;
      }
      if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(bank["ifsc"]!)) {
        setState(() {
          error = "Enter valid IFSC code.";
        });
        return false;
      }
    }
    return true;
  }

  void handleSend() {
    if (!validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("✅ Sent ₹$amount via ${recipientType.toUpperCase()}"),
      ),
    );

    setState(() {
      mobile = "";
      upiId = "";
      bank = {"acc": "", "confirmAcc": "", "ifsc": ""};
      amount = "";
      remark = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarTop(),
      backgroundColor: const Color(0xFFFAFAFA),

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 40,
            left: 20,
            right: 20,
            bottom: 20,
          ),

          // padding: const EdgeInsets.all(20, top: 40),
          //padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              // Recipient Type Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ["mobile", "upi", "bank"].map((type) {
                  String label = type == "mobile"
                      ? "📱 Mobile"
                      : type == "upi"
                      ? "💳 UPI ID"
                      : "🏦 Bank";
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: recipientType == type
                              ? const Color(0xFF950606)
                              : Colors.white,
                          foregroundColor: recipientType == type
                              ? Colors.white
                              : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: recipientType == type
                                  ? const Color(0xFF950606)
                                  : Colors.grey,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          setState(() {
                            recipientType = type;
                          });
                        },
                        child: Text(label),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Conditional Inputs
              if (recipientType == "mobile")
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "📱 Enter Mobile Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  onChanged: (val) => setState(() => mobile = val),
                ),
              if (recipientType == "upi")
                TextField(
                  decoration: const InputDecoration(
                    hintText: "💳 Enter UPI ID (e.g. name@upi)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  onChanged: (val) => setState(() => upiId = val),
                ),
              if (recipientType == "bank") ...[
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "🏦 Account Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  onChanged: (val) => setState(() => bank["acc"] = val),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "🔁 Confirm Account Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  onChanged: (val) => setState(() => bank["confirmAcc"] = val),
                ),
                const SizedBox(height: 10),
                TextField(
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    hintText: "🔑 IFSC Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  onChanged: (val) =>
                      setState(() => bank["ifsc"] = val.toUpperCase()),
                ),
              ],

              const SizedBox(height: 10),
              // Amount
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "💰 Enter Amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                onChanged: (val) => setState(() => amount = val),
              ),
              const SizedBox(height: 10),
              // Remark
              TextField(
                decoration: const InputDecoration(
                  hintText: "📝 Remark (optional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                onChanged: (val) => setState(() => remark = val),
              ),
              const SizedBox(height: 10),

              // Error Message
              if (error.isNotEmpty)
                Text(
                  "⚠️ $error",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 10),

              // Send Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: handleSend,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF950606),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    "🚀 Send ₹${amount.isEmpty ? '0' : amount} Now",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
