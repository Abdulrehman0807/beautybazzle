// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideoModel {
  String? highlightId; // Renamed to follow camelCase convention
  String? highlightVideo; // Renamed for clarity
  String? thumbnailUrl; // Added for thumbnail URL (as you may want to use it separately)
  String? time;
  String? userId;

  VideoModel({
    this.highlightId,
    this.highlightVideo,
    this.thumbnailUrl, // Optional: You can store the thumbnail URL as well
    this.time,
    this.userId,
  });

  // Copy method to clone the object with modifications
  VideoModel copyWith({
    String? highlightId,
    String? highlightVideo,
    String? thumbnailUrl,
    String? time,
    String? userId,
  }) {
    return VideoModel(
      highlightId: highlightId ?? this.highlightId,
      highlightVideo: highlightVideo ?? this.highlightVideo,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      time: time ?? this.time,
      userId: userId ?? this.userId,
    );
  }

  // Convert this object into a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'highlightId': highlightId,
      'highlightVideo': highlightVideo,
      'thumbnailUrl': thumbnailUrl, // Storing the thumbnail URL here
      'time': time,
      'userId': userId,
    };
  }

  // Create a VideoModel instance from a map
  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      highlightId: map['highlightId'] != null ? map['highlightId'] as String : null,
      highlightVideo: map['highlightVideo'] != null ? map['highlightVideo'] as String : null,
      thumbnailUrl: map['thumbnailUrl'] != null ? map['thumbnailUrl'] as String : null, // Reading thumbnail URL from map
      time: map['time'] != null ? map['time'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  // Convert the object into JSON format
  String toJson() => json.encode(toMap());

  // Create a VideoModel from JSON
  factory VideoModel.fromJson(String source) => VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(highlightId: $highlightId, highlightVideo: $highlightVideo, thumbnailUrl: $thumbnailUrl, time: $time, userId: $userId)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.highlightId == highlightId &&
        other.highlightVideo == highlightVideo &&
        other.thumbnailUrl == thumbnailUrl &&
        other.time == time &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return highlightId.hashCode ^
        highlightVideo.hashCode ^
        thumbnailUrl.hashCode ^
        time.hashCode ^
        userId.hashCode;
  }
}
