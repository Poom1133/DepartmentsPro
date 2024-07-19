import 'package:dio/dio.dart';
import 'package:situp_test/datamodel/shop_model.dart';

class ApiService {
  final Dio _dio;

  // Default constructor
  ApiService([Dio? dio])
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: "https://659f86b15023b02bfe89c737.mockapi.io/",
            ));

  Future<List<Department>> fetchDepartments() async {
    try {
      final response = await _dio.get('/api/v1/departments');
      return (response.data as List)
          .map((department) => Department.fromJson(department))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to load departments: ${e.message}');
    }
  }

  Future<List<Product>> fetchProducts(String departmentId) async {
    try {
      final response =
          await _dio.get('/api/v1/departments/$departmentId/products');
      return (response.data as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to load products: ${e.message}');
    }
  }
}
