import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product_model.dart';

class CartNotifier extends StateNotifier<List<ProductModel>> {
  CartNotifier() : super([]);

  void addToCart(ProductModel product) {
    state = [...state, product];
  }

  void removeFromCart(ProductModel product) {
    state = state.where((item) => item.id != product.id).toList();
  }

  double get totalPrice {
    return state.fold(0, (sum, item) => sum + item.price);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<ProductModel>>(
  (ref) => CartNotifier(),
);
