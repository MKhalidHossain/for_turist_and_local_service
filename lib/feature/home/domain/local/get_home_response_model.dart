class GetHomeResponseModel {
  int? statusCode;
  bool? success;
  String? message;
  HomeData? data;

  GetHomeResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
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
      'data': data?.toJson(),
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
      liveTrip:
          json['liveTrip'] != null ? LiveTrip.fromJson(json['liveTrip']) : null,
      upcomingTrips:
          (json['upcomingTrips'] as List<dynamic>?)
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
  final String id;
  final String localId;
  final String touristId;
  final String offerId;
  final String booking;
  final DateTime date;
  final int participants;
  final String status;
  final DateTime createdAt;
  final int v;

  LiveTrip({
    required this.id,
    required this.localId,
    required this.touristId,
    required this.offerId,
    required this.booking,
    required this.date,
    required this.participants,
    required this.status,
    required this.createdAt,
    required this.v,
  });

  factory LiveTrip.fromJson(Map<String, dynamic> json) {
    return LiveTrip(
      id: json['_id'] ?? '',
      localId: json['localId'] ?? '',
      touristId: json['touristId'] ?? '',
      offerId: json['offerId'] ?? '',
      booking: json['booking'] ?? '',
      date: DateTime.parse(json['date']),
      participants: json['participants'] ?? 0,
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'localId': localId,
      'touristId': touristId,
      'offerId': offerId,
      'booking': booking,
      'date': date.toIso8601String(),
      'participants': participants,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      '__v': v,
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
