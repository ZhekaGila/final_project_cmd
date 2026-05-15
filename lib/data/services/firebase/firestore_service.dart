import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveOrder(List<ProductModel> products) async {
    final total = products.fold<double>(0, (sum, item) => sum + item.price);

    await _firestore.collection('orders').add({
      'date': DateTime.now().toIso8601String(),
      'total': total,
      'items': products
          .map(
            (p) => {
              'id': p.id,
              'title': p.title,
              'price': p.price,
              'image': p.image,
              'category': p.category,
              'description': p.description,
            },
          )
          .toList(),
    });
  }

  Stream<QuerySnapshot> getOrders() {
    return _firestore.collection('orders').snapshots();
  }
}
