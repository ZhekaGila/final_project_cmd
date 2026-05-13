import '../models/product_model.dart';
import '../services/api/product_service.dart';

class ProductRepository {
  final ProductService _service = ProductService.create();

  Future<List<ProductModel>> getProducts() async {
    final response = await _service.getProducts();

    final List data = response.body;

    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}
