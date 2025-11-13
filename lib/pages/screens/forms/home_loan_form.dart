import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../../widgets/common_widgets.dart';
import '../../models/form_data_models.dart';

class HomeLoanForm extends StatefulWidget {
  const HomeLoanForm({super.key});

  @override
  State<HomeLoanForm> createState() => _HomeLoanFormState();
}

class _HomeLoanFormState extends State<HomeLoanForm> {
  final _formKey = GlobalKey<FormState>();
  final HomeLoanFormData _formData = HomeLoanFormData();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _panAadhaarController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _propertyTypeController = TextEditingController();
  final TextEditingController _propertyLocationController =
      TextEditingController();
  final TextEditingController _propertyValueController =
      TextEditingController();
  final TextEditingController _builderController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _coApplicantNameController =
      TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _coApplicantIncomeController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _panAadhaarController.dispose();
    _addressController.dispose();
    _companyController.dispose();
    _incomeController.dispose();
    _experienceController.dispose();
    _propertyTypeController.dispose();
    _propertyLocationController.dispose();
    _propertyValueController.dispose();
    _builderController.dispose();
    _loanAmountController.dispose();
    _tenureController.dispose();
    _coApplicantNameController.dispose();
    _relationshipController.dispose();
    _coApplicantIncomeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _formData.dob = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _formData.declaration) {
      _formData.fullName = _nameController.text;
      _formData.mobileNumber = _mobileController.text;

      showDialog(
        context: context,
        builder: (context) => SuccessDialog(
          title: 'Application Submitted',
          message:
              'Your Home Loan application has been submitted successfully!\n\nApplicant: ${_formData.fullName}',
          onOk: () {
            Navigator.pop(context);
          },
        ),
      );
    } else if (!_formData.declaration) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the declaration'),
          backgroundColor: AppConstants.dangerRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Loan Application')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🏠 Home Loan Application Form',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryRed,
                ),
              ),
              const SizedBox(height: 24),

              // Personal Details
              const SectionHeader(title: 'Personal Details'),
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
                label: 'Date of Birth',
                hintText: _formData.dob != null
                    ? DateFormatter.format(_formData.dob!)
                    : 'Select date of birth',
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (_formData.dob == null) {
                    return 'Please select date of birth';
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
                label: 'Email ID',
                controller: _emailController,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'PAN / Aadhaar',
                controller: _panAadhaarController,
                hintText: 'Enter PAN or Aadhaar number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PAN/Aadhaar';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Address',
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

              // Employment & Income
              const SectionHeader(title: 'Employment & Income'),
              CustomDropdown(
                label: 'Occupation',
                value: _formData.occupation.isEmpty
                    ? null
                    : _formData.occupation,
                items: const ['Salaried', 'Self-Employed', 'Business'],
                onChanged: (value) {
                  setState(() {
                    _formData.occupation = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select occupation';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Company / Business Name',
                controller: _companyController,
                hintText: 'Enter company name',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Monthly Income (${AppConstants.rupeeSymbol})',
                controller: _incomeController,
                hintText: 'Enter monthly income',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Work Experience (Years)',
                controller: _experienceController,
                hintText: 'Enter years of experience',
                keyboardType: TextInputType.number,
              ),

              // Property Details
              const SectionHeader(title: 'Property Details'),
              CustomTextField(
                label: 'Property Type',
                controller: _propertyTypeController,
                hintText: 'e.g., Apartment, Villa, Plot',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Location',
                controller: _propertyLocationController,
                hintText: 'Enter property location',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Property Value (${AppConstants.rupeeSymbol})',
                controller: _propertyValueController,
                hintText: 'Enter property value',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Builder / Seller Name',
                controller: _builderController,
                hintText: 'Enter builder or seller name',
              ),

              // Loan Details
              const SectionHeader(title: 'Loan Details'),
              CustomTextField(
                label: 'Loan Amount (${AppConstants.rupeeSymbol})',
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

              // Co-Applicant (Optional)
              const SectionHeader(title: 'Co-Applicant (Optional)'),
              CustomTextField(
                label: 'Full Name',
                controller: _coApplicantNameController,
                hintText: 'Enter co-applicant name',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Relationship',
                controller: _relationshipController,
                hintText: 'e.g., Spouse, Parent',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Monthly Income (${AppConstants.rupeeSymbol})',
                controller: _coApplicantIncomeController,
                hintText: 'Enter monthly income',
                keyboardType: TextInputType.number,
              ),

              // Declaration
              const SizedBox(height: 24),
              CheckboxListTile(
                value: _formData.declaration,
                onChanged: (value) {
                  setState(() {
                    _formData.declaration = value ?? false;
                  });
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
