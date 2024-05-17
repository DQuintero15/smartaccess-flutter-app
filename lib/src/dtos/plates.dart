class LicensePlateDto {
  final String id;
  final String plate;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;

  LicensePlateDto({
    required this.id,
    required this.plate,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory LicensePlateDto.fromJson(Map<String, dynamic> json) {
    return LicensePlateDto(
      id: json['id'],
      plate: json['plate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plate': plate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}

class CheckInDto {
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
  final LicensePlateDto licensePlate;

  CheckInDto({
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

  factory CheckInDto.fromJson(Map<String, dynamic> json) {
    return CheckInDto(
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
      licensePlate: LicensePlateDto.fromJson(json['LicensePlate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessId': businessId,
      'licensePlateId': licensePlateId,
      'checkInSource': checkInSource,
      'checkOutSource': checkOutSource,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'checkOut': checkOut,
      'minutesParked': minutesParked,
      'amount': amount,
      'paid': paid,
      'LicensePlate': licensePlate.toJson(),
    };
  }
}
