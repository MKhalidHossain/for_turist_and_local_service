class GetUserAssociatedWithChatResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<String>? data;

  GetUserAssociatedWithChatResponseModel({
     this.statusCode,
     this.success,
     this.message,
     this.data,
  });

  factory GetUserAssociatedWithChatResponseModel.fromJson(
      Map<String, dynamic> json) {
    return GetUserAssociatedWithChatResponseModel(
      statusCode: json["statusCode"] ?? 0,
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: List<String>.from(json["data"] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "success": success,
      "message": message,
      "data": data,
    };
  }
}
