// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SpecialistModel {
  String? specialistId;
  String? specialistName;
  String? specialistServiceName;
  String? specialistPic;
  String? time;
  String? userId;

  // Constructor
  SpecialistModel({
    this.specialistId,
    this.specialistName,
    this.specialistServiceName,
    this.specialistPic,
    this.time,
    this.userId,
  });

  SpecialistModel copyWith({
    String? specialistId,
    String? specialistName,
    String? specialistServiceName,
    String? specialistPic,
    String? time,
    String? userId,
  }) {
    return SpecialistModel(
      specialistId: specialistId ?? this.specialistId,
      specialistName: specialistName ?? this.specialistName,
      specialistServiceName:
          specialistServiceName ?? this.specialistServiceName,
      specialistPic: specialistPic ?? this.specialistPic,
      time: time ?? this.time,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'specialistId': specialistId,
      'specialistName': specialistName,
      'specialistServiceName': specialistServiceName,
      'specialistPic': specialistPic,
      'time': time,
      'userId': userId,
    };
  }

  factory SpecialistModel.fromMap(Map<String, dynamic> map) {
    return SpecialistModel(
      specialistId:
          map['specialistId'] != null ? map['specialistId'] as String : null,
      specialistName: map['specialistName'] != null
          ? map['specialistName'] as String
          : null,
      specialistServiceName: map['specialistServiceName'] != null
          ? map['specialistServiceName'] as String
          : null,
      specialistPic:
          map['specialistPic'] != null ? map['specialistPic'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecialistModel.fromJson(String source) =>
      SpecialistModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SpecialistModel(specialistId: $specialistId, specialistName: $specialistName, specialistServiceName: $specialistServiceName, specialistPic: $specialistPic, time: $time, userId: $userId)';
  }

  @override
  bool operator ==(covariant SpecialistModel other) {
    if (identical(this, other)) return true;

    return other.specialistId == specialistId &&
        other.specialistName == specialistName &&
        other.specialistServiceName == specialistServiceName &&
        other.specialistPic == specialistPic &&
        other.time == time &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return specialistId.hashCode ^
        specialistName.hashCode ^
        specialistServiceName.hashCode ^
        specialistPic.hashCode ^
        time.hashCode ^
        userId.hashCode;
  }
}
