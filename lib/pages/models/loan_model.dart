import 'package:flutter/material.dart';

class LoanProduct {
  final String type;
  final IconData icon;
  final String rate;
  final String tenure;
  final String purpose;
  final String maxAmount;
  final String processing;
  final String route;

  LoanProduct({
    required this.type,
    required this.icon,
    required this.rate,
    required this.tenure,
    required this.purpose,
    required this.maxAmount,
    required this.processing,
    required this.route,
  });
}

class LoanTransaction {
  final DateTime date;
  final String description;
  final double amount;

  LoanTransaction({
    required this.date,
    required this.description,
    required this.amount,
  });
}

class ActiveLoan {
  final String loanType;
  final double loanAmount;
  final double outstanding;
  final double monthlyEmi;
  final DateTime nextEmiDate;
  final double interestRate;
  final int tenureMonths;
  final int monthsPaid;
  final int monthsRemaining;

  ActiveLoan({
    required this.loanType,
    required this.loanAmount,
    required this.outstanding,
    required this.monthlyEmi,
    required this.nextEmiDate,
    required this.interestRate,
    required this.tenureMonths,
    required this.monthsPaid,
    required this.monthsRemaining,
  });

  double get progress => (monthsPaid / tenureMonths) * 100;
  double get amountPaid => loanAmount - outstanding;
}