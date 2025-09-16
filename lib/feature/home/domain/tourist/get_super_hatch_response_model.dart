class GetSuperHatchResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<SuperHatchData>? data;

  GetSuperHatchResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetSuperHatchResponseModel.fromJson(Map<String, dynamic> json) {
    return GetSuperHatchResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<SuperHatchData>.from(
              json['data'].map((x) => SuperHatchData.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "data": data?.map((x) => x.toJson()).toList(),
      };
}

class SuperHatchData {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final Offers? offers;
  final int? ratingCount;
  final double? averageRating;

  SuperHatchData({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.offers,
    this.ratingCount,
    this.averageRating,
  });

  factory SuperHatchData.fromJson(Map<String, dynamic> json) {
    return SuperHatchData(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
      offers: json['offers'] != null ? Offers.fromJson(json['offers']) : null,
      ratingCount: json['ratingCount'],
      averageRating: (json['averageRating'] is int)
          ? (json['averageRating'] as int).toDouble()
          : json['averageRating']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profileImage": profileImage,
        "offers": offers?.toJson(),
        "ratingCount": ratingCount,
        "averageRating": averageRating,
      };
}

class Offers {
  final String? id;
  final String? userId;
  final String? category;
  final String? offerType;
  final double? pricePerPerson;
  final int? maxParticipants;
  final String? description;
  final String? title;
  final List<String>? languages;
  final List<String>? photos;
  final List<Availability>? availability;
  final int? v;

  Offers({
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

  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
      id: json['_id'],
      userId: json['userId'],
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: (json['pricePerPerson'] is int)
          ? (json['pricePerPerson'] as int).toDouble()
          : json['pricePerPerson']?.toDouble(),
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      photos:
          json['photos'] != null ? List<String>.from(json['photos']) : [],
      availability: json['availability'] != null
          ? List<Availability>.from(
              json['availability'].map((x) => Availability.fromJson(x)))
          : [],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "category": category,
        "offerType": offerType,
        "pricePerPerson": pricePerPerson,
        "maxParticipants": maxParticipants,
        "description": description,
        "title": title,
        "languages": languages,
        "photos": photos,
        "availability": availability?.map((x) => x.toJson()).toList(),
        "__v": v,
      };
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
      timeSlots: json['timeSlots'] != null
          ? List<String>.from(json['timeSlots'])
          : [],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "timeSlots": timeSlots,
        "_id": id,
      };
}
