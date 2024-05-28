import 'dart:ffi';

class Detection {
  final String plateNumber;
  final Double totalToPay;

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
