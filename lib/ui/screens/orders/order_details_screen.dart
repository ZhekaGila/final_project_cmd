import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/product/product_card.dart';
import '../../widgets/product/product_card_type.dart';
import '../../../data/models/product_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final items = order['items'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Total: \$${order['total']}',
              style: const TextStyle(fontSize: 20),
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = ProductModel.fromJson(items[index]);

                return ProductCard(
                  product: item,
                  onTap: () {
                    context.push('/product', extra: item);
                  },
                  type: ProductCardType.list,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            ),
          ),
        ],
      ),
    );
  }
}
