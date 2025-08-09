import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/auth/presentation/screens/common/user_login_screen.dart';
import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
import 'package:kobeur/feature/profile/presentation/screens/common/about_app_screen.dart';

import 'account_settings_screen.dart';
import 'common/help_support_screen.dart';
import 'common/privacy_policy_screen.dart';
import 'common/terms_condition_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final profileScreenController = Get.put(ProfileController(Get.find()));

  @override
  Widget build(BuildContext context) {
    // final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // const SizedBox(height: 24),
              // ListTile(
              //   leading: CircleAvatar(
              //     radius: 30,
              //     backgroundImage: NetworkImage(
              //       "https://randomuser.me/api/portraits/women/44.jpg",
              //     ),
              //   ),
              //   title: const Text(
              //     'Kristin Watson',
              //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              //   ),
              //   subtitle: const Text('Tourist'),
              // ),
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/women/44.jpg",
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -2,
                        child: GestureDetector(
                          onTap: () {
                            // Handle image change
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Jerome Bell'.text20Grey700(),
                        'China'.text16Grey(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildMenuItem(
                icon: Icons.settings,
                text: "Account Settings",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AccountSettingsScreen(),
                    ),
                  );
                },
              ),

              _buildMenuItem(
                icon: Icons.info_outline,
                text: "About App",
                onTap: () {
                  Get.to(AboutAppScreen());
                },
              ),
              _buildMenuItem(
                icon: Icons.privacy_tip_outlined,
                text: "Privacy Policy",
                onTap: () {
                  Get.to(PrivacyPolicyScreen());
                },
              ),
              _buildMenuItem(
                icon: Icons.article_outlined,
                text: "Term & Condition",
                onTap: () {
                  Get.to(TermsConditionScreen());
                },
              ),
              _buildMenuItem(
                icon: Icons.help_outline,
                text: "Help & Support",
                onTap: () {
                  Get.to(HelpSupportScreen());
                },
              ),

              _buildMenuItem(
                icon: Icons.logout,
                text: "Log Out",
                iconColor: Colors.red,
                textColor: Colors.red,
                showTrailing: true,
                onTap: () async {
                  //  await   profileScreenController
                  //         .getApicall(); // 👈 This logs out the user

                  Get.off(UserLoginScreen());
                  // Implement logout logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
    Color iconColor = const Color(0xff666666),
    Color textColor = const Color(0xff666666),
    bool showTrailing = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            onTap: onTap,
            dense: true,
            leading: Icon(icon, color: iconColor),
            title: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
            trailing:
                showTrailing
                    ? Icon(Icons.arrow_forward_ios, size: 16, color: iconColor)
                    : null,
          ),
        ),
        Divider(height: 0.5, thickness: 0.5, color: textColor),
      ],
    );
  }
}
