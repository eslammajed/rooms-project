// ignore_for_file: non_constant_identifier_names

// ignore: camel_case_types

class itme {
  final int? id;
  final String? Name;
  final String? Type;
  final int? Quantity;
  final String? Address;
  final String? Images;
  final String? Date;
  final String? Target;
  final double? price;

  itme( 
      {
      this.id,
      required this.Name,
      required this.Type,
      required this.Quantity,
      required this.price,
      required this.Address,
      required this.Images,
      required this.Date,
      required this.Target, 
      });


Map<String,dynamic> ToMap(){
  return {
    "id": id,
    'Name':Name ,
    'Type':Type,
    'Quantity':Quantity,
    'price':price,
    'Address':Address,
    'Images':Images,
    'Date':Date,
    'Target':Target,
  };
}
}


