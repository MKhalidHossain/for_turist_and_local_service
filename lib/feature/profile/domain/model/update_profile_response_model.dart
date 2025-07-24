class UpdateProfileResponseModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  UpdateProfileResponseModel({this.statusCode, this.success, this.message, this.data});

  UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? email;
  List<String>? languages;
  String? registrationDate;
  List<dynamic>? ratings;
  List<dynamic>? offers;
  List<dynamic>? trips;
  int? iV;
  String? role;
  int? age;
  String? description;
  String? firstName;
  String? gender;
  String? lastName;
  String? nationality;
  String? profileImage;

  Data(
      {this.sId,
      this.email,
      this.languages,
      this.registrationDate,
      this.ratings,
      this.offers,
      this.trips,
      this.iV,
      this.role,
      this.age,
      this.description,
      this.firstName,
      this.gender,
      this.lastName,
      this.nationality,
      this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    languages = json['languages'].cast<String>();
    registrationDate = json['registrationDate'];
    if (json['ratings'] != null) {
      ratings = List<dynamic>.from(json['ratings']);
    }
    if (json['offers'] != null) {
      offers = List<dynamic>.from(json['offers']);
    }
    if (json['trips'] != null) {
      trips = List<dynamic>.from(json['trips']);
    }
    iV = json['__v'];
    role = json['role'];
    age = json['age'];
    description = json['description'];
    firstName = json['firstName'];
    gender = json['gender'];
    lastName = json['lastName'];
    nationality = json['nationality'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['languages'] = languages;
    data['registrationDate'] = registrationDate;
    data['ratings'] = ratings;
    data['offers'] = offers;
    data['trips'] = trips;
    data['__v'] = iV;
    data['role'] = role;
    data['age'] = age;
    data['description'] = description;
    data['firstName'] = firstName;
    data['gender'] = gender;
    data['lastName'] = lastName;
    data['nationality'] = nationality;
    data['profileImage'] = profileImage;
    return data;
  }
}
