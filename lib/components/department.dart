import 'package:flutter/material.dart';
import 'package:situp_test/services/api_service.dart';
import 'package:situp_test/datamodel/shop_model.dart';

class DepartmentList extends StatefulWidget {
  final void Function(String departmentId, String departmentName)
      onDepartmentSelected;

  const DepartmentList({super.key, required this.onDepartmentSelected});

  @override
  State<DepartmentList> createState() => _DepartmentListState();
}

class _DepartmentListState extends State<DepartmentList> {
  late Future<List<Department>> _departmentsFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _departmentsFuture = _apiService.fetchDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Department>>(
      future: _departmentsFuture,
      builder:
          (BuildContext context, AsyncSnapshot<List<Department>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final departments = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: departments.map((department) {
                return GestureDetector(
                  onTap: () {
                    widget.onDepartmentSelected(department.id, department.name);
                  },
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.tealAccent, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: Colors.tealAccent[700],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                department.name,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: Image.network(
                                department.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
        return const Center(child: Text('Something went wrong'));
      },
    );
  }
}
