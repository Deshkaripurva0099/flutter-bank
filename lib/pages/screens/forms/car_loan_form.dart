import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../../widgets/common_widgets.dart';
import '../../models/form_data_models.dart';

class CarLoanForm extends StatefulWidget {
  const CarLoanForm({super.key});

  @override
  State<CarLoanForm> createState() => _CarLoanFormState();
}

class _CarLoanFormState extends State<CarLoanForm> {
  final _formKey = GlobalKey<FormState>();
  final CarLoanFormData _formData = CarLoanFormData();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _panAadhaarController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();
  final TextEditingController _variantController = TextEditingController();
  final TextEditingController _exShowroomController = TextEditingController();
  final TextEditingController _onRoadController = TextEditingController();
  final TextEditingController _dealerController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _downPaymentController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();

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
    _carModelController.dispose();
    _variantController.dispose();
    _exShowroomController.dispose();
    _onRoadController.dispose();
    _dealerController.dispose();
    _loanAmountController.dispose();
    _downPaymentController.dispose();
    _tenureController.dispose();
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
    if (_formKey.currentState!.validate()) {
      _formData.fullName = _nameController.text;
      _formData.mobileNumber = _mobileController.text;

      showDialog(
        context: context,
        builder: (context) => SuccessDialog(
          title: 'Application Submitted',
          message:
              'Your Car Loan application has been submitted successfully!\n\nApplicant: ${_formData.fullName}',
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
      appBar: AppBar(title: const Text('Car Loan Application')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🚗 Car Loan Application Form',
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
                label: 'PAN / Aadhaar Number',
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

              // Vehicle Details
              const SectionHeader(title: 'Vehicle Details'),
              CustomTextField(
                label: 'Car Make & Model',
                controller: _carModelController,
                hintText: 'e.g., Maruti Swift',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter car model';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Variant / Fuel Type',
                controller: _variantController,
                hintText: 'e.g., VXi Petrol',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter variant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Ex-Showroom Price (${AppConstants.rupeeSymbol})',
                controller: _exShowroomController,
                hintText: 'Enter ex-showroom price',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'On-Road Price (${AppConstants.rupeeSymbol})',
                controller: _onRoadController,
                hintText: 'Enter on-road price',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Dealer Name',
                controller: _dealerController,
                hintText: 'Enter dealer name',
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
                label: 'Down Payment (${AppConstants.rupeeSymbol})',
                controller: _downPaymentController,
                hintText: 'Enter down payment',
                keyboardType: TextInputType.number,
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

              // Declaration
              const SizedBox(height: 24),
              CheckboxListTile(
                value: _formData.occupation.isNotEmpty,
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
