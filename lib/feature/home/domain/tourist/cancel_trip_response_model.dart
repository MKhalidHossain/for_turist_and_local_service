class CancelTripResponseModel {
  final bool? success;
  final String? message;
  final List<ErrorSource>? errorSources;
  final CancelTripError? err;
  final int? stack;

  CancelTripResponseModel({
    this.success,
    this.message,
    this.errorSources,
    this.err,
    this.stack,
  });

  factory CancelTripResponseModel.fromJson(Map<String, dynamic> json) {
    return CancelTripResponseModel(
      success: json['success'],
      message: json['message'],
      errorSources:
          json['errorSources'] != null
              ? (json['errorSources'] as List)
                  .map((e) => ErrorSource.fromJson(e))
                  .toList()
              : null,
      err: json['err'] != null ? CancelTripError.fromJson(json['err']) : null,
      stack: json['stack'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'errorSources': errorSources?.map((e) => e.toJson()).toList(),
      'err': err?.toJson(),
      'stack': stack,
    };
  }
}

class ErrorSource {
  final String? path;
  final String? message;

  ErrorSource({this.path, this.message});

  factory ErrorSource.fromJson(Map<String, dynamic> json) {
    return ErrorSource(path: json['path'], message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'path': path, 'message': message};
  }
}

class CancelTripError {
  final int? statusCode;

  CancelTripError({this.statusCode});

  factory CancelTripError.fromJson(Map<String, dynamic> json) {
    return CancelTripError(statusCode: json['statusCode']);
  }

  Map<String, dynamic> toJson() {
    return {'statusCode': statusCode};
  }
}
