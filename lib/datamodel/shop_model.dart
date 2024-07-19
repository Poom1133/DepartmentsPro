class Department {
  final String id;
  final String name;
  final String imageUrl;

  Department({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  // from JSON
  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  // to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String desc;
  final String price;
  final String type;
  final String departmentId;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.desc,
    required this.price,
    required this.type,
    required this.departmentId,
  });

  // from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      desc: json['desc'],
      price: json['price'],
      type: json['type'],
      departmentId: json['departmentId'],
    );
  }

  // to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'desc': desc,
      'price': price,
      'type': type,
      'departmentId': departmentId,
    };
  }
}
