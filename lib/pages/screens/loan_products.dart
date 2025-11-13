import 'package:flutter/material.dart';
import 'package:neobank/pages/utils/constants.dart';
import 'package:neobank/pages/models/loan_model.dart';

// Import all form pages with absolute paths
import 'package:neobank/pages/screens/forms/personal_loan_form.dart';
import 'package:neobank/pages/screens/forms/home_loan_form.dart';
import 'package:neobank/pages/screens/forms/car_loan_form.dart';
import 'package:neobank/pages/screens/forms/education_loan_form.dart';
import 'package:neobank/pages/screens/forms/business_loan_form.dart';
import 'package:neobank/pages/screens/forms/gold_loan_form.dart';

class LoanProducts extends StatelessWidget {
  const LoanProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LoanProduct> loans = [
      LoanProduct(
        type: 'Personal Loan',
        icon: Icons.person,
        rate: '10.5% p.a.',
        tenure: '60 months',
        purpose: 'Weddings, travel, or medical emergencies',
        maxAmount: '₹15,00,000.00',
        processing: '24-48 hours',
        route: 'personal',
      ),
      LoanProduct(
        type: 'Home Loan',
        icon: Icons.home,
        rate: '7.2% p.a.',
        tenure: '360 months',
        purpose: 'Purchasing or constructing a new home',
        maxAmount: '₹1,00,00,000.00',
        processing: '24-48 hours',
        route: 'home',
      ),
      LoanProduct(
        type: 'Car Loan',
        icon: Icons.directions_car,
        rate: '8.9% p.a.',
        tenure: '84 months',
        purpose: 'Finance your dream car',
        maxAmount: '₹25,00,000.00',
        processing: '24-48 hours',
        route: 'car',
      ),
      LoanProduct(
        type: 'Education Loan',
        icon: Icons.school,
        rate: '9.8% p.a.',
        tenure: '120 months',
        purpose: 'Higher education in India or abroad',
        maxAmount: '₹75,00,000.00',
        processing: '24-48 hours',
        route: 'education',
      ),
      LoanProduct(
        type: 'Small Business Loan',
        icon: Icons.business,
        rate: '12% p.a.',
        tenure: '48 months',
        purpose: 'Business expansion',
        maxAmount: '₹50,00,000.00',
        processing: '24-48 hours',
        route: 'business',
      ),
      LoanProduct(
        type: 'Gold Loan',
        icon: Icons.stars,
        rate: '9.5% p.a.',
        tenure: '24 months',
        purpose: 'Liquidity against gold ornaments',
        maxAmount: '₹20,00,000.00',
        processing: '24-48 hours',
        route: 'gold',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Loan Products'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose from our range of competitive loan options',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: loans.length,
              itemBuilder: (context, index) {
                return _buildLoanCard(context, loans[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanCard(BuildContext context, LoanProduct loan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    loan.icon,
                    color: AppConstants.primaryRed,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    loan.type,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Text(
              loan.purpose,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),

            _buildInfoRow('Interest Rate:', loan.rate),
            const SizedBox(height: 8),
            _buildInfoRow('Tenure:', loan.tenure),
            const SizedBox(height: 8),
            _buildInfoRow('Max Amount:', loan.maxAmount),
            const SizedBox(height: 8),
            _buildInfoRow('Processing Time:', loan.processing),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _navigateToForm(context, loan.route);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryRed,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Apply Now',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void _navigateToForm(BuildContext context, String route) {
    Widget? page;

    switch (route) {
      case 'personal':
        page = const PersonalLoanForm();
        break;
      case 'home':
        page = const HomeLoanForm();
        break;
      case 'car':
        page = const CarLoanForm();
        break;
      case 'education':
        page = const EducationLoanForm();
        break;
      case 'business':
        page = const BusinessLoanForm();
        break;
      case 'gold':
        page = const GoldLoanForm();
        break;
    }

    if (page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page!),
      );
    } else {
      // Show error if page is null
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form not available'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}