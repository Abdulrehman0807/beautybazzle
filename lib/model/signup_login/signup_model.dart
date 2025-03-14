// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModels {
  String name;
  String email;
  String password;
  String PhoneNumber;
  String UserId;
  String Address;
  String ProfilePicture;
  String YouTube;
  String Facebook;
  String Instagram;
  String TikTok;
  String AboutMe;

  UserModels({
    required this.name,
    required this.email,
    required this.password,
    required this.PhoneNumber,
    required this.UserId,
    this.Address = "",
    this.ProfilePicture = "",
    this.YouTube = "",
    this.Facebook = "",
    this.Instagram = "",
    this.TikTok = "",
    this.AboutMe = "",
  });

  UserModels copyWith({
    String? name,
    String? email,
    String? password,
    String? PhoneNumber,
    String? UserId,
    String? Address,
    String? ProfilePicture,
    String? YouTube,
    String? Facebook,
    String? Instagram,
    String? TikTok,
    String? AboutMe,
  }) {
    return UserModels(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      PhoneNumber: PhoneNumber ?? this.PhoneNumber,
      UserId: UserId ?? this.UserId,
      Address: Address ?? this.Address,
      ProfilePicture: ProfilePicture ?? this.ProfilePicture,
      YouTube: YouTube ?? this.YouTube,
      Facebook: Facebook ?? this.Facebook,
      Instagram: Instagram ?? this.Instagram,
      TikTok: TikTok ?? this.TikTok,
      AboutMe: AboutMe ?? this.AboutMe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'PhoneNumber': PhoneNumber,
      'UserId': UserId,
      'Address': Address,
      'ProfilePicture': ProfilePicture,
      'YouTube': YouTube,
      'Facebook': Facebook,
      'Instagram': Instagram,
      'TikTok': TikTok,
      'AboutMe': AboutMe,
    };
  }

  factory UserModels.fromMap(Map<String, dynamic> map) {
    return UserModels(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      PhoneNumber: map['PhoneNumber'] as String,
      UserId: map['UserId'] as String,
      Address: map['Address'] as String,
      ProfilePicture: map['ProfilePicture'] as String,
      YouTube: map['YouTube'] as String,
      Facebook: map['Facebook'] as String,
      Instagram: map['Instagram'] as String,
      TikTok: map['TikTok'] as String,
      AboutMe: map['AboutMe'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModels.fromJson(String source) =>
      UserModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModels(name: $name, email: $email, password: $password, PhoneNumber: $PhoneNumber, UserId: $UserId, Address: $Address, ProfilePicture: $ProfilePicture, YouTube: $YouTube, Facebook: $Facebook, Instagram: $Instagram, TikTok: $TikTok, AboutMe: $AboutMe)';
  }

  @override
  bool operator ==(covariant UserModels other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.PhoneNumber == PhoneNumber &&
        other.UserId == UserId &&
        other.Address == Address &&
        other.ProfilePicture == ProfilePicture &&
        other.YouTube == YouTube &&
        other.Facebook == Facebook &&
        other.Instagram == Instagram &&
        other.TikTok == TikTok &&
        other.AboutMe == AboutMe;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        PhoneNumber.hashCode ^
        UserId.hashCode ^
        Address.hashCode ^
        ProfilePicture.hashCode ^
        YouTube.hashCode ^
        Facebook.hashCode ^
        Instagram.hashCode ^
        TikTok.hashCode ^
        AboutMe.hashCode;
  }
}
