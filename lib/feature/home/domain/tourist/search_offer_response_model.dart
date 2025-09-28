class SearchOfferResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<UserData>? data;

  SearchOfferResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory SearchOfferResponseModel.fromJson(Map<String, dynamic> json) {
    print("json mame print $json");
    return SearchOfferResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => UserData.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class UserData {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final List<Offer>? offers;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.offers,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
      offers:
          (json['offers'] as List<dynamic>?)
              ?.map((e) => Offer.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'offers': offers?.map((e) => e.toJson()).toList(),
    };
  }
}

class Offer {
  final String? id;
  final String? category;
  final String? offerType;
  final double? pricePerPerson;
  final int? maxParticipants;
  final String? description;
  final String? title;
  final List<String>? languages;
  final List<String>? photos;
  final List<Availability>? availability;

  Offer({
    this.id,
    this.category,
    this.offerType,
    this.pricePerPerson,
    this.maxParticipants,
    this.description,
    this.title,
    this.languages,
    this.photos,
    this.availability,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['_id'],
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson:
          (json['pricePerPerson'] is int)
              ? (json['pricePerPerson'] as int).toDouble()
              : json['pricePerPerson'],
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages:
          (json['languages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      availability:
          (json['availability'] as List<dynamic>?)
              ?.map((e) => Availability.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'category': category,
      'offerType': offerType,
      'pricePerPerson': pricePerPerson,
      'maxParticipants': maxParticipants,
      'description': description,
      'title': title,
      'languages': languages,
      'photos': photos,
      'availability': availability?.map((e) => e.toJson()).toList(),
    };
  }
}

class Availability {
  final String? id;
  final DateTime? date;
  final List<String>? timeSlots;

  Availability({this.id, this.date, this.timeSlots});

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      id: json['_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      timeSlots:
          (json['timeSlots'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'date': date?.toIso8601String(), 'timeSlots': timeSlots};
  }
}
