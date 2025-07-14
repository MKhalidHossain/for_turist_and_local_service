import 'package:flutter/material.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/auth/domain/singleton/user_profile_service.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/choose_country/data/countries.dart';
import 'description_screen.dart';

// class TouristOrLocalScreen extends StatelessWidget {
//   const TouristOrLocalScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Tourist or Local")),
//       body: const Center(child: Text("Next screen content goes here.")),
//     );
//   }
// }

class PersonalInformetionScreen extends StatefulWidget {
  const PersonalInformetionScreen({super.key});

  @override
  State<PersonalInformetionScreen> createState() => UserSignupScreenState();
}

class UserSignupScreenState extends State<PersonalInformetionScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameNameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();

  String? selectedGender;
  String? selectedNationality;
  bool isEditing = true;

  final _formKey = GlobalKey<FormState>();

  final uniqueCountryNames = countries.map((c) => c.country).toSet().toList();

  @override
  void initState() {
    _firstNameController =
        TextEditingController()..addListener(_onFieldChanged);
    _lastNameController = TextEditingController()..addListener(_onFieldChanged);
    _ageController = TextEditingController()..addListener(_onFieldChanged);
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  bool get isFormValid {
    return Validators.name(_firstNameController.text) == null &&
        Validators.name(_lastNameController.text) == null &&
        Validators.age(_ageController.text) == null &&
        selectedGender != null &&
        selectedNationality != null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Personal Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            wordSpacing: 2,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: size.height),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'To create your new account, provide your information.'
                            .text14Black(),
                        const SizedBox(height: 24),
                        _buildCustomTextField(
                          title: 'First Name',
                          context: context,
                          label: 'Write your first name here',
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          validator: Validators.name,
                        ),
                        _buildCustomTextField(
                          title: 'Last Name',
                          context: context,
                          label: 'Write your last name here',
                          controller: _lastNameController,
                          focusNode: _lastNameNameFocus,
                          validator: Validators.name,
                        ),
                        _buildCustomTextField(
                          title: 'Age',
                          context: context,
                          label: 'Write your age here',
                          controller: _ageController,
                          focusNode: _ageFocus,
                          validator: Validators.age,
                          keyboardType: TextInputType.number,
                        ),
                        _buildDropdown(
                          label: 'Gender',
                          value: selectedGender,
                          items: ['Male', 'Female', 'Other'],
                          onChanged:
                              (val) => setState(() => selectedGender = val),
                          validator:
                              (value) =>
                                  value == null ? 'Please select gender' : null,
                        ),
                        _buildDropdown(
                          label: 'Nationality',
                          value: selectedNationality,
                          items: uniqueCountryNames,
                          onChanged:
                              (val) =>
                                  setState(() => selectedNationality = val),
                          validator:
                              (value) =>
                                  value == null
                                      ? 'Please select nationality'
                                      : null,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          context.primaryButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                UserProfileService.instance.profile.firstName =
                    _firstNameController.text;
                UserProfileService.instance.profile.lastName =
                    _lastNameController.text;
                UserProfileService.instance.profile.age = int.tryParse(
                  _ageController.text,
                );
                UserProfileService.instance.profile.gender = selectedGender;
                UserProfileService.instance.profile.nationality =
                    selectedNationality;

                print(
                  'The user data is \n' +
                      '\nFirst name:' +
                      (UserProfileService.instance.profile.firstName ?? '') +
                      '\nLast name:' +
                      (UserProfileService.instance.profile.lastName ?? '') +
                      '\nAge:' +
                      ((UserProfileService.instance.profile.age?.toString()) ??
                          '') +
                      '\nGender:' +
                      (UserProfileService.instance.profile.gender ?? '') +
                      '\nNationality:' +
                      (UserProfileService.instance.profile.nationality ?? ''),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DescriptionScreen()),
                );
              }
            },
            text: "Continue",
            backgroundColor:
                isFormValid
                    ? AppColors.context(context).primaryColor
                    : AppColors.secondaryColor,
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  Widget _buildCustomTextField({
    required String title,
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(color: AppColors.secondayText),
            filled: true,
            fillColor: const Color(0xffC4C4C4).withOpacity(0.25),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(
            color: AppColors.secondayText,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffC4C4C4).withOpacity(0.25),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          dropdownColor: const Color(0xffC4C4C4),
          style: const TextStyle(color: Colors.black, fontSize: 16),
          items:
              items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:kobeur/core/common/button/button_widget.dart';
// import 'package:kobeur/core/extensions/text_extensions.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/validation/validators.dart';
// import '../../../../core/widgets/app_scaffold.dart';
// import '../../../../core/widgets/choose_country/data/countries.dart';
// import 'tourist_or_local_screen.dart';

// class PersonalInformetionScreen extends StatefulWidget {
//   const PersonalInformetionScreen({super.key});

//   @override
//   State<PersonalInformetionScreen> createState() => UserSignupScreenState();
// }

// class UserSignupScreenState extends State<PersonalInformetionScreen> {
//   //final String? Function(String?)? validator;


//   late TextEditingController _firstNameController;
//   late TextEditingController _lastNameController;
//   late TextEditingController _ageController;
//   final FocusNode _firstNameFocus = FocusNode();
//   final FocusNode _lastNameNameFocus = FocusNode();
//   final FocusNode _ageFocus = FocusNode();

//   String? selectedGender;
//   String? selectedNationality;
//   bool isEditing = true;

//   final _formKey = GlobalKey<FormState>();

//   final uniqueCountryNames =
//       countries.map((c) => c.country).toSet().toList(); // removes duplicates

//   @override
//   void initState() {
//     _firstNameController = TextEditingController()..addListener(_onFieldChanged);
//     _lastNameController = TextEditingController()..addListener(_onFieldChanged);
//     _ageController = TextEditingController()..addListener(_onFieldChanged);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _ageController.dispose();
//     super.dispose();
//   }

//   void _onFieldChanged() {
//     setState(() {}); // Rebuild to update button state
//   }

//   bool get isFormValid {
//     return Validators.name(_firstNameController.text) == null &&
//         Validators.name(_lastNameController.text) == null &&
//         Validators.age(_ageController.text) == null &&
//         selectedGender != null &&
//         selectedNationality != null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return AppScaffold(
//       appBar: AppBar(
//         leading: BackButton(),
//         title: const Text(
//           maxLines: 2,
//           'Personal Information',
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
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12.0),
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(minHeight: size.height),
//                   child: IntrinsicHeight(
//                     child: Form(
//                       key: _formKey,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           'To create your new account, provide your information.'
//                               .text14Black(),
//                           const SizedBox(height: 24),

//                           /// Name
//                           _buildCustomTextField(
//                             title: 'Frist Name',
//                             context: context,
//                             label: 'Write your first name here',
//                             controller: _firstNameController,
//                             focusNode: _firstNameFocus,
//                             validator: Validators.name,
//                           ),
//                           _buildCustomTextField(
//                             title: 'Last Name',
//                             context: context,
//                             label: 'Write your last name here',
//                             controller: _lastNameController,
//                             focusNode: _lastNameNameFocus,
//                             validator: Validators.name,
//                           ),
//                           _buildCustomTextField(
//                             title: 'Age',
//                             context: context,
//                             label: 'Write your age here',
//                             controller: _ageController,
//                             focusNode: _ageFocus,
//                             validator: Validators.age,
//                             keyboardType: TextInputType.number,
//                           ),

//                           CustomDropdown(
//                             label: 'Gender',
//                             items: ['Male', 'Female', 'Other'],
//                             selectedValue: selectedGender,
//                             isEnabled: isEditing,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedGender = value;
//                               });
//                             },
//                           ),

//                           CustomDropdown(
//                             label: 'Nationality',
//                             items: uniqueCountryNames,
//                             selectedValue: selectedNationality,
//                             isEnabled: isEditing,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedNationality = value;
//                               });
//                             },
//                             // validator: (value) => value == null ? 'Please select a nationality' : null,
//                           ),

//                           // CustomDropdown(
//                           //   label: 'Nationality',
//                           //   items: uniqueCountryNames,
//                           //   selectedValue:
//                           //       uniqueCountryNames.isNotEmpty
//                           //           ? uniqueCountryNames[0]
//                           //           : null,
//                           //   isEnabled: isEditing,
//                           //   onChanged: (value) {
//                           //     setState(() {
//                           //       selectedNationality = value;
//                           //     });
//                           //   },
//                           // ),
//                           const SizedBox(height: 12),

//                           /// Login button
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           context.primaryButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 if (!isFormValid) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text("Passwords do not match"),
//                       backgroundColor: Colors.red,
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                   return;
//                 } else {
//                   // print("EMAIL: ${widget.userEmail}");
//                   // print(
//                   //   "PASS: ${_newPasswordController.text}",
//                   // );
//                   // print(
//                   //   "CONFIRM PASS: ${_repeatPasswordController.text}",
//                   // );

//                   // final String pass =
//                   //     _newPasswordController.text;
//                   // final String repPass =
//                   //     _repeatPasswordController.text;
//                   // authController.resetPassword(
//                   //   widget.userEmail,
//                   //   pass,
//                   //   repPass,
//                   // );
//                 }

//                 // ScaffoldMessenger.of(
//                 //   context,
//                 // ).showSnackBar(
//                 //   const SnackBar(
//                 //     content: Text(
//                 //       "Password changed successfully",
//                 //     ),
//                 //     backgroundColor: Colors.green,
//                 //     behavior: SnackBarBehavior.floating,
//                 //   ),
//                 // );
//                 // _newPasswordController.clear();
//                 // _repeatPasswordController.clear();
//               }
//             },
//             text: "Continue",
//             backgroundColor:
//                 isFormValid
//                     ? AppColors.context(context).primaryColor
//                     : AppColors.secondaryColor,
//           ),
//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildCustomTextField({
//   required String title,
//   required BuildContext context,
//   required String label,
//   required TextEditingController controller,
//   required FocusNode focusNode,
//   TextInputType keyboardType = TextInputType.text,
//   required String? Function(String?) validator,
// }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       RichText(
//         text: TextSpan(
//           text: title,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//             fontWeight: FontWeight.w400,
//           ),
//           children: [
//             TextSpan(
//               text: ' *',
//               style: TextStyle(
//                 color: Colors.red,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(height: 8),

//       TextFormField(
//         controller: controller,
//         focusNode: focusNode,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           hint: Text(label, style: TextStyle(color: AppColors.secondayText)),
//           filled: true,
//           fillColor: Color(0xffC4C4C4).withOpacity(0.25),
//           border: InputBorder.none,
//         ),
//         showCursor: true,
//         onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focusNode),
//         textInputAction: TextInputAction.done,
//         validator: Validators.name,
//         style: TextStyle(
//           color: AppColors.secondayText,
//           fontSize: 16,
//           fontWeight: FontWeight.w400,
//         ),
//         maxLines: 1,
//         autofocus: false,

//         autofillHints: const [AutofillHints.email],
//       ),

//       // TextFormField(
//       //   keyboardType: TextInputType.emailAddress,
//       //   decoration: InputDecoration(
//       //     hint: Text(
//       //       'Write your first name here. . .',
//       //       style: TextStyle(color: AppColors.secondayText),
//       //     ),
//       //   ),
//       // ),
//       const SizedBox(height: 12),
//     ],
//   );
// }

// class CustomDropdown extends StatelessWidget {
//   final String label;
//   final List<String> items;
//   final String? selectedValue;
//   final bool isEnabled;
//   final ValueChanged<String?> onChanged;

//   const CustomDropdown({
//     super.key,
//     required this.label,
//     required this.items,
//     required this.selectedValue,
//     required this.onChanged,
//     this.isEnabled = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 12),
//         RichText(
//           text: TextSpan(
//             text: label,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//             ),
//             children: [
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

//         const SizedBox(height: 4),
//         Container(
//           decoration: BoxDecoration(
//             color: Color(0xffC4C4C4).withOpacity(0.25),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: DropdownButtonFormField<String>(
//             value: selectedValue,
//             onChanged: isEnabled ? onChanged : null,
//             dropdownColor: Color(0xffC4C4C4).withOpacity(0.8),
//             icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
//             style: const TextStyle(color: Colors.black, fontSize: 16),
//             decoration: const InputDecoration(
//               hintText: 'Select a value',
//               hintStyle: TextStyle(color: Colors.grey),
//               border: InputBorder.none,
//               enabledBorder: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               contentPadding: EdgeInsets.symmetric(vertical: 14),
//             ),
//             items:
//                 items
//                     .map(
//                       (item) => DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(
//                           item,
//                           style: const TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     )
//                     .toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Validators {
//   static String? name(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a name';
//     }
//     if (value.length < 2) {
//       return 'Name must be at least 2 characters';
//     }
//     return null;
//   }

//   static String? age(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter an age';
//     }
//     final age = int.tryParse(value);
//     if (age == null || age < 1 || age > 150) {
//       return 'Please enter a valid age';
//     }
//     return null;
//   }
// }
