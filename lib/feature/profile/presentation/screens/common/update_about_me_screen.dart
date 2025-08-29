// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/widgets/wide_custom_button.dart';
// import '../../../controllers/profile_controller.dart';
// import '../account_settings_screen.dart';

// class AboutMeScreenProfile extends StatefulWidget {
//   const AboutMeScreenProfile({Key? key}) : super(key: key);

//   @override
//   State<AboutMeScreenProfile> createState() => _AboutMeScreenProfileState();
// }

// class _AboutMeScreenProfileState extends State<AboutMeScreenProfile> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _aboutMeController = TextEditingController();

//   late ProfileController profileController;

//   String? _initialDescription;
//   bool _isFormValid = false;

//   @override
//   void initState() {
//     super.initState();
//     profileController = Get.find<ProfileController>();

//     // Load current description after widget builds
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final currentDescription =
//           profileController.getProfileResponseModel?.data?.description ?? "";
//       _aboutMeController.text = currentDescription;
//       _initialDescription = currentDescription;
//       _validateForm();
//     });

//     _aboutMeController.addListener(_onFieldChanged);
//   }

//   void _onFieldChanged() {
//     _validateForm();
//   }

//   void _validateForm() {
//     final text = _aboutMeController.text.trim();
//     final isChanged = text != _initialDescription;
//     final isValid = text.isNotEmpty;

//     setState(() {
//       _isFormValid = isChanged && isValid;
//     });
//   }

//   @override
//   void dispose() {
//     _aboutMeController.dispose();
//     super.dispose();
//   }

//   Future<void> _saveDescription() async {
//     if (!_formKey.currentState!.validate()) return;

//     await profileController.updateSpacificFieldUserProfile(
//       description: _aboutMeController.text.trim(),
//     );

//     if (!mounted) return;

//     // Update initial description so Save button disables again
//     setState(() {
//       _initialDescription = _aboutMeController.text.trim();
//       _isFormValid = false;
//     });

//     // Navigate back to Account Settings
//     Get.to(() => const AccountSettingsScreen());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("About Me"),
//         backgroundColor: AppColors.context(context).primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _aboutMeController,
//                 maxLines: 4,
//                 decoration: const InputDecoration(
//                   labelText: "Tell us about yourself",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Description cannot be empty";
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),
//               WideCustomButton(
//                 onPressed: () async {
//                   if (!_formKey.currentState!.validate()) return;

//                   await profileController.updateSpacificFieldUserProfile(
//                     description: _aboutMeController.text.trim(),
//                   );

//                   if (!mounted) return;

//                   // Update initial description so Save button disables again
//                   setState(() {
//                     _initialDescription = _aboutMeController.text.trim();
//                     _isFormValid = false;
//                   });

//                   // Navigate back to Account Settings
//                   Get.to(() => const AccountSettingsScreen());
//                 },
//                 text: 'Save',
//                 buttonColor:
//                     _isFormValid
//                         ? AppColors.context(context).primaryColor
//                         : AppColors.secondaryColor,
//               ),
//             ],
//           ),
//         ),
//       ),
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
  final _formKey = GlobalKey<FormState>(); // Fixed typo: _fromKey to _formKey
  String? aboutMeText;
  late ProfileController profileController; // Store controller reference

  @override
  void initState() {
    super.initState();
    profileController = Get.find<ProfileController>();
    profileController.getUserProfile();

    aboutMeText =
        profileController.getProfileResponseModel?.data?.description ?? '';

    _aboutMeController = TextEditingController(text: aboutMeText);

    _aboutMeController.addListener(_onFieldChanged);
    print("aboutMeText (initState): $aboutMeText");
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
      setState(() {}); // Update UI for character count
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

  //  Save description using ProfileController
  void saveDescription() async {
    if (_formKey.currentState!.validate()) {
      await profileController.updateSpacificFieldUserProfile(
        description: _aboutMeController.text,
      );
      Get.to(() => AccountSettingsScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        final newDescription =
            controller.getProfileResponseModel?.data?.description ?? '';
        if (_aboutMeController.text != newDescription &&
            aboutMeText != newDescription) {
          _aboutMeController.removeListener(_onFieldChanged);
          _aboutMeController.text = newDescription;
          _aboutMeController.addListener(_onFieldChanged);
          aboutMeText = newDescription;
        }
        print("aboutMeText (GetBuilder): $aboutMeText");

        return controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BackButton(color: Colors.black),
                            const Text(
                              'Update About me',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                wordSpacing: 2,
                              ),
                            ),
                            const SizedBox(width: 50),
                          ],
                        ),
                        const SizedBox(height: 16),
                        "Describe yourself in a few words.".text12DarkGrey(),
                        const SizedBox(height: 16),
                        Stack(
                          children: [
                            TextFormField(
                              controller:
                                  _aboutMeController, // Use controller only
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
                                return Validators.textLength(
                                  minLength: 3,
                                  maxLength: 600,
                                  value,
                                );
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
                          onPressed: () {
                            saveDescription();
                            Get.to(AccountSettingsScreen());
                          },
                          text: 'Update',
                          buttonColor:
                              isFormValid
                                  ? AppColors.context(context).primaryColor
                                  : AppColors.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
      },
    );
  }
}

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
//   final _formKey = GlobalKey<FormState>();
//   String? aboutMeText;
//   late ProfileController profileController;

