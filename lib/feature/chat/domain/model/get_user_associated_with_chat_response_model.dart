class GetUserAssociatedWithChatResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<ChatData>? data;

  GetUserAssociatedWithChatResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetUserAssociatedWithChatResponseModel.fromJson(Map<String, dynamic> json) {
    return GetUserAssociatedWithChatResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<ChatData>.from(json['data'].map((x) => ChatData.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'message': message,
        'data': data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : [],
      };
}

class ChatData {
  final String? name;
  final String? message;
  final String? time;
  final String? avatar;
  final int? unreadCount;
  final bool? isRead;
  final bool? isMedia;
  final bool? isDocument;
  final bool? isSentByMe;
  final String? senderId;
  final String? receiverId;
  final String? fileUrl;
  final String? fileType;
  final User? sender;
  final User? receiver;

  ChatData({
    this.name,
    this.message,
    this.time,
    this.avatar,
    this.unreadCount,
    this.isRead,
    this.isMedia,
    this.isDocument,
    this.isSentByMe,
    this.senderId,
    this.receiverId,
    this.fileUrl,
    this.fileType,
    this.sender,
    this.receiver,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      name: json['name'],
      message: json['message'],
      time: json['time'],
      avatar: json['avatar'],
      unreadCount: json['unreadCount'],
      isRead: json['isRead'],
      isMedia: json['isMedia'],
      isDocument: json['isDocument'],
      isSentByMe: json['isSentByMe'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      fileUrl: json['fileUrl'],
      fileType: json['fileType'],
      sender: json['sender'] != null ? User.fromJson(json['sender']) : null,
      receiver: json['receiver'] != null ? User.fromJson(json['receiver']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'message': message,
        'time': time,
        'avatar': avatar,
        'unreadCount': unreadCount,
        'isRead': isRead,
        'isMedia': isMedia,
        'isDocument': isDocument,
        'isSentByMe': isSentByMe,
        'senderId': senderId,
        'receiverId': receiverId,
        'fileUrl': fileUrl,
        'fileType': fileType,
        'sender': sender?.toJson(),
        'receiver': receiver?.toJson(),
      };
}

class User {
  final String? id;
  final String? name;
  final String? avatar;

  User({this.id, this.name, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
      };
}
