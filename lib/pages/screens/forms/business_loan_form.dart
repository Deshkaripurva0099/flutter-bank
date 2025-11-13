import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../../widgets/common_widgets.dart';
import '../../models/form_data_models.dart';

class BusinessLoanForm extends StatefulWidget {
  const BusinessLoanForm({super.key});

  @override
  State<BusinessLoanForm> createState() => _BusinessLoanFormState();
}

class _BusinessLoanFormState extends State<BusinessLoanForm> {
  final _formKey = GlobalKey<FormState>();
  final BusinessLoanFormData _formData = BusinessLoanFormData();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _panAadhaarController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _registrationController = TextEditingController();
  final TextEditingController _yearsInBusinessController =
      TextEditingController();
  final TextEditingController _businessAddressController =
      TextEditingController();
  final TextEditingController _annualTurnoverController =
      TextEditingController();
  final TextEditingController _netProfitController = TextEditingController();
  final TextEditingController _existingLoansController =
      TextEditingController();
  final TextEditingController _emiObligationsController =
      TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _collateralController = TextEditingController();
  final TextEditingController _guarantorNameController =
      TextEditingController();
  final TextEditingController _guarantorRelationshipController =
      TextEditingController();
  final TextEditingController _guarantorOccupationController =
      TextEditingController();
  final TextEditingController _guarantorIncomeController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _panAadhaarController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _businessNameController.dispose();
    _registrationController.dispose();
    _yearsInBusinessController.dispose();
    _businessAddressController.dispose();
    _annualTurnoverController.dispose();
    _netProfitController.dispose();
    _existingLoansController.dispose();
    _emiObligationsController.dispose();
    _loanAmountController.dispose();
    _tenureController.dispose();
    _purposeController.dispose();
    _collateralController.dispose();
    _guarantorNameController.dispose();
    _guarantorRelationshipController.dispose();
    _guarantorOccupationController.dispose();
    _guarantorIncomeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formData.fullName = _nameController.text;
      _formData.mobileNumber = _mobileController.text;

      showDialog(
        context: context,
        builder: (context) => SuccessDialog(
          title: 'Application Submitted',
          message:
              'Your Business Loan application has been submitted successfully!\n\nApplicant: ${_formData.fullName}',
          onOk: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Loan Application')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🏢 Business Loan Application Form',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryRed,
                ),
              ),
              const SizedBox(height: 24),

              // Applicant Details
              const SectionHeader(title: 'Applicant Details'),
              CustomTextField(
                label: 'Full Name',
                controller: _nameController,
                hintText: 'Enter your full name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'PAN / Aadhaar Number',
                controller: _panAadhaarController,
                hintText: 'Enter PAN or Aadhaar',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PAN/Aadhaar';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Mobile Number',
                controller: _mobileController,
                hintText: '10-digit number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  if (value.length != 10) {
                    return 'Mobile number must be 10 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Email Address',
                controller: _emailController,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Current Address',
                controller: _addressController,
                hintText: 'Enter your address',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),

              // Business Details
              const SectionHeader(title: 'Business Details'),
              CustomTextField(
                label: 'Business Name',
                controller: _businessNameController,
                hintText: 'Enter business name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter business name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomDropdown(
                label: 'Business Type',
                value: _formData.businessType.isEmpty
                    ? null
                    : _formData.businessType,
                items: const [
                  'Proprietorship',
                  'Partnership',
                  'Private Limited',
                  'LLP',
                ],
                onChanged: (value) {
                  setState(() {
                    _formData.businessType = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select business type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Business Registration / GST Number',
                controller: _registrationController,
                hintText: 'Enter registration number',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Years in Business',
                controller: _yearsInBusinessController,
                hintText: 'Enter years',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Business Address',
                controller: _businessAddressController,
                hintText: 'Enter business address',
                maxLines: 3,
              ),

              // Financial Details
              const SectionHeader(title: 'Financial Details'),
              CustomTextField(
                label: 'Annual Turnover (${AppConstants.rupeeSymbol})',
                controller: _annualTurnoverController,
                hintText: 'Enter annual turnover',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Net Profit (${AppConstants.rupeeSymbol})',
                controller: _netProfitController,
                hintText: 'Enter net profit',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Existing Loans (if any)',
                controller: _existingLoansController,
                hintText: 'Enter details of existing loans',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'EMI Obligations (${AppConstants.rupeeSymbol})',
                controller: _emiObligationsController,
                hintText: 'Enter monthly EMI obligations',
                keyboardType: TextInputType.number,
              ),

              // Loan Requirements
              const SectionHeader(title: 'Loan Requirements'),
              CustomTextField(
                label: 'Loan Amount Required (${AppConstants.rupeeSymbol})',
                controller: _loanAmountController,
                hintText: 'Enter loan amount',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter loan amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Tenure (Months)',
                controller: _tenureController,
                hintText: 'Enter tenure in months',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter tenure';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Purpose of Loan',
                controller: _purposeController,
                hintText: 'e.g., Business expansion, Equipment purchase',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter purpose';
                  }
                  return null;
                },
              ),

              // Collateral / Security
              const SectionHeader(title: 'Collateral / Security'),
              CustomTextField(
                label: 'Collateral Details',
                controller: _collateralController,
                hintText: 'Enter collateral details',
                maxLines: 3,
              ),

              // Guarantor Details
              const SectionHeader(title: 'Guarantor Details'),
              CustomTextField(
                label: 'Guarantor Full Name',
                controller: _guarantorNameController,
                hintText: 'Enter guarantor name',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Relationship with Applicant',
                controller: _guarantorRelationshipController,
                hintText: 'e.g., Partner, Family',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Guarantor Occupation',
                controller: _guarantorOccupationController,
                hintText: 'Enter occupation',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Guarantor Annual Income (${AppConstants.rupeeSymbol})',
                controller: _guarantorIncomeController,
                hintText: 'Enter annual income',
                keyboardType: TextInputType.number,
              ),

              // Declaration
              const SizedBox(height: 24),
              CheckboxListTile(
                value: true,
                onChanged: (value) {
                  setState(() {});
                },
                title: const Text(
                  'I hereby declare that the information provided is true and correct.',
                  style: TextStyle(fontSize: 14),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              // Submit Buttons
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit Application'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
