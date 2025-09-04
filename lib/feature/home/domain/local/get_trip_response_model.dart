class GetTripResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final List<TripData> data;

  GetTripResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetTripResponseModel.fromJson(Map<String, dynamic> json) {
    return GetTripResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => TripData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class TripData {
  final String id;
  final String localId;
  final Tourist touristId;
  final Offer offerId;
  final String date;
  final int participants;
  final String status;
  final String createdAt;
  final int v;
  final String touristName;
  final int rating;

  TripData({
    required this.id,
    required this.localId,
    required this.touristId,
    required this.offerId,
    required this.date,
    required this.participants,
    required this.status,
    required this.createdAt,
    required this.v,
    required this.touristName,
    required this.rating,
  });

  factory TripData.fromJson(Map<String, dynamic> json) {
    return TripData(
      id: json['_id'],
      localId: json['localId'],
      touristId: Tourist.fromJson(json['touristId']),
      offerId: Offer.fromJson(json['offerId']),
      date: json['date'],
      participants: json['participants'],
      status: json['status'],
      createdAt: json['createdAt'],
      v: json['__v'],
      touristName: json['touristName'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'localId': localId,
      'touristId': touristId.toJson(),
      'offerId': offerId.toJson(),
      'date': date,
      'participants': participants,
      'status': status,
      'createdAt': createdAt,
      '__v': v,
      'touristName': touristName,
      'rating': rating,
    };
  }
}

class Tourist {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String location;
  final String profileImage;

  Tourist({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.profileImage,
  });

  factory Tourist.fromJson(Map<String, dynamic> json) {
    return Tourist(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      location: json['location'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'location': location,
      'profileImage': profileImage,
    };
  }
}

class Offer {
  final String id;
  final String userId;
  final String category;
  final String offerType;
  final int pricePerPerson;
  final int maxParticipants;
  final String description;
  final String title;
  final List<String> languages;
  final List<String> photos;
  final List<Availability> availability;
  final int v;

  Offer({
    required this.id,
    required this.userId,
    required this.category,
    required this.offerType,
    required this.pricePerPerson,
    required this.maxParticipants,
    required this.description,
    required this.title,
    required this.languages,
    required this.photos,
    required this.availability,
    required this.v,
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
      languages: List<String>.from(json['languages'] ?? []),
      photos: List<String>.from(json['photos'] ?? []),
      availability: (json['availability'] as List<dynamic>?)
              ?.map((e) => Availability.fromJson(e))
              .toList() ??
          [],
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
      'availability': availability.map((e) => e.toJson()).toList(),
      '__v': v,
    };
  }
}

class Availability {
  final String id;
  final String date;
  final List<String> timeSlots;

  Availability({
    required this.id,
    required this.date,
    required this.timeSlots,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      id: json['_id'],
      date: json['date'],
      timeSlots: List<String>.from(json['timeSlots'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date,
      'timeSlots': timeSlots,
    };
  }
}
