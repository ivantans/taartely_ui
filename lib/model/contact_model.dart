class Contact {
  final int id;
  final String name;
  final String userAddress;
  final String userPhoneNumber;

  Contact({
    required this.id,
    required this.name,
    required this.userAddress,
    required this.userPhoneNumber,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json["name"],
      userAddress: json['user_address'],
      userPhoneNumber: json['user_phone_number'],
    );
  }
}
