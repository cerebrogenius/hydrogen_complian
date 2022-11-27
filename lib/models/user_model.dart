import 'package:hydrogen_complian/repo/http_repo.dart';

class UserModel {
  final String name;
  final String email;
  final int? id;
  final int? secretCode;
  final DateTime? createdAt;

  UserModel(
      {this.id,
      this.secretCode,
      this.createdAt,
      required this.name,
      required this.email});
  Map<String, dynamic> toJson() {
    return {"name": name, "email": email};
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    UserModel userModel = UserModel(
        name: json['name'],
        email: json['email'],
        id: json['id'],
        secretCode: json['secret_code'],
        createdAt: DateTime.parse(json['created_at'])  );
    return userModel;
  }
}
