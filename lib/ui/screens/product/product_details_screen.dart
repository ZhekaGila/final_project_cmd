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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),

                child: Image.network(
                  product.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const SizedBox(
                      height: 250,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },

                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 250,
                      child: Center(child: Icon(Icons.error)),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
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
                        description: drift.Value(product.description),
                        category: drift.Value(product.category),
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
      ),
    );
  }
}
