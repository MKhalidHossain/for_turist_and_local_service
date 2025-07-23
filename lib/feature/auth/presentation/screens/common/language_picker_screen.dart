import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/feature/auth/presentation/screens/common/personal_informetion_screen.dart';
import '../../../../../core/widgets/choose_country/model/country.dart';
import '../../../../../core/widgets/choose_country/data/countries.dart';
import '../../../domain/common/singleton/user_profile_service.dart';

class LanguagePickerScreen extends StatefulWidget {
  const LanguagePickerScreen({super.key});

  @override
  State<LanguagePickerScreen> createState() => _LanguagePickerScreenState();
}

class _LanguagePickerScreenState extends State<LanguagePickerScreen> {
  //String? selectedCountryCode;
  Set<String> selectedLanguages = {};
  List<Country> filteredCountries = countries;

  void onSearch(String query) {
    setState(() {
      filteredCountries =
          countries
              .where(
                (country) =>
                    country.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void onSelect(Country country) {
    setState(() {
      if (selectedLanguages.contains(country.name)) {
        selectedLanguages.remove(country.name);
      } else {
        selectedLanguages.add(country.name);
      }
    });
  }

  // void onSelect(Country country) {
  //   setState(() {
  //     selectedCountryCode = country.countryCode;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text(
          maxLines: 2,
          'What is your spoken  language?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            wordSpacing: 2,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Search Box
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: onSearch,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Choose your language",
                contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),

            // TextFormField(
            //   onChanged: onSearch,
            //   focusNode: _countryFocus,
            //   keyboardType: TextInputType.emailAddress,

            //   decoration: InputDecoration(
            //     prefixIcon: Padding(
            //       padding: EdgeInsets.all(12.0),
            //       child: const Icon(Icons.search),
            //     ),
            //     hint: Text(
            //       'Choose your language',
            //       style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w400,
            //         color: AppColors.secondayText,
            //         fontFamily: 'poppins',
            //       ),
            //     ),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       borderSide: BorderSide(
            //         color: AppColors.secondayText,
            //         width: 1,
            //       ),
            //     ),
            //     fillColor: Colors.grey[300],
            //     filled: true,
            //   ),
            //   onFieldSubmitted:
            //       (_) => FocusScope.of(context).requestFocus(_countryFocus),
            //   textInputAction: TextInputAction.done,
            //   validator: Validators.email,
            //   style: TextStyle(
            //     color: AppColors.secondayText,
            //     fontSize: 16,
            //     fontWeight: FontWeight.w400,
            //   ),
            //   autofillHints: const [AutofillHints.email],
            // ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: filteredCountries.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final country = filteredCountries[index];
                  return ListTile(
                    leading: Text(
                      country.flagEmoji,
                      style: const TextStyle(fontSize: 22),
                    ),
                    title: Text(
                      country.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing:
                        selectedLanguages.contains(country.name)
                            ? const Icon(Icons.check, color: Colors.red)
                            : null,

                    onTap: () => onSelect(country),
                  );
                },
              ),
            ),
          ),
          // Continue Button
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ), // EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed:
                    selectedLanguages.isNotEmpty
                        ? () {
                          UserProfileService.instance.profile.languages =
                              selectedLanguages.toList();

                          Navigator.pop(context, selectedLanguages.toList());
                          print(UserProfileService.instance.profile.languages);
                          Get.to(PersonalInformetionScreen());
                        }
                        : null,

                // onPressed:
                //     selectedCountryCode != null
                //         ? () {
                //           // Do something with selected country
                //           final selectedCountry = countries.firstWhere(
                //             (c) => c.countryCode == selectedCountryCode,
                //           );
                //           Navigator.pop(context, selectedCountry);
                //         }
                //         : null,
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24), // Add some spacing
        ],
      ),
    );
  }
}
