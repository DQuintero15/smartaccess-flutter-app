class LicensePlate {
  final String id;
  final String plate;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;

  LicensePlate({
    required this.id,
    required this.plate,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory LicensePlate.fromJson(Map<String, dynamic> json) {
    return LicensePlate(
      id: json['id'],
      plate: json['plate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }
}

class CheckIn {
  final String businessId;
  final String licensePlateId;
  final String checkInSource;
  final String? checkOutSource;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? checkOut;
  final int minutesParked;
  final int amount;
  final bool paid;
  final LicensePlate licensePlate;

  CheckIn({
    required this.businessId,
    required this.licensePlateId,
    required this.checkInSource,
    this.checkOutSource,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.checkOut,
    required this.minutesParked,
    required this.amount,
    required this.paid,
    required this.licensePlate,
  });

  factory CheckIn.fromJson(Map<String, dynamic> json) {
    return CheckIn(
      businessId: json['businessId'],
      licensePlateId: json['licensePlateId'],
      checkInSource: json['checkInSource'],
      checkOutSource: json['checkOutSource'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      checkOut: json['checkOut'],
      minutesParked: json['minutesParked'],
      amount: json['amount'],
      paid: json['paid'],
      licensePlate: LicensePlate.fromJson(json['LicensePlate']),
    );
  }
}
