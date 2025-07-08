class LogInResponseModel {
  bool? status;
  String? message;
  String? accessToken;
  String? refreshToken;
  User? user;

  LogInResponseModel({
    this.status,
    this.message,
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  LogInResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? avatar;
  String? role;

  User({this.sId, this.name, this.email, this.avatar, this.role});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar']; // No need for null check, already String
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    data['role'] = role;
    return data;
  }
}
