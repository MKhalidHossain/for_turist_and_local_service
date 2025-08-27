// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kobeur/core/extensions/text_extensions.dart';
// import 'package:kobeur/core/validation/validators.dart';
// import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
// import 'package:kobeur/feature/profile/presentation/screens/account_settings_screen.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/widgets/wide_custom_button.dart';

// class AboutMeScreenProfile extends StatefulWidget {
//   const AboutMeScreenProfile({super.key});

//   @override
//   State<AboutMeScreenProfile> createState() => _AboutMeScreenProfileState();
// }

// class _AboutMeScreenProfileState extends State<AboutMeScreenProfile> {
//   late TextEditingController _aboutMeController;
//   final FocusNode _aboutMeFocus = FocusNode();
//   final _formKey = GlobalKey<FormState>(); // Fixed typo: _fromKey to _formKey
//   String? aboutMeText;
//   late ProfileController profileController; // Store controller reference

//   @override
//   void initState() {
//     super.initState();
//     // Access ProfileController outside build
//     profileController = Get.find<ProfileController>();
//     // Fetch user profile data
//     profileController.getUserProfile();
//     // Initialize aboutMeText
//     aboutMeText =
//         profileController.getProfileResponseModel?.data?.description ?? '';
//     // Initialize controller with aboutMeText
//     _aboutMeController = TextEditingController(text: aboutMeText);
//     // Add listener after initialization
//     _aboutMeController.addListener(_onFieldChanged);
//     print("aboutMeText (initState): $aboutMeText");
//   }

//   @override
//   void dispose() {
//     _aboutMeController.removeListener(_onFieldChanged);
//     _aboutMeController.dispose();
//     _aboutMeFocus.dispose();
//     super.dispose();
//   }

//   void _onFieldChanged() {
//     if (mounted) {
//       setState(() {}); // Update UI for character count
//     }
//   }

//   bool get isFormValid {
//     return Validators.textLength(
//           minLength: 3,
//           maxLength: 600,
//           _aboutMeController.text,
//         ) ==
//         null;
//   }

// //  Save description using ProfileController
//   void saveDescription() async {
//     if (_formKey.currentState!.validate()) {
//       await profileController.(_aboutMeController.text);
//       Get.to(() => AccountSettingsScreen());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileController>(
//       builder: (controller) {
//         // Update aboutMeText reactively
//         final newDescription =
//             controller.getProfileResponseModel?.data?.description ?? '';
//         if (_aboutMeController.text != newDescription &&
//             aboutMeText != newDescription) {
//           // Temporarily remove listener to avoid setState during build
//           _aboutMeController.removeListener(_onFieldChanged);
//           _aboutMeController.text = newDescription;
//           _aboutMeController.addListener(_onFieldChanged);
//           aboutMeText = newDescription;
//         }
//         print("aboutMeText (GetBuilder): $aboutMeText");

