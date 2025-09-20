class GetFavResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final FavData? data;

  GetFavResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetFavResponseModel.fromJson(Map<String, dynamic> json) {
    return GetFavResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? FavData.fromJson(json['data']) : null,
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

class FavData {
  final List<Favorite>? favorites;
  final List<Offer>? offers;

  FavData({this.favorites, this.offers});

  factory FavData.fromJson(Map<String, dynamic> json) {
    return FavData(
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => Favorite.fromJson(e))
          .toList(),
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favorites': favorites?.map((e) => e.toJson()).toList(),
      'offers': offers?.map((e) => e.toJson()).toList(),
    };
  }
}

class Favorite {
  final String? id;
  final String? email;
  final List<String>? languages;
  final String? registrationDate;
  final int? v;
  final String? role;
  final int? age;
  final String? description;
  final String? firstName;
  final String? gender;
  final String? lastName;
  final String? nationality;

  Favorite({
    this.id,
    this.email,
    this.languages,
    this.registrationDate,
    this.v,
    this.role,
    this.age,
    this.description,
    this.firstName,
    this.gender,
    this.lastName,
    this.nationality,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['_id'],
      email: json['email'],
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      registrationDate: json['registrationDate'],
      v: json['__v'],
      role: json['role'],
      age: json['age'],
      description: json['description'],
      firstName: json['firstName'],
      gender: json['gender'],
      lastName: json['lastName'],
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'languages': languages,
      'registrationDate': registrationDate,
      '__v': v,
      'role': role,
      'age': age,
      'description': description,
      'firstName': firstName,
      'gender': gender,
      'lastName': lastName,
      'nationality': nationality,
    };
  }
}

class Offer {
  final String? id;
  final UserId? userId;
  final String? category;
  final String? offerType;
  final num? pricePerPerson;
  final int? maxParticipants;
  final String? description;
  final String? title;
  final List<String>? languages;
  final List<String>? photos;
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
      userId: json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: json['pricePerPerson'],
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      availability: (json['availability'] as List<dynamic>?)
          ?.map((e) => Availability.fromJson(e))
          .toList(),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId?.toJson(),
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

class UserId {
  final String? id;
  final String? email;
  final List<String>? languages;
  final String? registrationDate;
  final int? v;
  final String? role;
  final int? age;
  final String? description;
  final String? firstName;
  final String? gender;
  final String? lastName;
  final String? nationality;

  UserId({
    this.id,
    this.email,
    this.languages,
    this.registrationDate,
    this.v,
    this.role,
    this.age,
    this.description,
    this.firstName,
    this.gender,
    this.lastName,
    this.nationality,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'],
      email: json['email'],
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      registrationDate: json['registrationDate'],
      v: json['__v'],
      role: json['role'],
      age: json['age'],
      description: json['description'],
      firstName: json['firstName'],
      gender: json['gender'],
      lastName: json['lastName'],
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'languages': languages,
      'registrationDate': registrationDate,
      '__v': v,
      'role': role,
      'age': age,
      'description': description,
      'firstName': firstName,
      'gender': gender,
      'lastName': lastName,
      'nationality': nationality,
    };
  }
}

class Availability {
  final String? date;
  final List<String>? timeSlots;
  final String? id;

  Availability({this.date, this.timeSlots, this.id});

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
