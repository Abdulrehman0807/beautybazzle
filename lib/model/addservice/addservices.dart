// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServiceModel {
  String serviceId;
  String serviceName;
  String serviceDescription;
  String servicePic;
  String time;
  String userId;

  ServiceModel({
    required this.serviceId,
    required this.serviceName,
    required this.serviceDescription,
    required this.servicePic,
    required this.time,
    required this.userId,
  });

  ServiceModel copyWith({
    String? serviceId,
    String? serviceName,
    String? serviceDescription,
    String? servicePic,
    String? time,
    String? userId,
  }) {
    return ServiceModel(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      serviceDescription: serviceDescription ?? this.serviceDescription,
      servicePic: servicePic ?? this.servicePic,
      time: time ?? this.time,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceId': serviceId,
      'serviceName': serviceName,
      'serviceDescription': serviceDescription,
      'servicePic': servicePic,
      'time': time,
      'userId': userId,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      serviceId: map['serviceId'] as String? ?? '',
      serviceName: map['serviceName'] as String? ?? '',
      serviceDescription: map['serviceDescription'] as String? ?? '',
      servicePic: map['servicePic'] as String? ?? '',
      time: map['time'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceModel(serviceId: $serviceId, serviceName: $serviceName, serviceDescription: $serviceDescription, servicePic: $servicePic, time: $time, userId: $userId)'; // Fixed typo
  }

  @override
  bool operator ==(covariant ServiceModel other) {
    if (identical(this, other)) return true;

    return other.serviceId == serviceId &&
        other.serviceName == serviceName &&
        other.serviceDescription == serviceDescription &&
        other.servicePic == servicePic &&
        other.time == time &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
        serviceName.hashCode ^
        serviceDescription.hashCode ^
        servicePic.hashCode ^
        time.hashCode ^
        userId.hashCode;
  }
}
