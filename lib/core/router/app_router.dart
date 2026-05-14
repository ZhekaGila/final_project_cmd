import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/screens/cart/cart_screen.dart';
import '../../data/models/product_model.dart';
import '../../ui/screens/home/home_screen.dart';
import '../../ui/screens/product/product_details_screen.dart';
import '../../ui/screens/favorites/favorites_screen.dart';
import '../../ui/screens/settings/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

    GoRoute(
      path: '/product',
      builder: (context, state) {
        final product = state.extra as ProductModel;
        return ProductDetailsScreen(product: product);
      },
    ),

    GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),

    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),

    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
