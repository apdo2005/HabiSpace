import '../../domain/entity/agent_user_entity.dart';

class AgentUserModel extends AgentUserEntity {
  AgentUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.location,
    super.phone,
  });

  factory AgentUserModel.fromJson(Map<String, dynamic> json) => AgentUserModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    role: json['role'],
    location: json['location'],
    phone: json['phone'],
  );
}