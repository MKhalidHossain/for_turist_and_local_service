class RefreshTokenResponseModel {
  bool? status;
  String? message;
  RefreshTokenResponseModel? data;

  RefreshTokenResponseModel({this.status, this.message, this.data});

  RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
