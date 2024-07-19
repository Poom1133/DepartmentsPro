import 'package:flutter/material.dart';
import 'package:situp_test/components/department.dart';
import 'package:situp_test/components/product.dart';
import 'package:situp_test/datamodel/shop_model.dart';
import 'package:situp_test/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  final ValueNotifier<List<Product>> _productsNotifier = ValueNotifier([]);
  String _selectedDepartmentName = '';

  @override
  void dispose() {
    _productsNotifier.dispose();
    super.dispose();
  }

  void _updateProducts(String departmentId, String departmentName) async {
    try {
      final products = await _apiService.fetchProducts(departmentId);
      _productsNotifier.value = products;
      setState(() {
        _selectedDepartmentName = departmentName;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load products: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: DepartmentList(onDepartmentSelected: _updateProducts),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder<List<Product>>(
                    valueListenable: _productsNotifier,
                    builder: (context, products, _) {
                      return ProductList(
                        products: products,
                        departmentName: _selectedDepartmentName,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
