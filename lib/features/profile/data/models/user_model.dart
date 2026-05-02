import 'package:habispace/features/profile/domain/entities/Profile_Entity.dart';

class UserModel extends ProfileEntity{
  UserModel({
    required super.id,
    required super.location,
    required super.email,
    required super.name,
    required super.phone,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? 0,
        location: json["location"] ?? '',
        email: json["email"] ?? '',
        name: json["name"] ?? '',
        phone: json["phone"] ?? '',
      );
      
  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "email": email,
        "name": name,
        "phone": phone,
      };
}