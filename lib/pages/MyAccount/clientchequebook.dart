import 'package:flutter/material.dart';

const Color primaryRed = Color(0xFF900603);

class ChequeBookRequest extends StatefulWidget {
  const ChequeBookRequest({super.key});

  @override
  State<ChequeBookRequest> createState() => _ChequeBookRequestState();
}

class _ChequeBookRequestState extends State<ChequeBookRequest> {
  int currentStep = 1;
  bool isSubmitted = false;

  final formData = {
    'accountType': '',
    'accountNumber': '',
    'numberOfBooks': '1 Book (25 leaves)',
    'deliveryType': 'home',
    'fullName': '',
    'mobileNumber': '',
    'email': '',
    'address': '',
    'city': '',
    'state': '',
    'pincode': '',
    'landmark': '',
  };

  // Validation states
  final Map<String, bool> _fieldValidations = {
    'accountType': false,
    'accountNumber': false,
    'fullName': false,
    'mobileNumber': false,
    'email': false,
    'address': false,
    'city': false,
    'state': false,
    'pincode': false,
  };

  bool get _isStep1Valid {
    return _fieldValidations['accountType'] == true &&
        _fieldValidations['accountNumber'] == true;
  }

  bool get _isStep2Valid {
    return _fieldValidations['fullName'] == true &&
        _fieldValidations['mobileNumber'] == true &&
        _fieldValidations['email'] == true;
  }

  bool get _isStep3Valid {
    return _fieldValidations['address'] == true &&
        _fieldValidations['city'] == true &&
        _fieldValidations['state'] == true &&
        _fieldValidations['pincode'] == true;
  }

  void _updateValidation(String field, String value) {
    bool isValid = false;
    
    switch (field) {
      case 'accountType':
        isValid = value.isNotEmpty;
        break;
      case 'accountNumber':
        isValid = value.isNotEmpty;
        break;
      case 'fullName':
        isValid = value.length >= 3;
        break;
      case 'mobileNumber':
        isValid = RegExp(r'^[0-9]{10}$').hasMatch(value);
        break;
      case 'email':
        isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
        break;
      case 'address':
        isValid = value.length >= 10;
        break;
      case 'city':
      case 'state':
        isValid = value.length >= 2;
        break;
      case 'pincode':
        isValid = RegExp(r'^[0-9]{6}$').hasMatch(value);
        break;
      default:
        isValid = true;
    }

    setState(() {
      _fieldValidations[field] = isValid;
    });
  }

  void nextStep() {
    if (currentStep < 3) setState(() => currentStep++);
  }

  void prevStep() {
    if (currentStep > 1) setState(() => currentStep--);
  }

  void handleSubmit() {
    setState(() => isSubmitted = true);
  }

