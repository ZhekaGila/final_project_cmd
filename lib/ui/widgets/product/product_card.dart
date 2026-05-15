import 'package:flutter/material.dart';
import 'product_grid_card.dart';
import 'product_list_card.dart';
import 'product_cart_card.dart';
import 'product_card_type.dart';
import '../../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final ProductCardType type;
  final VoidCallback? onTrashTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.type,
    this.onTrashTap,
  });

  @override
  Widget build(BuildContext context) {
    if (type == ProductCardType.grid) {
      return ProductGridCard(product: product, onTap: onTap);
    } else if (type == ProductCardType.cart) {
      return ProductCartCard(
        product: product,
        onTap: onTap,
        onTrashTap: onTrashTap,
      );
    }
    return ProductListCard(product: product, onTap: onTap);
  }
}
