import 'package:data/data.dart';

abstract class RemoteDataSource {
  Future<List<ProductModel>> getCoffees();
}
