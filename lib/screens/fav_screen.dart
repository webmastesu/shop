import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/fav_service.dart';
import 'package:shop/widgets/product_card.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<Product>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = FavoriteService.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorites yet'));
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ProductCard(product: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}