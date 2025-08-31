class GetFirstPageResponseModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  GetFirstPageResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetFirstPageResponseModel.fromJson(Map<String, dynamic> json) {
    return GetFirstPageResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['statusCode'] = statusCode;
    result['success'] = success;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class Data {
  List<TopDestination>? topDestinations;
  List<String>? categories;

  Data({this.topDestinations, this.categories});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      topDestinations: json['topDestinations'] != null
          ? List<TopDestination>.from(
              json['topDestinations'].map((x) => TopDestination.fromJson(x)))
          : [],
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (topDestinations != null) {
      result['topDestinations'] =
          topDestinations!.map((v) => v.toJson()).toList();
    }
    result['categories'] = categories;
    return result;
  }
}

class TopDestination {
  int? id;
  String? name;
  String? imageUrl;

  TopDestination({this.id, this.name, this.imageUrl});

  factory TopDestination.fromJson(Map<String, dynamic> json) {
    return TopDestination(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['name'] = name;
    result['imageUrl'] = imageUrl;
    return result;
  }
}
