// ignore_for_file: non_constant_identifier_names

// ignore: camel_case_types

// ignore: camel_case_types
class itme {
  final int? id;
  final String? Name;
  final String? Type;
  final String? Address;
  final String? Images;
  final double? price;

  itme({
    this.id,
    required this.Name,
    required this.Type,
    required this.price,
    required this.Address,
    required this.Images,
  });

  Map<String, dynamic> ToMap() {
    return {
      "id": id,
      'Name': Name,
      'Type': Type,
      'price': price,
      'Address': Address,
      'Images': Images,
    };
  }
}
