import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../../widgets/common_widgets.dart';
import '../../models/form_data_models.dart';

class EducationLoanForm extends StatefulWidget {
  const EducationLoanForm({super.key});

  @override
  State<EducationLoanForm> createState() => _EducationLoanFormState();
}

class _EducationLoanFormState extends State<EducationLoanForm> {
  final _formKey = GlobalKey<FormState>();
  final EducationLoanFormData _formData = EducationLoanFormData();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _panAadhaarController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _instituteNameController =
      TextEditingController();
  final TextEditingController _instituteAddressController =
      TextEditingController();
  final TextEditingController _courseDurationController =
      TextEditingController();
  final TextEditingController _annualFeesController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _coApplicantNameController =
      TextEditingController();
  final TextEditingController _coApplicantOccupationController =
      TextEditingController();
  final TextEditingController _coApplicantIncomeController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _panAadhaarController.dispose();
    _addressController.dispose();
    _courseNameController.dispose();
    _instituteNameController.dispose();
    _instituteAddressController.dispose();
    _courseDurationController.dispose();
    _annualFeesController.dispose();
    _loanAmountController.dispose();
    _tenureController.dispose();
    _purposeController.dispose();
    _coApplicantNameController.dispose();
    _coApplicantOccupationController.dispose();
    _coApplicantIncomeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1990),
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
              'Your Education Loan application has been submitted successfully!\n\nApplicant: ${_formData.fullName}',
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
      appBar: AppBar(title: const Text('Education Loan Application')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🎓 Education Loan Application Form',
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
                label: 'Email',
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

              // Course & Institute Details
              const SectionHeader(title: 'Course & Institute Details'),
              CustomTextField(
                label: 'Course Name',
                controller: _courseNameController,
                hintText: 'e.g., B.Tech Computer Science',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter course name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomDropdown(
                label: 'Course Type',
                value: _formData.courseType.isEmpty
                    ? null
                    : _formData.courseType,
                items: const [
                  'Undergraduate',
                  'Postgraduate',
                  'Diploma',
                  'PhD',
                ],
                onChanged: (value) {
                  setState(() {
                    _formData.courseType = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select course type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Institute / University Name',
                controller: _instituteNameController,
                hintText: 'Enter institute name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter institute name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Institute Address',
                controller: _instituteAddressController,
                hintText: 'Enter institute address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter institute address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Course Duration (Years)',
                controller: _courseDurationController,
                hintText: 'Enter duration',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter course duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Annual Fees (${AppConstants.rupeeSymbol})',
                controller: _annualFeesController,
                hintText: 'Enter annual fees',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter annual fees';
                  }
                  return null;
                },
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
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Purpose (Tuition, Hostel, Books, etc.)',
                controller: _purposeController,
                hintText: 'Enter purpose',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter purpose';
                  }
                  return null;
                },
              ),

              // Co-Applicant / Parent Details
              const SectionHeader(title: 'Co-Applicant / Parent Details'),
              CustomTextField(
                label: 'Co-Applicant Full Name',
                controller: _coApplicantNameController,
                hintText: 'Enter parent/guardian name',
              ),
              const SizedBox(height: 16),

              CustomDropdown(
                label: 'Relationship',
                value: _formData.relationship.isEmpty
                    ? null
                    : _formData.relationship,
                items: const ['Father', 'Mother', 'Guardian'],
                onChanged: (value) {
                  setState(() {
                    _formData.relationship = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Occupation',
                controller: _coApplicantOccupationController,
                hintText: 'Enter occupation',
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Annual Income (${AppConstants.rupeeSymbol})',
                controller: _coApplicantIncomeController,
                hintText: 'Enter annual income',
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
