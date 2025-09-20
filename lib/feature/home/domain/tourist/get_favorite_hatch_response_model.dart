class GetFavoriteHatchResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final Data? data;

  GetFavoriteHatchResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetFavoriteHatchResponseModel.fromJson(Map<String, dynamic> json) {
    return GetFavoriteHatchResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
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

class Data {
  final List<User>? favorites;
  final List<Offer>? offers;

  Data({this.favorites, this.offers});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      favorites: json['favorites'] != null
          ? List<User>.from(json['favorites'].map((x) => User.fromJson(x)))
          : [],
      offers: json['offers'] != null
          ? List<Offer>.from(json['offers'].map((x) => Offer.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favorites': favorites?.map((x) => x.toJson()).toList(),
      'offers': offers?.map((x) => x.toJson()).toList(),
    };
  }
}

class User {
  final String? id;
  final String? email;
  final List<String>? languages;
  final String? registrationDate;
  final int? v;
  final String? role;
  final int? age;
  final String? description;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? nationality;
  final String? profileImage;
  final String? location;
  final String? stripeAccountId;

  User({
    this.id,
    this.email,
    this.languages,
    this.registrationDate,
    this.v,
    this.role,
    this.age,
    this.description,
    this.firstName,
    this.lastName,
    this.gender,
    this.nationality,
    this.profileImage,
    this.location,
    this.stripeAccountId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      registrationDate: json['registrationDate'],
      v: json['__v'],
      role: json['role'],
      age: json['age'],
      description: json['description'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      nationality: json['nationality'],
      profileImage: json['profileImage'],
      location: json['location'],
      stripeAccountId: json['stripeAccountId'],
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
      'lastName': lastName,
      'gender': gender,
      'nationality': nationality,
      'profileImage': profileImage,
      'location': location,
      'stripeAccountId': stripeAccountId,
    };
  }
}

class Offer {
  final String? id;
  final User? userId;
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
      userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: json['pricePerPerson'],
      maxParticipants: json['maxParticipants'],
      description: json['description'],
      title: json['title'],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      photos: json['photos'] != null
          ? List<String>.from(json['photos'])
          : [],
      availability: json['availability'] != null
          ? List<Availability>.from(
              json['availability'].map((x) => Availability.fromJson(x)))
          : [],
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
      'availability': availability?.map((x) => x.toJson()).toList(),
      '__v': v,
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
      timeSlots: json['timeSlots'] != null
          ? List<String>.from(json['timeSlots'])
          : [],
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
