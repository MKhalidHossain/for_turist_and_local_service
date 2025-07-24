import 'dart:io';

class UserProfile {
  String? firstName;
  String? lastName;
  String? gender;
  int? age;
  String? nationality;
  String? description;

  List<String> languages = [];
  File? profileImage; // Store as a File
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
