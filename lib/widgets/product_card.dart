// import 'package:flutter/material.dart';
// import 'package:shop/models/product.dart';
// import 'package:shop/config/app_config.dart';
// import 'package:shop/screens/product_description_screen.dart';
//
//
// import '../screens/fav_screen.dart';
// import '../services/fav_service.dart';
//
// class ProductCard extends StatefulWidget {
//   final Product product;
//
//   const ProductCard({Key? key, required this.product}) : super(key: key);
//
//   @override
//   _ProductCardState createState() => _ProductCardState();
// }
//
// class _ProductCardState extends State<ProductCard> {
//   late Future<bool> _isFavoriteFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _isFavoriteFuture = FavoriteService.isFavorite(widget.product.id);
//   }
//
//   Future<void> _toggleFavorite() async {
//     bool currentFavoriteStatus = await _isFavoriteFuture;
//     setState(() {
//       if (currentFavoriteStatus) {
//         FavoriteService.removeFavorite(widget.product.id);
//       } else {
//         FavoriteService.addFavorite(widget.product);
//       }
//       _isFavoriteFuture = Future.value(!currentFavoriteStatus);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDescriptionScreen(product: widget.product),
//           ),
//         );
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         elevation: 4,
//         margin: EdgeInsets.all(8),
//         clipBehavior: Clip.antiAlias,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Image.network(
//                       '${AppConfig.IMAGE_BASE_URL}/${widget.product.imageUrl}',
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, progress) {
//                         return progress == null
//                             ? child
//                             : Center(child: CircularProgressIndicator());
//                       },
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: FutureBuilder<bool>(
//                         future: _isFavoriteFuture,
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState == ConnectionState.waiting) {
//                             return CircularProgressIndicator();
//                           }
//                           final isFavorite = snapshot.data ?? false;
//                           return GestureDetector(
//                             onTap: () {
//                               _toggleFavorite();
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => FavoriteScreen()),
//                               );
//                             },
//                             child: Icon(
//                               isFavorite ? Icons.favorite : Icons.favorite_border,
//                               color: isFavorite ? Colors.red : Colors.white,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.product.name,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     '${widget.product.price} ${widget.product.currencyCode}',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui'; // Import for the ImageFilter

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/config/app_config.dart';
import 'package:shop/screens/product_description_screen.dart';
import '../screens/fav_screen.dart';
import '../services/fav_service.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late Future<bool> _isFavoriteFuture;

  @override
  void initState() {
    super.initState();
    _isFavoriteFuture = FavoriteService.isFavorite(widget.product.id);
  }

  Future<void> _toggleFavorite() async {
    bool currentFavoriteStatus = await _isFavoriteFuture;
    setState(() {
      if (currentFavoriteStatus) {
        FavoriteService.removeFavorite(widget.product.id);
      } else {
        FavoriteService.addFavorite(widget.product);
      }
      _isFavoriteFuture = Future.value(!currentFavoriteStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDescriptionScreen(product: widget.product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        margin: EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      '${AppConfig.IMAGE_BASE_URL}/${widget.product.imageUrl}',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<bool>(
                        future: _isFavoriteFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          final isFavorite = snapshot.data ?? false;
                          return GestureDetector(
                            onTap: () {
                              _toggleFavorite();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FavoriteScreen()),
                              );
                            },
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.pinkAccent : Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Apply frosted glass effect only to the product details
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withOpacity(0.6),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        maxLines: 1, // Limit to one line
                        overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CustomFont',
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${widget.product.price} ${widget.product.currencyCode}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CustomFont',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

