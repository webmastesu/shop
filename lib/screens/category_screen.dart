import 'package:flutter/material.dart';
import 'package:shop/services/api_service.dart';
import 'package:shop/models/product_category.dart';

import '../config/app_config.dart';
import 'category_products_screen.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: FutureBuilder<List<ProductCategory>>(
        future: ApiService().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ProductCategory category = snapshot.data![index];
                return ListTile(
                  leading: Image.network('${AppConfig.CATEGORY_IMAGE_BASE_URL}/${category.imageUrl}'),
                  title: Text(category.name),
                  subtitle: Text('${category.productCount} Products'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsScreen(categoryId: category.id, categoryName: category.name),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
