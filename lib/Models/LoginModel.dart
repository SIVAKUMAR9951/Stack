class LoginModel{

  final int ?id;
  final String ?username;
  final String ?email;
  final String ?user_type;
  final String? api_login_token;
  final String? token;

  LoginModel({this.id,this.username,
    this.email,
    this.user_type,
    this.api_login_token,
    this.token,
  });

  factory LoginModel.fromJSON(Map<String, dynamic> map) {
    return LoginModel(
      id: map["id"],
      username: map["username"],
      email: map["email"],
      user_type: map["user_type"],
      api_login_token: map["api_login_token"],
      token: map["token"],
    );
  }

}