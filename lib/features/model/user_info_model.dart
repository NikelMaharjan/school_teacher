

class UserInfo {
  final String email;
  final String userType;

  UserInfo({
    required this.email,
    required this.userType
});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      email: json['email'],
      userType: json['userType']
    );
  }


}