// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RecentWorkModel {
  String? RecentworkId;
  String? RecentworkPic;
  String? time;
  String? userId;
  RecentWorkModel({
    this.RecentworkId,
    this.RecentworkPic,
    this.time,
    this.userId,
  });

  RecentWorkModel copyWith({
    String? RecentworkId,
    String? RecentworkPic,
    String? time,
    String? userId,
  }) {
    return RecentWorkModel(
      RecentworkId: RecentworkId ?? this.RecentworkId,
      RecentworkPic: RecentworkPic ?? this.RecentworkPic,
      time: time ?? this.time,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'RecentworkId': RecentworkId,
      'RecentworkPic': RecentworkPic,
      'time': time,
      'userId': userId,
    };
  }

  factory RecentWorkModel.fromMap(Map<String, dynamic> map) {
    return RecentWorkModel(
      RecentworkId:
          map['RecentworkId'] != null ? map['RecentworkId'] as String : null,
      RecentworkPic:
          map['RecentworkPic'] != null ? map['RecentworkPic'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentWorkModel.fromJson(String source) =>
      RecentWorkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RecentWorkModel(RecentworkId: $RecentworkId, RecentworkPic: $RecentworkPic, time: $time, userId: $userId)';
  }

  @override
  bool operator ==(covariant RecentWorkModel other) {
    if (identical(this, other)) return true;

    return other.RecentworkId == RecentworkId &&
        other.RecentworkPic == RecentworkPic &&
        other.time == time &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return RecentworkId.hashCode ^
        RecentworkPic.hashCode ^
        time.hashCode ^
        userId.hashCode;
  }
}
