// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LocationModel {
  String phoneNumber;
  String photo;
  double latitude;
  double longitude;
  int userID;
  LocationModel({
    required this.phoneNumber,
    this.photo = "",
    required this.latitude,
    required this.longitude,
    required this.userID,
  });

  LocationModel copyWith({
    String? phoneNumber,
    String? photo,
    double? latitude,
    double? longitude,
    int? userID,
  }) {
    return LocationModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photo: photo ?? this.photo,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'mediaLink': photo,
      'latitude': latitude,
      'longitude': longitude,
      'userID': userID,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      phoneNumber: map['phoneNumber'] as String,
      photo: map['mediaLink'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      userID: map['userID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationModel(phoneNumber: $phoneNumber, photo: $photo, latitude: $latitude, longitude: $longitude, userID: $userID)';
  }
}
