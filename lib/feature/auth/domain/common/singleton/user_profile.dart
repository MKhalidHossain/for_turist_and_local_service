import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UserProfile {
  String? firstName;
  String? lastName;
  String? gender;
  int? age;
  String? nationality;
  String? description;

  List<String> languages = [];
  XFile? profileImage; // Store as a File
  String? userRole;

  Map<String, String> toJson() => {
    'firstName': firstName ?? '',
    'lastName': lastName ?? '',
    'gender': gender ?? '',
    'age': age?.toString() ?? '',
    'nationality': nationality ?? '',
    'description': description ?? '',
    'languages': languages.join(','), // Convert list to comma-separated
    'profileImage': profileImage?.path ?? '',
    'userRole': userRole ?? '',
  };
}
