
class User {
  late final int id;
  late final String name;
  late final String email;
  late final String roles;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roles: json["roles"]);
  }
}

class LoginResponse {
  late final bool success;
  late final String message;
  late final User? user;
  late final String? token;

  LoginResponse({
    required this.success,
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        success: json["success"],
        message: json["message"],
        user: json["user"] != null?User.fromJson(json["user"]):null,
        token: json["token"]);
  }
}
