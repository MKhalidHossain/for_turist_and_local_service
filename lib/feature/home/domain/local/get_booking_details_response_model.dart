class GetTripsDetailsResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final TripDetailsData? data;

  GetTripsDetailsResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetTripsDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetTripsDetailsResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? TripDetailsData.fromJson(json['data']) : null,
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

class TripDetailsData {
  final String? id;
  final String? localId;
  final String? touristId;
  final Offer? offerId;
  final String? booking;
  final String? date;
  final int? participants;
  final String? status;
  final String? createdAt;
  final int? v;
  final String? touristName;
  final String? touristCountry;

  TripDetailsData({
    this.id,
    this.localId,
    this.touristId,
    this.offerId,
    this.booking,
    this.date,
    this.participants,
    this.status,
    this.createdAt,
    this.v,
    this.touristName,
    this.touristCountry,
  });

  factory TripDetailsData.fromJson(Map<String, dynamic> json) {
    return TripDetailsData(
      id: json['_id'],
      localId: json['localId'],
      touristId: json['touristId'],
      offerId: json['offerId'] != null ? Offer.fromJson(json['offerId']) : null,
      booking: json['booking'],
      date: json['date'],
      participants: json['participants'],
      status: json['status'],
      createdAt: json['createdAt'],
      v: json['__v'],
      touristName: json['touristName'],
      touristCountry: json['touristCountry'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'localId': localId,
      'touristId': touristId,
      'offerId': offerId?.toJson(),
      'booking': booking,
      'date': date,
      'participants': participants,
      'status': status,
      'createdAt': createdAt,
      '__v': v,
      'touristName': touristName,
      'touristCountry': touristCountry,
    };
  }
}

class Offer {
  final String? id;
  final String? userId;
  final String? category;
  final String? offerType;
  final int? pricePerPerson;
  final int? maxParticipants;
  final String? description;
  final String? title;
  final List<String>? languages;
  final List<dynamic>? photos;
  final List<Availability>? availability;
  final int? v;

  Offer({
    this.id,
    this.userId,
    this.category,
    this.offerType,
    this.pricePerPerson,
    this.maxParticipants,
    this.description,
    this.title,
    this.languages,
    this.photos,
    this.availability,
    this.v,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['_id'],
      userId: json['userId'],
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: json['pricePerPerson'],
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      photos: json['photos'] ?? [],
      availability: (json['availability'] as List<dynamic>?)
          ?.map((e) => Availability.fromJson(e))
          .toList(),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'category': category,
      'offerType': offerType,
      'pricePerPerson': pricePerPerson,
      'maxParticipants': maxParticipants,
      'description': description,
      'title': title,
      'languages': languages,
      'photos': photos,
      'availability': availability?.map((e) => e.toJson()).toList(),
      '__v': v,
    };
  }
}

class Availability {
  final String? date;
  final List<String>? timeSlots;
  final String? id;

  Availability({
    this.date,
    this.timeSlots,
    this.id,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      date: json['date'],
      timeSlots: (json['timeSlots'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'timeSlots': timeSlots,
      '_id': id,
    };
  }
}
