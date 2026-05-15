import 'package:flutter/material.dart';
import '../../widgets/product/product_card.dart';
import '../../widgets/product/product_card_type.dart';

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
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return ListTile(
                  leading: Image.network(item['image']),
                  title: Text(item['title']),
                  subtitle: Text('\$${item['price']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
