import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/auth/domain/singleton/user_profile_service.dart';
import 'package:kobeur/navigation/bottom_navigationber_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/app_scaffold.dart';

class UploadProfilePicture extends StatefulWidget {
  @override
  State<UploadProfilePicture> createState() => _UploadProfilePictureState();
}

class _UploadProfilePictureState extends State<UploadProfilePicture> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _descriptionController;
  final FocusNode _descriptionFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _descriptionController =
        TextEditingController()..addListener(_onFieldChanged);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  bool get isFormValid {
    return Validators.name(_descriptionController.text) == null;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Upload Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            'To create your new account, provide one of your photos.'
                .text14Black(),

            /// Middle content
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child:
                        _imageFile != null
                            ? Image.file(
                              _imageFile!,
                              height: size.width * 0.8,
                              width: size.width * 0.8,
                              fit: BoxFit.cover,
                            )
                            : Image.asset(
                              'assets/images/profileBlankImage.png',
                              height: size.width * 0.8,
                              width: size.width * 0.8,
                              fit: BoxFit.contain,
                            ),
                  ),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () => _pickImage(ImageSource.camera),
                          ),
                          const Text(
                            'Camera',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.photo_library_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () => _pickImage(ImageSource.gallery),
                          ),
                          const Text(
                            'Gallery',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 54),
              ],
            ),

            /// Bottom buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.45,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.to(BottomNavbar());
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.context(context).primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 24,
                      ),
                    ),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: AppColors.context(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                context.primaryButton(
                  onPressed: () {
                    if (_imageFile != null) {
                      UserProfileService.instance.profile.profileImage =
                          _imageFile;
                      print(
                        'Profile Image:' +
                            UserProfileService.instance.profile.profileImage
                                .toString() +
                            '\n',
                      );
                      Get.to(BottomNavbar());
                    } else
                      null;
                  },
                  width: size.width * 0.45,
                  text: "Continue",
                  backgroundColor:
                      _imageFile != null
                          ? AppColors.context(context).primaryColor
                          : AppColors.secondaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:kobeur/core/common/button/button_widget.dart';
// import 'package:kobeur/core/extensions/text_extensions.dart';

// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/validation/validators.dart';
// import '../../../../core/widgets/app_scaffold.dart';
// import 'tourist_or_local_screen.dart';

// class UploadProfilePicture extends StatefulWidget {
//   @override
//   State<UploadProfilePicture> createState() => _UploadProfilePictureState();
// }

// class _UploadProfilePictureState extends State<UploadProfilePicture> {
//   late TextEditingController _descriptionController;

//   final FocusNode _descriptionFocus = FocusNode();

//   String? selectedGender;

//   String? selectedNationality;

//   bool isEditing = true;

//   final _formKey = GlobalKey<FormState>();

//   //final uniqueCountryNames = countr>ies.map((c) => c.country).toSet().toList();
//   @override
//   void initState() {
//     _descriptionController =
//         TextEditingController()..addListener(_onFieldChanged);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _descriptionController.dispose();

//     super.dispose();
//   }

//   void _onFieldChanged() {
//     setState(() {});
//   }

//   bool get isFormValid {
//     return Validators.name(_descriptionController.text) == null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return AppScaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         title: const Text(
//           'Upload Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//             wordSpacing: 2,
//           ),
//         ),
//         centerTitle: false,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(bottom: 36.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             'To create your new account, provide one of your photos.'
//                 .text14Black(),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 24),
//                 Container(
//                   padding: EdgeInsets.all(6), // Border width
//                   decoration: BoxDecoration(
//                     color: Colors.red, // Border color
//                     shape: BoxShape.circle,
//                   ),
//                   child: ClipOval(
//                     child: Image.asset(
//                       'assets/images/profileBlankImage.png',
//                       height: 250,
//                       width: double.infinity,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 SizedBox(
//                   width: 150,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           IconButton(
//                             icon: const Icon(
//                               Icons.camera_alt_outlined,
//                               color: Colors.black,
//                               size: 30,
//                             ),
//                             onPressed: () {
//                               // Implement camera functionality
//                             },
//                           ),
//                           const Text(
//                             'Camera',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           IconButton(
//                             icon: const Icon(
//                               Icons.photo_library_outlined,
//                               color: Colors.black,
//                               size: 30,
//                             ),
//                             onPressed: () {
//                               // Implement gallery functionality
//                             },
//                           ),
//                           const Text(
//                             'Gallery',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // TextFormField(
//                 //   controller: _descriptionController,
//                 //   focusNode: _descriptionFocus,
//                 //   keyboardType: TextInputType.text,
//                 //   validator: Validators.textLength,
//                 //   decoration: InputDecoration(
//                 //     hintText: 'Write your about here. . .',
//                 //     hintStyle: TextStyle(
//                 //       color: AppColors.secondayText,
//                 //     ),
//                 //     filled: true,
//                 //     fillColor: const Color(
//                 //       0xffC4C4C4,
//                 //     ).withOpacity(0.25),
//                 //     border: OutlineInputBorder(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //       borderSide: BorderSide.none,
//                 //     ),
//                 //   ),
//                 //   style: TextStyle(
//                 //     color: AppColors.secondayText,
//                 //     fontSize: 16,
//                 //     fontWeight: FontWeight.w400,
//                 //   ),
//                 // ),
//                 const SizedBox(height: 54),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   width: size.width * 0.45,
//                   child: OutlinedButton(
//                     onPressed: () {
//                       // Your action here
//                     },
//                     style: OutlinedButton.styleFrom(
//                       side: BorderSide(
//                         color: AppColors.context(context).primaryColor,
//                       ), // Border color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           8,
//                         ), // Optional: rounded corners
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 14,
//                         horizontal: 24,
//                       ),
//                     ),
//                     child: Text(
//                       "Skip",
//                       style: TextStyle(
//                         color:
//                             AppColors.context(
//                               context,
//                             ).primaryColor, // Text color
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),

//                 context.primaryButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const TouristORLocalScreen(),
//                         ),
//                       );
//                     }
//                   },
//                   width: size.width * 0.45,
//                   text: "Continue",
//                   backgroundColor:
//                       isFormValid
//                           ? AppColors.context(context).primaryColor
//                           : AppColors.secondaryColor,
//                 ),
//               ],
//             ),

//             //const SizedBox(height: 36),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCustomTextField({
//     required String title,
//     required BuildContext context,
//     required String label,
//     required TextEditingController controller,
//     required FocusNode focusNode,
//     TextInputType keyboardType = TextInputType.text,
//     required String? Function(String?) validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             text: title,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//             ),
//             children: const [
//               TextSpan(
//                 text: ' *',
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           focusNode: focusNode,
//           keyboardType: keyboardType,
//           validator: validator,
//           decoration: InputDecoration(
//             hintText: label,
//             hintStyle: TextStyle(color: AppColors.secondayText),
//             filled: true,
//             fillColor: const Color(0xffC4C4C4).withOpacity(0.25),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide.none,
//             ),
//           ),
//           style: TextStyle(
//             color: AppColors.secondayText,
//             fontSize: 16,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         const SizedBox(height: 12),
//       ],
//     );
//   }

//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required void Function(String?) onChanged,
//     required String? Function(String?) validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 12),
//         RichText(
//           text: TextSpan(
//             text: label,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//             ),
//             children: const [
//               TextSpan(
//                 text: ' *',
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: value,
//           onChanged: onChanged,
//           validator: validator,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: const Color(0xffC4C4C4).withOpacity(0.25),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 14,
//             ),
//           ),
//           icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
//           dropdownColor: const Color(0xffC4C4C4),
//           style: const TextStyle(color: Colors.black, fontSize: 16),
//           items:
//               items
//                   .map(
//                     (item) => DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(item),
//                     ),
//                   )
//                   .toList(),
//         ),
//       ],
//     );
//   }
// }
