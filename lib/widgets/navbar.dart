// import 'package:flutter/material.dart';
// import 'package:lucide_icons/lucide_icons.dart';

// class Navbar extends StatefulWidget {
//   const Navbar({super.key});

//   @override
//   // State<Navbar> createState() => _NavbarState();
// }

// class _NavbarState extends State<Navbar> {
//   bool mobileMenuOpen = false;

//   final List<Map<String, dynamic>> menuItems = [
//     {
//       "name": "Dashboard",
//       "icon": LucideIcons.layoutDashboard,
//       "path": "/client",
//     },
//     {
//       "name": "My Account",
//       "icon": LucideIcons.user,
//       "path": "/client/myaccount",
//     },
//     {
//       "name": "Deposit",
//       "icon": LucideIcons.creditCard,
//       "path": "/client/deposit",
//     },
//     {"name": "Loan", "icon": LucideIcons.dollarSign, "path": "/client/loan"},
//     {
//       "name": "Money Transfer",
//       "icon": LucideIcons.repeat,
//       "path": "/pages/money_transfer_page",
//     },
//     {
//       "name": "Investment",
//       "icon": LucideIcons.trendingUp,
//       "path": "/client/investment",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           color: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // 🔹 Logo + Name
//               Row(
//                 children: [
//                   Image.asset("assets/logo.png", height: 30),
//                   const SizedBox(width: 6),
//                   const Text(
//                     "NeoBank",
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),

//               // 🔍 Search Bar (hidden on narrow screens)
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 20),
//                   height: 36,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search users, transactions...",
//                       prefixIcon: const Icon(Icons.search, size: 18),
//                       contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // 🔔 Notification + Profile + Menu
//               Row(
//                 children: [
//                   Stack(
//                     children: [
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           LucideIcons.bell,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       Positioned(
//                         right: 8,
//                         top: 8,
//                         child: Container(
//                           width: 8,
//                           height: 8,
//                           decoration: const BoxDecoration(
//                             color: Colors.red,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 10),
//                   GestureDetector(
//                     onTap: () =>
//                         Navigator.pushNamed(context, "/client/profile"),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         children: const [
//                           Icon(
//                             LucideIcons.user,
//                             color: Colors.redAccent,
//                             size: 18,
//                           ),
//                           SizedBox(width: 6),
//                           Text(
//                             "Amit Rajput",
//                             style: TextStyle(fontWeight: FontWeight.w600),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(LucideIcons.menu, color: Colors.black87),
//                     onPressed: () =>
//                         setState(() => mobileMenuOpen = !mobileMenuOpen),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),

//         // ✅ SECONDARY NAV (desktop)
//         if (!mobileMenuOpen)
//           Container(
//             color: Colors.grey.shade100,
//             height: 48,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: menuItems.length,
//               itemBuilder: (context, index) {
//                 final item = menuItems[index];
//                 return InkWell(
//                   onTap: () => Navigator.pushNamed(context, item["path"]),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     alignment: Alignment.center,
//                     child: Row(
//                       children: [
//                         Icon(item["icon"], size: 18, color: Colors.black87),
//                         const SizedBox(width: 6),
//                         Text(
//                           item["name"],
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//         // ✅ MOBILE COLLAPSIBLE MENU
//         if (mobileMenuOpen)
//           Container(
//             color: Colors.white,
//             child: Column(
//               children: menuItems.map((item) {
//                 return ListTile(
//                   leading: Icon(item["icon"]),
//                   title: Text(item["name"]),
//                   onTap: () {
//                     Navigator.pushNamed(context, item["path"]);
//                     setState(() => mobileMenuOpen = false);
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//       ],
//     );
//   }
// }
