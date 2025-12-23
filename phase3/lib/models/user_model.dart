class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final int age;
  final String position; // e.g., Forward, Midfielder, Defender
  final String? profileImageUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.age,
    required this.position,
    this.profileImageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'age': age,
      'position': position,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      age: map['age'] ?? 0,
      position: map['position'] ?? '',
      profileImageUrl: map['profileImageUrl'],
    );
  }
}