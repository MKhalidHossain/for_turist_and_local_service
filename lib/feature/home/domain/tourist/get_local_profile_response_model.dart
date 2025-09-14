class GetLocalProfileResponseModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  GetLocalProfileResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  GetLocalProfileResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode =
        json['statusCode'] is int
            ? json['statusCode']
            : (json['statusCode'] as num?)?.toInt();
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? country;
  List<String>? languages;
  String? about;
  String? profileImage;
  List<Offer>? offers;
  Rating? rating;

  Data({
    this.id,
    this.name,
    this.country,
    this.languages,
    this.about,
    this.profileImage,
    this.offers,
    this.rating,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    languages = (json['languages'] as List?)?.map((e) => e.toString()).toList();
    about = json['about'];
    profileImage = json['profileImage'];
    if (json['offers'] != null) {
      offers = [];
      json['offers'].forEach((v) {
        offers!.add(Offer.fromJson(v));
      });
    }
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['country'] = country;
    data['languages'] = languages;
    data['about'] = about;
    data['profileImage'] = profileImage;
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    return data;
  }
}

class Offer {
  String? sId;
  String? userId;
  String? category;
  String? offerType;
  int? pricePerPerson;
  int? maxParticipants;
  String? description;
  String? title;
  List<String>? languages;
  List<String>? photos;
  List<Availability>? availability;
  int? iV;

  Offer({
    this.sId,
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
    this.iV,
  });

  Offer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    category = json['category'];
    offerType = json['offerType'];
    pricePerPerson =
        json['pricePerPerson'] != null
            ? (json['pricePerPerson'] is int
                ? json['pricePerPerson']
                : (json['pricePerPerson'] as num).toInt())
            : null;
    maxParticipants =
        json['maxParticipants'] != null
            ? (json['maxParticipants'] is int
                ? json['maxParticipants']
                : (json['maxParticipants'] as num).toInt())
            : null;
    description = json['description'];
    title = json['title'];
    languages = (json['languages'] as List?)?.map((e) => e.toString()).toList();
    photos = (json['photos'] as List?)?.map((e) => e.toString()).toList();
    if (json['availability'] != null) {
      availability = [];
      json['availability'].forEach((v) {
        availability!.add(Availability.fromJson(v));
      });
    }
    iV =
        json['__v'] != null
            ? (json['__v'] is int ? json['__v'] : (json['__v'] as num).toInt())
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['userId'] = userId;
    data['category'] = category;
    data['offerType'] = offerType;
    data['pricePerPerson'] = pricePerPerson;
    data['maxParticipants'] = maxParticipants;
    data['description'] = description;
    data['title'] = title;
    data['languages'] = languages;
    data['photos'] = photos;
    if (availability != null) {
      data['availability'] = availability!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class Availability {
  String? date;
  List<String>? timeSlots;
  String? sId;

  Availability({this.date, this.timeSlots, this.sId});

  Availability.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timeSlots = (json['timeSlots'] as List?)?.map((e) => e.toString()).toList();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['date'] = date;
    data['timeSlots'] = timeSlots;
    data['_id'] = sId;
    return data;
  }
}

class Rating {
  int? average;
  int? count;
  List<Review>? reviews;

  Rating({this.average, this.count, this.reviews});

  Rating.fromJson(Map<String, dynamic> json) {
    average =
        json['average'] != null
            ? (json['average'] is int
                ? json['average']
                : (json['average'] as num).toInt())
            : null;
    count =
        json['count'] != null
            ? (json['count'] is int
                ? json['count']
                : (json['count'] as num).toInt())
            : null;
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews!.add(Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['average'] = average;
    data['count'] = count;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Review {
  int? rating;
  String? comment;
  Reviewer? reviewer;
  String? createdAt;

  Review({this.rating, this.comment, this.reviewer, this.createdAt});

  Review.fromJson(Map<String, dynamic> json) {
    rating =
        json['rating'] != null
            ? (json['rating'] is int
                ? json['rating']
                : (json['rating'] as num).toInt())
            : null;
    comment = json['comment'];
    reviewer =
        json['reviewer'] != null ? Reviewer.fromJson(json['reviewer']) : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['rating'] = rating;
    data['comment'] = comment;
    if (reviewer != null) {
      data['reviewer'] = reviewer!.toJson();
    }
    data['createdAt'] = createdAt;
    return data;
  }
}

class Reviewer {
  String? name;
  String? profileImage;

  Reviewer({this.name, this.profileImage});

  Reviewer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['profileImage'] = profileImage;
    return data;
  }
}
