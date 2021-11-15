class RegisterModel {
  String? email;
  String? password;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (email != null) data['name'] = email;
    if (password != null) data['password'] = password;
    return data;
  }
}
