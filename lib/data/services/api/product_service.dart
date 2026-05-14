import 'package:chopper/chopper.dart';

part 'product_service.chopper.dart';

@ChopperApi()
abstract class ProductService extends ChopperService {
  @GET(path: '/products')
  Future<Response> getProducts();

  static ProductService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://fakestoreapi.com'),
      services: [_$ProductService()],
      converter: const JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );

    return _$ProductService(client);
  }
}
