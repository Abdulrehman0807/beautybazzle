class AppointmentModel {
  final String appointmentId;
  final String salonId;
  final String salonName;
  final String salonImage;
  final String userId;
  final String userName;
  final DateTime date;
  final Map<String, dynamic> slot;
  final String status;
  final DateTime createdAt;
  final List<String> services;
  final double totalPrice;

  AppointmentModel({
    required this.appointmentId,
    required this.salonId,
    required this.salonName,
    required this.salonImage,
    required this.userId,
    required this.userName,
    required this.date,
    required this.slot,
    required this.status,
    required this.createdAt,
    required this.services,
    required this.totalPrice,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      appointmentId: map['appointmentId'] as String,
      salonId: map['salonId'] as String,
      salonName: map['salonName'] as String,
      salonImage: map['salonImage'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      slot: Map<String, dynamic>.from(map['slot'] as Map),
      status: map['status'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      services: List<String>.from(map['services'] as List),
      totalPrice: (map['totalPrice'] as num).toDouble(),
    );
  }
}
