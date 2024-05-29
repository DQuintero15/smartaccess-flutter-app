class Detection {
  final String plateNumber;
  final double totalToPay;

  Detection({
    required this.plateNumber,
    required this.totalToPay,
  });

  factory Detection.fromJson(Map<String, dynamic> json) {
    return Detection(
      plateNumber: json["plate_number"],
      totalToPay: json["total_to_pay"],
    );
  }
}

class AppDetection {
  final double minutesParked;
  final double totalToPay;

  AppDetection({
    required this.minutesParked,
    required this.totalToPay,
  });

  factory AppDetection.fromJson(Map<String, dynamic> json) {
    return AppDetection(
      minutesParked: json["minutes_parked"],
      totalToPay: json["total_to_pay"],
    );
  }
}
