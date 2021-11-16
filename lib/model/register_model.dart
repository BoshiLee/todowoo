class RegisterModel {
  String? username;
  String? password;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (username != null) data['username'] = username;
    if (password != null) data['password'] = password;
    return data;
  }
}