//   @override
//   void initState() {
//     super.initState();
//     final profileController = Get.find<ProfileController>();
//     profileController.getUserProfile();
//     aboutMeText =
//         profileController.getProfileResponseModel?.data?.description ?? '';

//     _aboutMeController = TextEditingController(text: aboutMeText);
//     _aboutMeController.addListener(_onFieldChanged);

//     print("aboutMeText (initState): $aboutMeText\n");
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
//       setState(() {});
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

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileController>(
//       builder: (profileController) {
//         final newAboutmeText =
//             profileController.getProfileResponseModel?.data?.description ?? '';

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (!mounted) return;
//           if (_aboutMeController.text != newAboutmeText &&
//               aboutMeText != newAboutmeText) {
//             _aboutMeController
//             ..removeListener(_onFieldChanged)
//             ..text = newAboutmeText
//             ..addListener(_onFieldChanged);
//             aboutMeText = newAboutmeText;
//           }
//         });

//         print("aboutMeText (GetBuilder): $aboutMeText");

//         return profileController.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Scaffold(
//               body: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           BackButton(color: Colors.black),
//                           'About Me'.text22Black700(),
//                           SizedBox(width: 50),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       "Describe yourself in a few words.".text12DarkGrey(),

//                       const SizedBox(height: 16),

//                       Stack(
//                         children: [
//                           TextFormField(
//                             // initialValue: aboutMeText.toString(),
//                             controller: _aboutMeController,
//                             focusNode: _aboutMeFocus,
//                             keyboardType: TextInputType.multiline,
//                             maxLines: 15,
//                             minLines: 8,
//                             maxLength: 600,
//                             autofocus: true,
//                             buildCounter: (
//                               BuildContext context, {
//                               required int currentLength,
//                               required bool isFocused,
//                               required int? maxLength,
//                             }) {
//                               return null; // Hide default counter
//                             },
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             decoration: InputDecoration(
//                               hintText: 'Write your description here...',
//                               filled: true,
//                               fillColor: const Color(
//                                 0xffC4C4C4,
//                               ).withOpacity(0.25),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide.none,
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 16,
//                                 horizontal: 12,
//                               ).copyWith(bottom: 48),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Description is required';
//                               }
//                               return null;
//                             },
//                           ),
//                           Positioned(
//                             bottom: 8,
//                             right: 12,
//                             child: Text(
//                               '${_aboutMeController.text.length}/600',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const Spacer(),
//                       WideCustomButton(
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             await profileController
//                                 .updateSpacificFieldUserProfile(
//                                   description: _aboutMeController.text,
//                                 );

//                             // await Future.delayed(Duration(seconds: 2), () {

//                             // });
//                             if (!mounted) return;
//                             Get.to(AccountSettingsScreen());
//                           }
//                         },

//                         text: 'Save',
//                         buttonColor:
//                             isFormValid
//                                 ? AppColors.context(context).primaryColor
//                                 : AppColors.secondaryColor,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//       },
//     );
//   }
// }
