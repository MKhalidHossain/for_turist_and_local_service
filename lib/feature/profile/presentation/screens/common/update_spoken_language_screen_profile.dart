import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
import '../../../../../core/widgets/choose_country/model/country.dart';
import '../../../../../core/widgets/choose_country/data/countries.dart';

class UpdateSpokenLanguageScreen extends StatefulWidget {
  final String? userRole;

  const UpdateSpokenLanguageScreen({super.key, required this.userRole});

  @override
  State<UpdateSpokenLanguageScreen> createState() =>
      _UpdateSpokenLanguageScreenState();
}

class _UpdateSpokenLanguageScreenState
    extends State<UpdateSpokenLanguageScreen> {
  late ProfileController profileController;
  Set<String> selectedLanguages = {};
  List<Country> filteredCountries = countries;
  List<String>? userLanguages;

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

  @override
  void initState() {
    super.initState();
    profileController = Get.find<ProfileController>();
    profileController.getUserProfile().then((_) {
      userLanguages =
          profileController.getProfileResponseModel?.data?.languages;

      print(
        "This is Loaded Laguage from api form initstate of Screen : $userLanguages",
      );
      if (userLanguages != null && userLanguages!.isNotEmpty) {
        setState(() {
          selectedLanguages = userLanguages!.toSet();
          print(
            "Selected Languages form initstate of Screen : $selectedLanguages",
          );
        });
      }
    });
  }

  bool get isFormValid {
    if (userLanguages == null) return selectedLanguages.isNotEmpty;
    final original = userLanguages!.toSet();
    return original.length != selectedLanguages.length ||
        original.contains(selectedLanguages);
  }

  void saveSpokenLanguagesScreen() async {
    if (selectedLanguages.isNotEmpty && isFormValid) {
      await profileController.updateSpacificFieldUserProfile(
        languages: selectedLanguages.toList(),
      );
      Get.to(() => UpdateSpokenLanguageScreen(userRole: widget.userRole));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(),
            title: const Text(
              maxLines: 2,
              'Update your spoken language',
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
                        selectedLanguages.isNotEmpty && isFormValid
                            ? () {
                              saveSpokenLanguagesScreen();
                            }
                            : null,
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24), // Add some spacing
            ],
          ),
        );
      },
    );
  }
}
