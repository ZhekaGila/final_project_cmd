import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/product/product_card.dart';
import '../../widgets/product/product_card_type.dart';
import '../../../data/models/product_model.dart';
import '../../providers/favorites_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: SafeArea(
        child: favoritesAsync.when(
          data: (favorites) {
            if (favorites.isEmpty) {
              return const Center(child: Text('No favorites yet'));
            }

            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];

                final item = ProductModel(
                  id: favorite.id,
                  title: favorite.title,
                  price: favorite.price,
                  description: favorite.description,
                  category: favorite.category,
                  image: favorite.image,
                );

                return ProductCard(
                  product: item,
                  onTap: () {
                    context.push('/product', extra: item);
                  },
                  type: ProductCardType.list,
                );
              },
            );
          },
          error: (error, stack) {
            return Center(child: Text(error.toString()));
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