  void resetForm() {
    setState(() {
      isSubmitted = false;
      currentStep = 1;
      formData.updateAll((key, value) => '');
      formData['numberOfBooks'] = '1 Book (25 leaves)';
      formData['deliveryType'] = 'home';
      _fieldValidations.updateAll((key, value) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSubmitted) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 400),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F5E8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 35,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Request Submitted Successfully!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "Your cheque book request has been received. You will receive a confirmation SMS and email shortly.",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFF8F9FA),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Request ID: CB${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryRed,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Expected delivery: 3–5 business days",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Make Another Request",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
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

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              // 🔴 Main Container - Fixed right padding
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: 700 - 11, // Reduced by 11 pixels
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Red Header
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primaryRed,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            child: Image.asset(
                              'assets/neobank-white.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.account_balance, 
                                  color: Colors.white,
                                  size: 32
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Neo Bank Cheque Book",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 20, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Quick and secure cheque book ordering",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Simple Linear Progress Bar
                    Container(
                      padding: EdgeInsets.only(left: 24, right: 13, top: 24, bottom: 16),
                      child: _simpleLinearProgress(),
                    ),

                    // Form Content - Fixed padding
                    Container(
                      padding: const EdgeInsets.only(left: 24, right: 13, top: 0, bottom: 24),
                      child: _buildFormContent(),
                    ),

                    // Help Section - Added at bottom
                    _buildHelpSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Help Section Widget
  Widget _buildHelpSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: primaryRed, size: 18),
              SizedBox(width: 8),
              Text(
                "Need help?",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Contact our customer support at 1800-XXX-XXXX",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Available 24/7 for your assistance",
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Simple Linear Progress Bar
  Widget _simpleLinearProgress() {
    const int totalSteps = 3;
    final double progress = (currentStep - 1) / (totalSteps - 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Step $currentStep of $totalSteps", style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(_stepTitleShort(), style: const TextStyle(color: Colors.black54)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(primaryRed),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  String _stepTitleShort() {
    switch (currentStep) {
      case 1:
        return "Account Details";
      case 2:
        return "Personal Information";
      case 3:
        return "Delivery Address";
      default:
        return "";
    }
  }

  Widget _buildFormContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Current Step Header
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: primaryRed,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "$currentStep",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStepTitle(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryRed,
                      ),
                    ),
                    Text(
                      _getStepSubtitle(),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Form Content
        _buildFormCard(),
      ],
    );
  }

  String _getStepTitle() {
    switch (currentStep) {
      case 1: return "Account Details";
      case 2: return "Personal Information";
      case 3: return "Delivery Address";
      default: return "";
    }
  }

  String _getStepSubtitle() {
    switch (currentStep) {
      case 1: return "Select account type and enter account details";
      case 2: return "Provide your contact information";
      case 3: return "Enter delivery address details";
      default: return "";
    }
  }

  Widget _buildFormCard() {
    switch (currentStep) {
      case 1:
        return _step1();
      case 2:
        return _step2();
      case 3:
        return _step3();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _step1() {
    return Column(
      children: [
        _dropdownField("Account Type", "accountType", ["Select Account Type", "Savings Account", "Current Account", "Salary Account"]),
        const SizedBox(height: 20),
        _textField("Account Number", "accountNumber", "Enter your account number"),
        const SizedBox(height: 20),
        _dropdownField("Number of Cheque Books", "numberOfBooks", [
          "1 Book (25 leaves)",
          "2 Books (50 leaves)", 
          "3 Books (75 leaves)"
        ]),
        const SizedBox(height: 20),
        _deliveryTypeField(),
        const SizedBox(height: 25),
        _navigationButtons(validate: _isStep1Valid),
      ],
    );
  }

  Widget _step2() {
    return Column(
      children: [
        _textField("Full Name", "fullName", "Enter your full name as per bank records"),
        const SizedBox(height: 20),
        _textField("Mobile Number", "mobileNumber", "Enter 10-digit mobile number"),
        const SizedBox(height: 20),
        _textField("Email Address", "email", "Enter your email address"),
        const SizedBox(height: 25),
        _navigationButtons(validate: _isStep2Valid),
      ],
    );
  }

  Widget _step3() {
    return Column(
      children: [
        _textField("Complete Address", "address", "Enter your complete address with house number, street, etc.", multiline: true),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _textField("City", "city", "Enter city")),
            const SizedBox(width: 15),
            Expanded(child: _textField("State", "state", "Enter state")),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _textField("PIN Code", "pincode", "6-digit PIN code")),
            const SizedBox(width: 15),
            Expanded(child: _textField("Landmark (Optional)", "landmark", "Nearby landmark")),
          ],
        ),
        const SizedBox(height: 25),
        _navigationButtons(validate: _isStep3Valid, isLastStep: true),
      ],
    );
  }



// Delivery Type Selection Widget - Compact Version
Widget _deliveryTypeField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Delivery Type",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 12),
      
      // Radio Buttons Container
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // Home Delivery Option
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              leading: Radio<String>(
                value: "home",
                groupValue: formData['deliveryType'],
                onChanged: (value) {
                  setState(() {
                    formData['deliveryType'] = value!;
                  });
                },
                activeColor: primaryRed,
              ),
              title: Row(
                children: [
                  Icon(Icons.home, color: primaryRed, size: 20),
                  SizedBox(width: 8),
                  Text("Home Delivery"),
                ],
              ),
              onTap: () {
                setState(() {
                  formData['deliveryType'] = "home";
                });
              },
            ),
            
            Divider(height: 1, color: Colors.grey.shade300),
            
            // Branch Collection Option
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              leading: Radio<String>(
                value: "branch",
                groupValue: formData['deliveryType'],
                onChanged: (value) {
                  setState(() {
                    formData['deliveryType'] = value!;
                  });
                },
                activeColor: primaryRed,
              ),
              title: Row(
                children: [
                  Icon(Icons.account_balance, color: primaryRed, size: 20),
                  SizedBox(width: 8),
                  Text("Branch Collection"),
                ],
              ),
              onTap: () {
                setState(() {
                  formData['deliveryType'] = "branch";
                });
              },
            ),
          ],
        ),
      ),
    ],
  );
}




















