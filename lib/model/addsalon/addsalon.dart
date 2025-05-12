// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SalonModel {
  String? SalonName;
  String? SalonPicture;
  String? salonDescription;
  String? SalonId;
  String? time;
  String? userId;

  SalonModel({
    this.SalonName,
    this.SalonPicture,
    this.salonDescription,
    this.SalonId,
    this.time,
    this.userId,
  });

  SalonModel copyWith({
    String? SalonName,
    String? SalonPicture,
    String? salonDescription,
    String? salonAddress,
    String? SalonId,
    String? time,
    String? userId,
  }) {
    return SalonModel(
      SalonName: SalonName ?? this.SalonName,
      SalonPicture: SalonPicture ?? this.SalonPicture,
      salonDescription: salonDescription ?? this.salonDescription,
      SalonId: SalonId ?? this.SalonId,
      time: time ?? this.time,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'SalonName': SalonName,
      'SalonPicture': SalonPicture,
      'salonDescription': salonDescription,
      'SalonId': SalonId,
      'time': time,
      'userId': userId,
    };
  }

  factory SalonModel.fromMap(Map<String, dynamic> map) {
    return SalonModel(
      SalonName: map['SalonName'] != null ? map['SalonName'] as String : null,
      SalonPicture:
          map['SalonPicture'] != null ? map['SalonPicture'] as String : null,
      salonDescription: map['salonDescription'] != null
          ? map['salonDescription'] as String
          : null,
      SalonId: map['SalonId'] != null ? map['SalonId'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalonModel.fromJson(String source) =>
      SalonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SalonModel(SalonName: $SalonName, SalonPicture: $SalonPicture, salonDescription: $salonDescription, SalonId: $SalonId, time: $time, userId: $userId)';
  }

  @override
  bool operator ==(covariant SalonModel other) {
    if (identical(this, other)) return true;

    return other.SalonName == SalonName &&
        other.SalonPicture == SalonPicture &&
        other.salonDescription == salonDescription &&
        other.SalonId == SalonId &&
        other.time == time &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return SalonName.hashCode ^
        SalonPicture.hashCode ^
        salonDescription.hashCode ^
        SalonId.hashCode ^
        time.hashCode ^
        userId.hashCode;
  }
}
