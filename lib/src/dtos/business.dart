class BusinessDto {
  final String name;
  final String email;
  final String owner;
  final int coastPerMinute;

  BusinessDto({
    required this.name,
    required this.email,
    required this.owner,
    required this.coastPerMinute,
  });

  factory BusinessDto.fromJson(Map<String, dynamic> json) {
    return BusinessDto(
      name: json["name"],
      email: json["email"],
      owner: json["owner"],
      coastPerMinute: json["coastPerMinute"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "owner": owner,
      "coastPerMinute": coastPerMinute,
    };
  }
}

