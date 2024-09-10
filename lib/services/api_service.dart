import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/config/app_config.dart';
import 'package:shop/models/product.dart';

import '../models/product_category.dart';

class ApiService {
  Future<List<Product>> getRecentProducts() async {
    final response = await http.get(
        Uri.parse('${AppConfig.API_BASE_URL}/api.php?get_recent'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductCategory>> getCategories() async {
    final response = await http.get(
        Uri.parse('${AppConfig.API_BASE_URL}/api.php?get_category'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => ProductCategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> getProductsByCategory(String categoryId) async {
    final response = await http.get(
        Uri.parse('${AppConfig.API_BASE_URL}/api.php?category_id=$categoryId'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  Future<List<String>> getSliderImages() async {
    final response = await http.get(Uri.parse('https://shop.darknessmm.com/slider.json'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => json['image_url'].toString()).toList();
    } else {
      throw Exception('Failed to load slider images');
    }
  }
}