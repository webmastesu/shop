import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop/screens/fav_screen.dart';
import 'package:shop/services/api_service.dart';
import 'package:shop/widgets/product_card.dart';
import 'package:shop/widgets/custom_app_bar.dart';
import 'package:shop/models/product.dart';
import 'package:shop/screens/product_description_screen.dart';
import 'package:shop/screens/category_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<String> _sliderImages = [];
  String _searchQuery = '';
  bool _isLoadingSlider = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _fetchSliderImages();
  }

  void _fetchProducts() async {
    try {
      List<Product> products = await ApiService().getRecentProducts();
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
      });
    } catch (error) {
      // Handle error
    }
  }

  void _fetchSliderImages() async {
    try {
      List<String> images = await ApiService().getSliderImages();
      setState(() {
        _sliderImages = images;
        _isLoadingSlider = false;
      });
    } catch (error) {
      // Handle error
      setState(() {
        _isLoadingSlider = false;
      });
    }
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'MingalarShop',
        onSearch: _handleSearch,
      ),
      body: SingleChildScrollView(  // Add SingleChildScrollView
        child: Column(
          children: [
            _isLoadingSlider ? _buildLoading() : _buildSlider(),
            SizedBox(height: 16),  // Add some spacing if needed
            _filteredProducts.isEmpty
                ? _buildLoading()
                : Padding(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                shrinkWrap: true,  // Add this to limit the height
                physics: NeverScrollableScrollPhysics(),  // Disable scrolling inside GridView
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  Product product = _filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDescriptionScreen(product: product),
                        ),
                      );
                    },
                    child: ProductCard(product: product),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildGlassBottomNavBar(context),
    );
  }

  Widget _buildSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 16 / 9,
        initialPage: 0,
      ),
      items: _sliderImages.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Lottie.asset(
        'assets/lottie/loading_animation.json',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildGlassBottomNavBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.pinkAccent),
                  onPressed: () {
                    _fetchProducts(); // Re-fetch or refresh the product list
                  },
                ),
                IconButton(
                  icon: Icon(Icons.category, color: Colors.pinkAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.pinkAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoriteScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person, color: Colors.pinkAccent),
                  onPressed: () {
                    // Handle Profile tap
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
