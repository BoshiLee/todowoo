class Auth {
  String? token;

  Auth({this.token});

  Auth.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}
