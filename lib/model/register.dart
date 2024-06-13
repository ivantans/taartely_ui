class RegisterResponse {
  late final bool success;
  late final String message;

  RegisterResponse({required this.success, required this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json["success"],
      message: json["message"],
    );
  }
}
  