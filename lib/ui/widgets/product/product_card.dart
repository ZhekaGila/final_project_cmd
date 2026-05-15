import 'package:flutter/material.dart';
import 'product_grid_card.dart';
import 'product_list_card.dart';
import 'product_card_type.dart';
import '../../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final ProductCardType type;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (type == ProductCardType.grid) {
      return ProductGridCard(product: product, onTap: onTap);
    }

    return ProductListCard(product: product, onTap: onTap);
  }
}
