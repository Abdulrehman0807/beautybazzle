// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SalonSlot {
  final String slotId;
  final String salonId;
  final String startTime;
  final String endTime;
  final bool isAvailable;
  final String day;
  final DateTime date;

  SalonSlot({
    required this.slotId,
    required this.salonId,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.day,
    required this.date,
  });

  // Convert to Map for Firestore

  SalonSlot copyWith({
    String? slotId,
    String? salonId,
    String? startTime,
    String? endTime,
    bool? isAvailable,
    String? day,
    DateTime? date,
  }) {
    return SalonSlot(
      slotId: slotId ?? this.slotId,
      salonId: salonId ?? this.salonId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAvailable: isAvailable ?? this.isAvailable,
      day: day ?? this.day,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slotId': slotId,
      'salonId': salonId,
      'startTime': startTime,
      'endTime': endTime,
      'isAvailable': isAvailable,
      'day': day,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory SalonSlot.fromMap(Map<String, dynamic> map) {
    return SalonSlot(
      slotId: map['slotId'] as String,
      salonId: map['salonId'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      isAvailable: map['isAvailable'] as bool,
      day: map['day'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory SalonSlot.fromJson(String source) =>
      SalonSlot.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SalonSlot(slotId: $slotId, salonId: $salonId, startTime: $startTime, endTime: $endTime, isAvailable: $isAvailable, day: $day, date: $date)';
  }

  @override
  bool operator ==(covariant SalonSlot other) {
    if (identical(this, other)) return true;

    return other.slotId == slotId &&
        other.salonId == salonId &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.isAvailable == isAvailable &&
        other.day == day &&
        other.date == date;
  }

  @override
  int get hashCode {
    return slotId.hashCode ^
        salonId.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        isAvailable.hashCode ^
        day.hashCode ^
        date.hashCode;
  }
}
