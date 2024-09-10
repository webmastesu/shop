import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Colors.orange;
  static const Color textColor = Colors.black87;
  static const Color priceColor = Colors.green;
}

class AppTextStyles {
  static const TextStyle productTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle productPrice = TextStyle(
    color: AppColors.priceColor,
    fontSize: 14,
  );
}