class RateALocalResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final RateALocalData? data;

  RateALocalResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory RateALocalResponseModel.fromJson(Map<String, dynamic> json) {
    return RateALocalResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? RateALocalData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class RateALocalData {
  final int? rating;
  final String? comment;

  RateALocalData({this.rating, this.comment});

  factory RateALocalData.fromJson(Map<String, dynamic> json) {
    return RateALocalData(
      rating: json['rating'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
    };
  }
}