/*
 // Delivery Type Selection Widget
Widget _deliveryTypeField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Delivery Type",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 12),
      
      // Home Delivery Radio Button
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Radio<String>(
              value: "home",
              groupValue: formData['deliveryType'],
              onChanged: (value) {
                setState(() {
                  formData['deliveryType'] = value!;
                });
              },
              activeColor: primaryRed,
            ),
            SizedBox(width: 8),
            Icon(Icons.home, color: primaryRed, size: 20),
            SizedBox(width: 8),
            Text(
              "Home Delivery",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      
      // Branch Collection Radio Button
      Container(
        width: double.infinity,
        child: Row(
          children: [
            Radio<String>(
              value: "branch",
              groupValue: formData['deliveryType'],
              onChanged: (value) {
                setState(() {
                  formData['deliveryType'] = value!;
                });
              },
              activeColor: primaryRed,
            ),
            SizedBox(width: 8),
            Icon(Icons.account_balance, color: primaryRed, size: 20),
            SizedBox(width: 8),
            Text(
              "Branch Collection",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

  Widget _buildDeliveryOption(String title, String value, IconData icon) {
    bool isSelected = formData['deliveryType'] == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          formData['deliveryType'] = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryRed.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? primaryRed : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? primaryRed : Colors.grey[600],
              size: 24,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? primaryRed : Colors.grey[700],
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }*/

  Widget _textField(String label, String key, String hint, {bool multiline = false}) {
    bool isValid = _fieldValidations[key] ?? true;
    bool hasError = formData[key]!.isNotEmpty && !isValid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: (value) {
            setState(() => formData[key] = value);
            _updateValidation(key, value);
          },
          maxLines: multiline ? 3 : 1,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryRed),
            ),
            errorText: hasError ? _getErrorMessage(key) : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        if (!hasError && formData[key]!.isNotEmpty && isValid)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 16),
                SizedBox(width: 4),
                Text("Valid", style: TextStyle(color: Colors.green, fontSize: 12)),
              ],
            ),
          ),
      ],
    );
  }

  String _getErrorMessage(String field) {
    switch (field) {
      case 'accountNumber':
        return 'Please enter your account number';
      case 'mobileNumber':
        return 'Please enter a valid 10-digit mobile number';
      case 'email':
        return 'Please enter a valid email address';
      case 'pincode':
        return 'Please enter a valid 6-digit PIN code';
      case 'address':
        return 'Address should be at least 10 characters long';
      case 'fullName':
        return 'Name should be at least 3 characters long';
      default:
        return 'This field is required';
    }
  }

  Widget _dropdownField(String label, String key, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: formData[key]!.isEmpty ? options[0] : formData[key],
          onChanged: (value) {
            setState(() => formData[key] = value!);
            _updateValidation(key, value!);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryRed),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          items: options.map((option) => DropdownMenuItem(
            value: option,
            child: Text(option),
          )).toList(),
        ),
      ],
    );
  }

  Widget _navigationButtons({required bool validate, bool isLastStep = false}) {
    return Row(
      children: [
        if (currentStep > 1)
          Expanded(
            child: OutlinedButton(
              onPressed: prevStep,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                side: BorderSide(color: Colors.grey[400]!),
              ),
              child: Text(
                "Previous",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        if (currentStep > 1) SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            onPressed: validate ? (isLastStep ? handleSubmit : nextStep) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryRed,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isLastStep ? "Submit Request" : "Next Step →",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}