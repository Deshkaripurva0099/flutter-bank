import 'package:flutter/material.dart';
import 'package:neobank/widgets/layout.dart';
import 'package:neobank/pages/utils/constants.dart';
import 'package:neobank/pages/screens/loan_calculator.dart';
import 'package:neobank/pages/screens/active_loan_card.dart';
import 'package:neobank/pages/screens/loan_products.dart';
import 'package:neobank/pages/screens/loan_cards.dart';
import 'package:neobank/pages/models/loan_model.dart';

class LoanDashboard extends StatelessWidget {
  const LoanDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Preview loan products (first 3)
    final List<LoanProduct> previewLoans = [
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
    ];

    return AppLayout(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header Section =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              decoration: const BoxDecoration(
                color: AppConstants.primaryRed,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Loans',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Achieve your dreams with flexible loan options',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoanProducts(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.account_balance_wallet),
                      label: const Text('Apply for Loan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppConstants.primaryRed,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // EMI Calculator
            const LoanCalculatorWidget(),

            const SizedBox(height: 20),

            // Active Loan Card
            const ActiveLoanCardWidget(),

            const SizedBox(height: 20),

            // Loan Statistics Cards
            const LoanCardsWidget(),

            const SizedBox(height: 20),

            // Available Loan Products Preview
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Loans',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoanProducts(),
                        ),
                      );
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Preview Cards
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: Column(
                children: previewLoans.map((loan) {
                  return _buildLoanPreviewCard(context, loan);
                }).toList(),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanPreviewCard(BuildContext context, LoanProduct loan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const LoanProducts()));
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
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
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loan.type,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${loan.rate} • Up to ${loan.maxAmount}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
