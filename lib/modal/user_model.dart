class UserModel {
  String? name, email;

  UserModel({
    required this.name,
    required this.email,
  });

  factory UserModel.fromMap(Map m1) {
    return UserModel(name: m1['name'], email: m1['email']);
  }

  Map<String, String?> toMap(UserModel user) {
    return {
      'name': user.name,
      'email': user.email,
    };
  }
}
