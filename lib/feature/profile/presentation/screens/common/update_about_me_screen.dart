import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/validation/validators.dart';
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
  bool isEditing = true;
  final _fromKey = GlobalKey<FormState>();

  @override
  void initState() {
    _aboutMeController = TextEditingController()..addListener(_onFieldChanged);
    super.initState();
  }

  @override
  void dispose() {
    _aboutMeController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                      fillColor: const Color(0xffC4C4C4).withOpacity(0.25),
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
              // const Text(
              //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam venenatis, magna ac auctor posuere, sem elit condimentum sapien, vel placerat velit diam vel felis. Ut varius elementum efficitur. Mauris ac dignissim urna, quis tempus neque. Vivamus ipsum ligula, faucibus sit amet ornare nec, ultrices ut velit. Pellentesque finibus elementum interdum. Donec suscipit risus purus, vitae iaculis odio iaculis at. Curabitur et nisl tempor, luctus mi ac, rutrum augue. Ut condimentum diam a massa sollicitudin finibus. Maecenas convallis augue id ipsum gravida blandit. Duis sollicitudin ante non sapien aliquet pellentesque. ",
              //   style: TextStyle(fontSize: 14),
              // ),
              // GestureDetector(
              //   // onTap: _launchEmail,
              //   child: const Text(
              //     "contact@thatchr.app",
              //     style: TextStyle(
              //       color: Colors.red,
              //       decoration: TextDecoration.underline,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 14,
              //     ),
              //   ),
              // ),
              const Spacer(),
              WideCustomButton(
                onPressed: () async {
                  if (_fromKey.currentState!.validate()) {
                    // UserProfileService.instance.profile.description =
                    //     _descriptionController.text;
                    // print(
                    //   '\nThe description is:' +
                    //       '${UserProfileService.instance.profile.description}',
                    // );
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
  }
}
