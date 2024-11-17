class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({required this.id, required this.email, required this.name});

  //Create UserModel from Json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }
}
