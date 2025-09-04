class GetHomeResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final HomeData data;

  GetHomeResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetHomeResponseModel.fromJson(Map<String, dynamic> json) {
    return GetHomeResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: HomeData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class HomeData {
  final int earnings;
  final int totalTours;
  final double averageRating;
  final LiveTrip? liveTrip;
  final List<Trip> upcomingTrips;

  HomeData({
    required this.earnings,
    required this.totalTours,
    required this.averageRating,
    this.liveTrip,
    required this.upcomingTrips,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      earnings: json['earnings'],
      totalTours: json['totalTours'],
      averageRating: (json['averageRating'] as num).toDouble(),
      liveTrip: json['liveTrip'] != null ? LiveTrip.fromJson(json['liveTrip']) : null,
      upcomingTrips: (json['upcomingTrips'] as List<dynamic>?)
              ?.map((e) => Trip.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'earnings': earnings,
      'totalTours': totalTours,
      'averageRating': averageRating,
      'liveTrip': liveTrip?.toJson(),
      'upcomingTrips': upcomingTrips.map((e) => e.toJson()).toList(),
    };
  }
}

class LiveTrip {
  // Add fields based on your API liveTrip structure
  LiveTrip();

  factory LiveTrip.fromJson(Map<String, dynamic> json) {
    return LiveTrip(
      // map fields here
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // map fields here
    };
  }
}

class Trip {
  // Add fields based on your upcomingTrips structure
  Trip();

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      // map fields here
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // map fields here
    };
  }
}
