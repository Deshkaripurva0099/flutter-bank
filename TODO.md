
# TODO: Add Instructions Text Above Record Button in Video KYC Screen

- [x] Remove the Container styling (padding and decoration) around the instructions in video_kyc_screen.dart to make it full width
- [x] Update instructionText fontSize in video_kyc_style.dart from 10 to 8 for lower font size


# TODO List

- [x] Add left padding to service texts in Services module to prevent text from going outside containers for categories: Accounts, Loans, Cards, Payment, Digital Banking, Security & Support, Popular Services.
- [x] Change text alignment to left for better visibility.
- [x] Change container alignment to centerLeft and add overflow handling.
- [x] Apply left padding to the entire container and align content to start.
- [x] Revert to center alignment with horizontal padding for text.

# TODO: Fix Loan and Settings Module Errors

## Import Path Fixes
- [x] Update import path in lib/pages/screens/forms/business_loan_form.dart to '../../../widgets/common_widgets.dart'
- [x] Update import path in lib/pages/screens/forms/car_loan_form.dart to '../../../widgets/common_widgets.dart'
- [x] Update import path in lib/pages/screens/forms/education_loan_form.dart to '../../../widgets/common_widgets.dart'
- [x] Update import path in lib/pages/screens/forms/gold_loan_form.dart to '../../../widgets/common_widgets.dart'
- [x] Update import path in lib/pages/screens/forms/home_loan_form.dart to '../../../widgets/common_widgets.dart'
- [x] Update import path in lib/pages/screens/forms/personal_loan_form.dart to '../../../widgets/common_widgets.dart'
- [x] Update import path in lib/pages/screens/active_loan_card.dart to '../../widgets/common_widgets.dart'
- [x] Update import path in lib/pages/screens/loan_calculator.dart to '../../widgets/common_widgets.dart'
- [ ] Update import path in lib/pages/screens/loan_cards.dart to '../../widgets/common_widgets.dart'

## Unused Import Removals
- [ ] Remove unused import 'forms/personal_loan_form.dart' from lib/pages/screens/loan_products.dart
- [ ] Remove unused import 'forms/home_loan_form.dart' from lib/pages/screens/loan_products.dart
- [ ] Remove unused import 'forms/car_loan_form.dart' from lib/pages/screens/loan_products.dart
- [ ] Remove unused import 'forms/education_loan_form.dart' from lib/pages/screens/loan_products.dart
- [ ] Remove unused import 'forms/business_loan_form.dart' from lib/pages/screens/loan_products.dart
- [ ] Remove unused import 'forms/gold_loan_form.dart' from lib/pages/screens/loan_products.dart
- [ ] Remove unused import 'loan_products.dart' from lib/pages/screens/loan_dashboard.dart

## Verification
- [ ] Run flutter analyze to verify all errors are resolved

