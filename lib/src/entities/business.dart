class Business {
  final String name;
  final String email;
  final String owner;
  final int coastPerMinute;

  Business({
    required this.name,
    required this.email,
    required this.owner,
    required this.coastPerMinute,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json["name"],
      email: json["email"],
      owner: json["owner"],
      coastPerMinute: json["coastPerMinute"],
    );
  }
}

