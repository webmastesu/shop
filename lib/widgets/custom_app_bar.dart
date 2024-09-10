// import 'package:flutter/material.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Function(String) onSearch;
//
//   CustomAppBar({required this.title, required this.onSearch});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.white,
//       title: Row(
//         children: [
//           Expanded(
//             child: Container(
//               height: 40,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search products...',
//                   prefixIcon: Icon(Icons.search, color: Colors.grey),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 ),
//                 onChanged: onSearch,
//               ),
//             ),
//           ),
//           SizedBox(width: 10),
//           IconButton(
//             icon: Icon(Icons.shopping_cart, color: Colors.black),
//             onPressed: () {
//               // TODO: Implement shopping cart functionality
//             },
//           ),
//         ],
//       ),
//       leading: IconButton(
//         icon: Icon(Icons.menu, color: Colors.black),
//         onPressed: () {
//           // TODO: Implement menu functionality
//         },
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }

import 'dart:ui'; // Import for the ImageFilter

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(String) onSearch;

  CustomAppBar({required this.title, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Adjust the opacity for the frosted effect
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    onChanged: onSearch,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              // TODO: Implement shopping cart functionality
            },
          ),
        ],
      ),
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          // TODO: Implement menu functionality
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
