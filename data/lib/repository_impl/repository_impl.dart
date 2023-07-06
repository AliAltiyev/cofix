import 'package:data/data.dart';

final class ProductRepositoryImpl implements ProductRepository {
  final RemoteDataSource _remoteDataSource;

  ProductRepositoryImpl(
    RemoteDataSource remoteDataSource,
  ) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<Product>> fetchProducts() async {
    final List<ProductModel> data = await _remoteDataSource.getCoffees();
    return data
        .map((model) => ProductMapper.toEntity(model))
        .toList()
        .cast<Product>();
  }

  @override
  Future<Product> fetchProductById(int productId) async {
    final ProductModel productModel =
        await _remoteDataSource.getCoffeeById(productId);
    return ProductMapper.toEntity(productModel);
  }
}
