import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/cart_provider.dart';
import '../../../data/models/product_model.dart';

import 'package:drift/drift.dart' as drift;

import '../../../data/services/local/app_database.dart';
import '../../providers/favorites_provider.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product.image, height: 250)),

            const SizedBox(height: 20),

            Text(
              product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Text('\$${product.price}', style: const TextStyle(fontSize: 20)),

            const SizedBox(height: 20),

            Text(product.description),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).addToCart(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final db = ref.read(databaseProvider);

                  await db.insertFavorite(
                    FavoritesCompanion(
                      id: drift.Value(product.id),
                      title: drift.Value(product.title),
                      price: drift.Value(product.price),
                      image: drift.Value(product.image),
                    ),
                  );

                  ref.invalidate(favoritesProvider);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to favorites')),
                  );
                },
                child: const Text('Add to Favorites'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
