class User {
  final int userId;
  final String dni;
  final String username;
  final String surname;
  final String email;
  final String friendCode;
  final List<int>? password;
  final String role;
  final DateTime inscriptionDate;

  User({
    required this.userId,
    required this.dni,
    required this.username,
    required this.surname,
    required this.email,
    required this.friendCode,
    this.password,
    required this.role,
    required this.inscriptionDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json['user_id'],
    dni: json['dni'],
    username: json['username'],
    surname: json['surname'],
    email: json['email'],
    friendCode: json['friend_code'],
    password: json['password'] != null ? List<int>.from(json['password']) : null,
    role: json['role'],
    inscriptionDate: DateTime.parse(json['inscription_date']),
  );

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'dni': dni,
    'username': username,
    'surname': surname,
    'email': email,
    'friend_code': friendCode,
    'password': password,
    'role': role,
    'inscription_date': inscriptionDate.toIso8601String(),
  };
}