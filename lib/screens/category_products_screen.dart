import 'package:flutter/material.dart';
import 'package:shop/models/product_category.dart';
import 'package:shop/services/api_service.dart';
import 'package:shop/widgets/product_card.dart';

import '../models/product.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  CategoryProductsScreen({required this.categoryId, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: FutureBuilder<List<Product>>(
        future: ApiService().getProductsByCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return ProductCard(product: product);
              },
            );
          }
        },
      ),
    );
  }
}
