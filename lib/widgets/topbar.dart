import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NavbarTop extends StatefulWidget implements PreferredSizeWidget {
  const NavbarTop({super.key});

  @override
  State<NavbarTop> createState() => _NavbarTopState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _NavbarTopState extends State<NavbarTop> {
  static const Color primaryRed = Color(0xFF900603);
  int notificationCount = 3;
  bool showSearchField = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.2,
      titleSpacing: 0,
      title: Row(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset('assets/logo.png', fit: BoxFit.contain),
          ),

          // Logo
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.35,
          //   height: MediaQuery.of(context).size.width * 0.35,
          //   child: Image.asset('assets/logo.png', fit: BoxFit.contain),
          // ),
          const SizedBox(width: 20),

          // Search icon or field
          Expanded(
            child: showSearchField
                ? Container(
                    height: 38,
                    margin: const EdgeInsets.only(right: 30),
                    child: TextField(
                      autofocus: true,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Search users, transactions.",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 18,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              showSearchField = false;
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 0.8,
                          ),
                        ),
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          showSearchField = true;
                        });
                      },
                    ),
                  ),
          ),

          // Notification bell
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    notificationCount = 0;
                  });
                },
                icon: const Icon(
                  LucideIcons.bell,
                  color: Colors.black87,
                  size: 22,
                ),
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: primaryRed,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "$notificationCount",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:lucide_icons/lucide_icons.dart';

// class NavbarTop extends StatefulWidget implements PreferredSizeWidget {
//   final String title;
//   final VoidCallback onToggleBalance;
//   final Icon icon;

//   const NavbarTop({
//     super.key,
//     this.title = "App Title", // default title
//     this.onToggleBalance = _defaultFunc, // default function
//     this.icon = const Icon(Icons.account_balance), // default icon
//   });

//   static void _defaultFunc() {}

//   @override
//   State<NavbarTop> createState() => _NavbarTopState();

//   @override
//   Size get preferredSize => const Size.fromHeight(60);
// }

// class _NavbarTopState extends State<NavbarTop> {
//   static const Color primaryRed = Color(0xFF900603);
//   int notificationCount = 3;
//   bool showSearchField = false;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0.2,
//       titleSpacing: 0,
//       title: Row(
//         children: [
//           // Logo image
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.35,
//             height: MediaQuery.of(context).size.width * 0.35,
//             child: Image.asset('assets/logo.png', fit: BoxFit.contain),
//           ),
//           const SizedBox(width: 20),

//           // Title text
//           Text(
//             widget.title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               color: Colors.black87,
//             ),
//           ),

//           const SizedBox(width: 20),

//           // Search icon or field
//           Expanded(
//             child: showSearchField
//                 ? Container(
//                     height: 38,
//                     margin: const EdgeInsets.only(right: 30),
//                     child: TextField(
//                       autofocus: true,
//                       onChanged: (value) {},
//                       decoration: InputDecoration(
//                         hintText: "Search users, transactions.",
//                         hintStyle: TextStyle(
//                           color: Colors.grey.shade500,
//                           fontSize: 14,
//                         ),
//                         prefixIcon: const Icon(
//                           Icons.search,
//                           size: 18,
//                           color: Colors.grey,
//                         ),
//                         suffixIcon: IconButton(
//                           icon: const Icon(
//                             Icons.close,
//                             color: Colors.grey,
//                             size: 20,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               showSearchField = false;
//                             });
//                           },
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                         filled: true,
//                         fillColor: Colors.grey.shade100,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                             color: Colors.grey.shade300,
//                             width: 0.8,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 : Align(
//                     alignment: Alignment.centerRight,
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.search,
//                         color: Colors.grey,
//                         size: 22,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           showSearchField = true;
//                         });
//                       },
//                     ),
//                   ),
//           ),

//           // Notification bell
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     notificationCount = 0;
//                   });
//                 },
//                 icon: const Icon(
//                   LucideIcons.bell,
//                   color: Colors.black87,
//                   size: 22,
//                 ),
//               ),
//               if (notificationCount > 0)
//                 Positioned(
//                   right: 6,
//                   top: 6,
//                   child: Container(
//                     padding: const EdgeInsets.all(3),
//                     decoration: const BoxDecoration(
//                       color: primaryRed,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(
//                       "$notificationCount",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),

//           // Optional custom icon (if needed)
//           widget.icon,
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:lucide_icons/lucide_icons.dart';

// class NavbarTop extends StatefulWidget implements PreferredSizeWidget {
//   const NavbarTop({super.key, required String title, required Null Function() onToggleBalance, required Icon icon});

//   @override
//   State<NavbarTop> createState() => _NavbarTopState();

//   @override
//   Size get preferredSize => const Size.fromHeight(60);
// }

// class _NavbarTopState extends State<NavbarTop> {
//   static const Color primaryRed = Color(0xFF900603);
//   int notificationCount = 3;
//   bool showSearchField = false; // controls whether search field is visible

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       //automaticallyImplyLeading: false,
//       elevation: 0.2,
//       titleSpacing: 0,
//       title: Row(
//         children: [
//           // Logo image
//           SizedBox(
//             width:
//                 MediaQuery.of(context).size.width * 0.35, // 25% of screen width
//             height: MediaQuery.of(context).size.width * 0.35,
//             child: Image.asset('assets/logo.png', fit: BoxFit.contain),
//           ),

//           const SizedBox(width: 20),

//           // Search icon or field
//           Expanded(
//             child: showSearchField
//                 ? Container(
//                     height: 38,
//                     margin: const EdgeInsets.only(right: 30),
//                     child: TextField(
//                       autofocus: true,
//                       onChanged: (value) {},
//                       decoration: InputDecoration(
//                         hintText: "Search users, transactions.",
//                         hintStyle: TextStyle(
//                           color: Colors.grey.shade500,
//                           fontSize: 14,
//                         ),
//                         prefixIcon: const Icon(
//                           Icons.search,
//                           size: 18,
//                           color: Colors.grey,
//                         ),
//                         suffixIcon: IconButton(
//                           icon: const Icon(
//                             Icons.close,
//                             color: Colors.grey,
//                             size: 20,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               showSearchField = false; // close the search field
//                             });
//                           },
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                         filled: true,
//                         fillColor: Colors.grey.shade100,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                             color: Colors.grey.shade300,
//                             width: 0.8,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 : Align(
//                     alignment: Alignment.centerRight,
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.search,
//                         color: Colors.grey,
//                         size: 22,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           showSearchField = true; // open the search field
//                         });
//                       },
//                     ),
//                   ),
//           ),

//           // Notification bell
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     notificationCount = 0;
//                   });
//                 },
//                 icon: const Icon(
//                   LucideIcons.bell,
//                   color: Colors.black87,
//                   size: 22,
//                 ),
//               ),
//               if (notificationCount > 0)
//                 Positioned(
//                   right: 6,
//                   top: 6,
//                   child: Container(
//                     padding: const EdgeInsets.all(3),
//                     decoration: const BoxDecoration(
//                       color: primaryRed,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(
//                       "$notificationCount",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
