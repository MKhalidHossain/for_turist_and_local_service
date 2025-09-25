class CreateBookingResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final BookingData? data;

  CreateBookingResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory CreateBookingResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateBookingResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
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

class BookingData {
  final String? bookingId;
  final String? bookingCode;
  final Summary? summary;
  final OfferDetails? offerDetails;

  BookingData({
    this.bookingId,
    this.bookingCode,
    this.summary,
    this.offerDetails,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      bookingId: json['bookingId'],
      bookingCode: json['bookingCode'],
      summary:
          json['summary'] != null ? Summary.fromJson(json['summary']) : null,
      offerDetails: json['offerDetails'] != null
          ? OfferDetails.fromJson(json['offerDetails'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'bookingCode': bookingCode,
      'summary': summary?.toJson(),
      'offerDetails': offerDetails?.toJson(),
    };
  }
}

class Summary {
  final String? serviceName;
  final String? schedule;
  final int? participants;
  final int? pricePerPerson;
  final int? total;

  Summary({
    this.serviceName,
    this.schedule,
    this.participants,
    this.pricePerPerson,
    this.total,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      serviceName: json['serviceName'],
      schedule: json['schedule'],
      participants: json['participants'],
      pricePerPerson: json['pricePerPerson'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceName': serviceName,
      'schedule': schedule,
      'participants': participants,
      'pricePerPerson': pricePerPerson,
      'total': total,
    };
  }
}

class OfferDetails {
  final String? id;
  final UserId? userId;
  final String? category;
  final String? offerType;
  final int? pricePerPerson;
  final int? maxParticipants;
  final String? description;
  final String? title;
  final List<String>? languages;
  final List<String>? photos;
  final List<Availability>? availability;
  final int? v;

  OfferDetails({
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

  factory OfferDetails.fromJson(Map<String, dynamic> json) {
    return OfferDetails(
      id: json['_id'],
      userId: json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      category: json['category'],
      offerType: json['offerType'],
      pricePerPerson: json['pricePerPerson'],
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

class UserId {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profileImage;

  UserId({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
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
