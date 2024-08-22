import '../../domain/entities/entities.dart';

class UserModel extends User {
  const UserModel({
    super.id = '',
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
    );
  }
}