import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../../widgets/common_widgets.dart';
import '../../models/form_data_models.dart';

class GoldLoanForm extends StatefulWidget {
  const GoldLoanForm({super.key});

  @override
  State<GoldLoanForm> createState() => _GoldLoanFormState();
}

class _GoldLoanFormState extends State<GoldLoanForm> {
  final _formKey = GlobalKey<FormState>();
  final GoldLoanFormData _formData = GoldLoanFormData();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _goldWeightController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _goldWeightController.addListener(_calculateLoanAmount);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _goldWeightController.dispose();
    _tenureController.dispose();
    super.dispose();
  }

  void _calculateLoanAmount() {
    setState(() {
      _formData.goldWeight = _goldWeightController.text;
    });
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
      _formData.applicantName = _nameController.text;
      _formData.contact = _contactController.text;

      final eligibleAmount = _formData.calculateLoanAmount();

      showDialog(
        context: context,
        builder: (context) => SuccessDialog(
          title: 'Application Submitted',
          message:
              'Your Gold Loan application has been submitted successfully!\n\nApplicant: ${_formData.applicantName}\nEligible Loan Amount: ${CurrencyFormatter.format(eligibleAmount)}',
          onOk: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final eligibleAmount = _formData.calculateLoanAmount();

    return Scaffold(
      appBar: AppBar(title: const Text('Gold Loan Application')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '💰 Gold Loan Application Form',
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

              // Gold Details
              const SectionHeader(title: 'Gold Details'),
              CustomDropdown(
                label: 'Gold Type',
                value: _formData.goldType.isEmpty ? null : _formData.goldType,
                items: const ['Jewellery', 'Coins', 'Bullion'],
                onChanged: (value) {
                  setState(() {
                    _formData.goldType = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select gold type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Gold Weight (grams)',
                controller: _goldWeightController,
                hintText: 'Enter weight in grams',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter gold weight';
                  }
                  final weight = double.tryParse(value);
                  if (weight == null || weight <= 0) {
                    return 'Please enter valid weight';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomDropdown(
                label: 'Purity (karat)',
                value: _formData.goldPurity.isEmpty
                    ? null
                    : _formData.goldPurity,
                items: const ['18', '22', '24'],
                onChanged: (value) {
                  setState(() {
                    _formData.goldPurity = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select gold purity';
                  }
                  return null;
                },
              ),

              // Loan Calculation Display
              if (eligibleAmount > 0) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryRed,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Eligible Loan Amount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        CurrencyFormatter.format(eligibleAmount),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 20),

              // Tenure
              CustomTextField(
                label: 'Tenure (months)',
                controller: _tenureController,
                hintText: 'Enter tenure',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter tenure';
                  }
                  final tenure = int.tryParse(value);
                  if (tenure == null || tenure <= 0) {
                    return 'Please enter valid tenure';
                  }
                  return null;
                },
              ),

              // Documents
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
              const SizedBox(height: 16),

              // File upload placeholder
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.upload_file,
                      color: AppConstants.primaryRed,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Upload Address Proof',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // Handle file upload
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('File upload feature coming soon'),
                          ),
                        );
                      },
                      child: const Text('Choose File'),
                    ),
                  ],
                ),
              ),

              // Declaration
              const SizedBox(height: 24),
              CheckboxListTile(
                value: true,
                onChanged: (value) {
                  setState(() {});
                },
                title: const Text(
                  'I confirm that the details provided are true and correct.',
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
