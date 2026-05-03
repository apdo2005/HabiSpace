class ProfileEntity {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String? image;

  ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
    required this.phone,
    this.image,
  });
}
