// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OfferModel {
  String offerId;
  String offerName;
  String offerPic;
  String time;
  String userId;

  OfferModel({
    required this.offerId,
    required this.offerName,
    required this.offerPic,
    required this.time,
    required this.userId,
  });

  OfferModel copyWith({
    String? offerId,
    String? offerName,
    String? offerPic,
    String? time,
    String? userId,
  }) {
    return OfferModel(
      offerId: offerId ?? this.offerId,
      offerName: offerName ?? this.offerName,
      offerPic: offerPic ?? this.offerPic,
      time: time ?? this.time,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offerId': offerId,
      'offerName': offerName,
      'offerPic': offerPic,
      'time': time,
      'userId': userId,
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      offerId: map['offerId'] as String,
      offerName: map['offerName'] as String,
      offerPic: map['offerPic'] as String,
      time: map['time'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferModel.fromJson(String source) =>
      OfferModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OfferModel(offerId: $offerId, offerName: $offerName, offerPic: $offerPic, time: $time, userId: $userId)';
  }

  @override
  bool operator ==(covariant OfferModel other) {
    if (identical(this, other)) return true;

    return other.offerId == offerId &&
        other.offerName == offerName &&
        other.offerPic == offerPic &&
        other.time == time &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return offerId.hashCode ^
        offerName.hashCode ^
        offerPic.hashCode ^
        time.hashCode ^
        userId.hashCode;
  }
}
