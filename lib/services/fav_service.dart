import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:shop/models/product.dart';

class FavoriteService {
  static const String _key = 'favorites';

  static Future<List<Product>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_key);
    if (favoritesJson == null) return [];
    final List<dynamic> favoritesList = json.decode(favoritesJson);
    return favoritesList.map((item) => Product.fromJson(item)).toList();
  }

  static Future<void> addFavorite(Product product) async {
    final favorites = await getFavorites();
    if (!favorites.any((fav) => fav.id == product.id)) {
      favorites.add(product);
      await _saveFavorites(favorites);
    }
  }

  static Future<void> removeFavorite(String productId) async {
    final favorites = await getFavorites();
    favorites.removeWhere((fav) => fav.id == productId);
    await _saveFavorites(favorites);
  }

  static Future<bool> isFavorite(String productId) async {
    final favorites = await getFavorites();
    return favorites.any((fav) => fav.id == productId);
  }

  static Future<void> _saveFavorites(List<Product> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final String favoritesJson = json.encode(favorites.map((fav) => fav.toJson()).toList());
    await prefs.setString(_key, favoritesJson);
  }
}