//         return controller.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Scaffold(
//               body: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const BackButton(color: Colors.black),
//                             'About Me'.text22Black700(),
//                             const SizedBox(width: 50),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         "Describe yourself in a few words.".text12DarkGrey(),
//                         const SizedBox(height: 16),
//                         Stack(
//                           children: [
//                             TextFormField(
//                               controller:
//                                   _aboutMeController, // Use controller only
//                               focusNode: _aboutMeFocus,
//                               keyboardType: TextInputType.multiline,
//                               maxLines: 15,
//                               minLines: 8,
//                               maxLength: 600,
//                               autofocus: true,
//                               buildCounter: (
//                                 BuildContext context, {
//                                 required int currentLength,
//                                 required bool isFocused,
//                                 required int? maxLength,
//                               }) {
//                                 return null; // Hide default counter
//                               },
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               decoration: InputDecoration(
//                                 hintText: 'Write your description here...',
//                                 filled: true,
//                                 fillColor: const Color(
//                                   0xffC4C4C4,
//                                 ).withOpacity(0.25),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 16,
//                                   horizontal: 12,
//                                 ).copyWith(bottom: 48),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.trim().isEmpty) {
//                                   return 'Description is required';
//                                 }
//                                 return Validators.textLength(
//                                   minLength: 3,
//                                   maxLength: 600,
//                                   value,
//                                 );
//                               },
//                             ),
//                             Positioned(
//                               bottom: 8,
//                               right: 12,
//                               child: Text(
//                                 '${_aboutMeController.text.length}/600',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey.shade600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Spacer(),
//                         WideCustomButton(
//                           onPressed: () {
//                             Get.to(AccountSettingsScreen());
//                           },
//                           text: 'Save',
//                           buttonColor:
//                               isFormValid
//                                   ? AppColors.context(context).primaryColor
//                                   : AppColors.secondaryColor,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/validation/validators.dart';
import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
import 'package:kobeur/feature/profile/presentation/screens/account_settings_screen.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/wide_custom_button.dart';

class AboutMeScreenProfile extends StatefulWidget {
  const AboutMeScreenProfile({super.key});

  @override
  State<AboutMeScreenProfile> createState() => _AboutMeScreenProfileState();
}

class _AboutMeScreenProfileState extends State<AboutMeScreenProfile> {
  late TextEditingController _aboutMeController;
  final FocusNode _aboutMeFocus = FocusNode();
  final _fromKey = GlobalKey<FormState>();
  String? aboutMeText;
  late ProfileController profileController;

  @override
  void initState() {
    super.initState();
    final profileController = Get.find<ProfileController>();
    profileController.getUserProfile();
    aboutMeText =
        profileController.getProfileResponseModel?.data?.description ?? '';

    _aboutMeController = TextEditingController(text: aboutMeText);
    _aboutMeController.addListener(_onFieldChanged);

    print("aboutMeText (initState): $aboutMeText\n");
  }

  @override
  void dispose() {
    _aboutMeController.removeListener(_onFieldChanged);
    _aboutMeController.dispose();
    _aboutMeFocus.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  bool get isFormValid {
    return Validators.textLength(
          minLength: 3,
          maxLength: 600,
          _aboutMeController.text,
        ) ==
        null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        final newAboutmeText =
            profileController.getProfileResponseModel?.data?.description ?? '';
        if (_aboutMeController.text != newAboutmeText &&
            aboutMeText != newAboutmeText) {
          _aboutMeController.removeListener(_onFieldChanged);
          _aboutMeController.text = newAboutmeText;
          _aboutMeController.addListener(_onFieldChanged);
          aboutMeText = newAboutmeText;
        }
        print("aboutMeText (GetBuilder): $aboutMeText");

        return profileController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButton(color: Colors.black),
                          'About Me'.text22Black700(),
                          SizedBox(width: 50),
                        ],
                      ),
                      const SizedBox(height: 16),
                      "Describe yourself in a few words.".text12DarkGrey(),

                      const SizedBox(height: 16),

                      Stack(
                        children: [
                          TextFormField(
                            // initialValue: aboutMeText.toString(),
                            controller: _aboutMeController,
                            focusNode: _aboutMeFocus,
                            keyboardType: TextInputType.multiline,
                            maxLines: 15,
                            minLines: 8,
                            maxLength: 600,
                            autofocus: true,
                            buildCounter: (
                              BuildContext context, {
                              required int currentLength,
                              required bool isFocused,
                              required int? maxLength,
                            }) {
                              return null; // Hide default counter
                            },
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Write your description here...',
                              filled: true,
                              fillColor: const Color(
                                0xffC4C4C4,
                              ).withOpacity(0.25),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ).copyWith(bottom: 48),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                          ),
                          Positioned(
                            bottom: 8,
                            right: 12,
                            child: Text(
                              '${_aboutMeController.text.length}/600',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),
                      WideCustomButton(
                        onPressed: () async {
                          if (_fromKey.currentState!.validate()) {
                            await profileController.updateSpacificFieldUserProfile(
                              
                              description: _aboutMeController.text,
                             
                            );  

                            await Future.delayed(Duration(seconds: 1));
                            Get.to(AccountSettingsScreen());
                          }
                        },

                        text: 'Save',
                        buttonColor:
                            isFormValid
                                ? AppColors.context(context).primaryColor
                                : AppColors.secondaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }
}
