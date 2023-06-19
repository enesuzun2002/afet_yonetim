// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:objectbox/objectbox.dart';

@Entity()
class UserModel {
  @Id()
  int id = 0;
  int idNumber;
  String name;
  String surname;
  int birthYear;

  String token = "";
  UserModel({
    required this.idNumber,
    required this.name,
    required this.surname,
    required this.birthYear,
  });

  UserModel copyWith({
    int? idNumber,
    String? name,
    String? surname,
    int? birthYear,
  }) {
    return UserModel(
      idNumber: idNumber ?? this.idNumber,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      birthYear: birthYear ?? this.birthYear,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idNumber': idNumber,
      'name': name,
      'surname': surname,
      'birthYear': birthYear,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      idNumber: map['idNumber'] as int,
      name: map['name'] as String,
      surname: map['surname'] as String,
      birthYear: map['birthyear'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(idNumber: $idNumber, name: $name, surname: $surname, birthYear: $birthYear)';
  }
}
