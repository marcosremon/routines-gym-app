import 'package:routines_gym_app/domain/model/enums/role.dart';

class UserDTO {
  String dni;
  String username;
  String surname;
  String email;
  String friendCode;
  String password;
  Role role;
  String inscriptionDate;

  UserDTO({
    required this.dni,
    required this.username,
    required this.surname,
    required this.email,
    required this.friendCode,
    required this.password,
    required this.role,
    required this.inscriptionDate,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      dni: json['dni'] ?? '',
      username: json['username'] ?? '',
      surname: json['surname'] ?? '',
      email: json['email'] ?? '',
      friendCode: json['friendCode'] ?? '',
      password: json['password'] ?? '',
      role: Role.values.firstWhere(
        (r) => r.name.toLowerCase() == (json['role'] ?? '').toLowerCase(),
        orElse: () => Role.user,
      ),
      inscriptionDate: json['inscriptionDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dni': dni,
      'username': username,
      'surname': surname,
      'email': email,
      'friendCode': friendCode,
      'password': password,
      'role': role.name,
      'inscriptionDate': inscriptionDate,
    };
  }
}