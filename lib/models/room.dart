
class Room {
  final int? id;             
  final int roomNumber;      
  final String roomName;    
  final String description; 
  final String roomType;   
  final int capacity;        
  final double pricePerNight; 
  final String image;       
  Room({
    this.id,
    required this.roomNumber,
    required this.roomName,
    required this.description,
    required this.roomType,
    required this.capacity,
    required this.pricePerNight,
    required this.image,
  });

  /// تحويل بيانات الغرفة إلى Map لتسهيل الإدراج في قاعدة البيانات.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'roomName': roomName,
      'description': description,
      'roomType': roomType,
      'capacity': capacity,
      'pricePerNight': pricePerNight,
      'image': image,
    };
  }

  /// إنشاء كائن Room من Map (مثلاً عند استرجاع البيانات من قاعدة البيانات).
  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'],
      roomNumber: map['roomNumber'],
      roomName: map['roomName'],
      description: map['description'],
      roomType: map['roomType'],
      capacity: map['capacity'],
      pricePerNight: map['pricePerNight'],
      image: map['image'],
    );
  }
}
