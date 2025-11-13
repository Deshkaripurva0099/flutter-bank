class PersonalLoanFormData {
  String applicantName = '';
  DateTime? dob;
  String gender = '';
  String contact = '';
  String email = '';
  String address = '';
  String occupation = '';
  String company = '';
  String income = '';
  String loanAmount = '';
  String tenure = '';
  String purpose = '';
  String idProof = '';
  bool declaration = false;
}

class HomeLoanFormData {
  String fullName = '';
  DateTime? dob;
  String mobileNumber = '';
  String email = '';
  String panAadhaar = '';
  String address = '';
  String occupation = '';
  String company = '';
  String monthlyIncome = '';
  String workExperience = '';
  String propertyType = '';
  String propertyLocation = '';
  String propertyValue = '';
  String builderName = '';
  String loanAmount = '';
  String tenure = '';
  String coApplicantName = '';
  String relationship = '';
  String coApplicantIncome = '';
  bool declaration = false;
}

class CarLoanFormData {
  String fullName = '';
  DateTime? dob;
  String mobileNumber = '';
  String email = '';
  String panAadhaar = '';
  String address = '';
  String occupation = '';
  String company = '';
  String monthlyIncome = '';
  String workExperience = '';
  String carModel = '';
  String variantFuel = '';
  String exShowroomPrice = '';
  String onRoadPrice = '';
  String dealerName = '';
  String loanAmount = '';
  String downPayment = '';
  String tenure = '';
}

class EducationLoanFormData {
  String fullName = '';
  DateTime? dob;
  String mobileNumber = '';
  String email = '';
  String panAadhaar = '';
  String address = '';
  String courseName = '';
  String courseType = '';
  String instituteName = '';
  String instituteAddress = '';
  String courseDuration = '';
  String annualFees = '';
  String loanAmount = '';
  String tenure = '';
  String purpose = '';
  String coApplicantName = '';
  String relationship = '';
  String coApplicantOccupation = '';
  String coApplicantIncome = '';
  bool declaration = false;
}

class GoldLoanFormData {
  String applicantName = '';
  DateTime? dob;
  String gender = '';
  String contact = '';
  String email = '';
  String address = '';
  String goldType = '';
  String goldWeight = '';
  String goldPurity = '';
  String tenure = '';
  String idProof = '';
  
  double calculateLoanAmount() {
    if (goldWeight.isEmpty || goldPurity.isEmpty) return 0;
    
    const double goldPricePerGram = 6000;
    const double ltv = 0.75;
    
    double weight = double.tryParse(goldWeight) ?? 0;
    double purity = double.tryParse(goldPurity) ?? 0;
    
    double purityFactor = purity / 24;
    double goldValue = weight * purityFactor * goldPricePerGram;
    
    return (goldValue * ltv).floorToDouble();
  }
}

class BusinessLoanFormData {
  String fullName = '';
  String panAadhaar = '';
  String mobileNumber = '';
  String email = '';
  String address = '';
  String businessName = '';
  String businessType = '';
  String registrationNumber = '';
  String yearsInBusiness = '';
  String businessAddress = '';
  String annualTurnover = '';
  String netProfit = '';
  String existingLoans = '';
  String emiObligations = '';
  String loanAmount = '';
  String tenure = '';
  String purpose = '';
  String collateral = '';
  String guarantorName = '';
  String guarantorRelationship = '';
  String guarantorOccupation = '';
  String guarantorIncome = '';
}