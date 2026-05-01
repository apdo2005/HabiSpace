class AgentUserEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? location;
  final String? phone;

  AgentUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.location,
    this.phone,
  });
}