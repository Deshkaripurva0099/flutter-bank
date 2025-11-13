import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../../widgets/common_widgets.dart';
import '../../models/form_data_models.dart';

class PersonalLoanForm extends StatefulWidget {
  const PersonalLoanForm({super.key});

  @override
  State<PersonalLoanForm> createState() => _PersonalLoanFormState();
}

class _PersonalLoanFormState extends State<PersonalLoanForm> {
  final _formKey = GlobalKey<FormState>();
  final PersonalLoanFormData _formData = PersonalLoanFormData();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _companyController.dispose();
    _incomeController.dispose();
    _loanAmountController.dispose();
    _tenureController.dispose();
    _purposeController.dispose();
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
      _formData.applicantName = _nameController.text;
      _formData.contact = _contactController.text;
      _formData.email = _emailController.text;
      _formData.address = _addressController.text;
      _formData.company = _companyController.text;
      _formData.income = _incomeController.text;
      _formData.loanAmount = _loanAmountController.text;
      _formData.tenure = _tenureController.text;
      _formData.purpose = _purposeController.text;

      showDialog(
        context: context,
        builder: (context) => SuccessDialog(
          title: 'Application Submitted',
          message:
              'Your Personal Loan application has been submitted successfully!\n\nApplicant: ${_formData.applicantName}',
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
      appBar: AppBar(title: const Text('Personal Loan Application')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '💼 Personal Loan Application Form',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryRed,
                ),
              ),
              const SizedBox(height: 24),

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

              CustomDropdown(
                label: 'Gender',
                value: _formData.gender.isEmpty ? null : _formData.gender,
                items: const ['Male', 'Female', 'Other'],
                onChanged: (value) {
                  setState(() {
                    _formData.gender = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Contact Number',
                controller: _contactController,
                hintText: '10-digit number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact number';
                  }
                  if (value.length != 10) {
                    return 'Contact number must be 10 digits';
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

              const SectionHeader(title: 'Employment & Income'),
              CustomDropdown(
                label: 'Occupation',
                value: _formData.occupation.isEmpty
                    ? null
                    : _formData.occupation,
                items: const ['Salaried', 'Self-Employed', 'Business', 'Other'],
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
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Purpose of Loan',
                controller: _purposeController,
                hintText: 'e.g. Wedding, Travel, Medical',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter purpose';
                  }
                  return null;
                },
              ),

              const SectionHeader(title: 'Documents'),
              CustomDropdown(
                label: 'Identity Proof',
                value: _formData.idProof.isEmpty ? null : _formData.idProof,
                items: const [
                  'Aadhar Card',
                  'PAN Card',
                  'Passport',
                  'Voter ID',
                  'Driving License',
                ],
                onChanged: (value) {
                  setState(() {
                    _formData.idProof = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select ID proof';
                  }
                  return null;
                },
              ),

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
