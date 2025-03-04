// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideoModel {
  String? HighlightId;

  String? Hightlightvideo;

  String? time;
  String? userId;
  VideoModel({
    this.HighlightId,
    this.Hightlightvideo,
    this.time,
    this.userId,
  });

  VideoModel copyWith({
    String? HighlightId,
    String? Hightlightvideo,
    String? time,
    String? userId,
  }) {
    return VideoModel(
      HighlightId: HighlightId ?? this.HighlightId,
      Hightlightvideo: Hightlightvideo ?? this.Hightlightvideo,
      time: time ?? this.time,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'HighlightId': HighlightId,
      'Hightlightvideo': Hightlightvideo,
      'time': time,
      'userId': userId,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      HighlightId:
          map['HighlightId'] != null ? map['HighlightId'] as String : null,
      Hightlightvideo: map['Hightlightvideo'] != null
          ? map['Hightlightvideo'] as String
          : null,
      time: map['time'] != null ? map['time'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(HighlightId: $HighlightId, Hightlightvideo: $Hightlightvideo, time: $time, userId: $userId)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.HighlightId == HighlightId &&
        other.Hightlightvideo == Hightlightvideo &&
        other.time == time &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return HighlightId.hashCode ^
        Hightlightvideo.hashCode ^
        time.hashCode ^
        userId.hashCode;
  }
}
