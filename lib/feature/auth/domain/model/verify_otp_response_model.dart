class VerifyCodeResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  String? accessToken;

  VerifyCodeResponseModel(
      {this.status, this.statusCode, this.message, this.accessToken});

  VerifyCodeResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['accessToken'] = accessToken;
    return data;
  }
}
