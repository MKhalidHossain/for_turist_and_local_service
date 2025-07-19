import 'package:flutter/material.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';

import 'account_settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

              _buildMenuItem(icon: Icons.info_outline, text: "About App"),
              _buildMenuItem(
                icon: Icons.privacy_tip_outlined,
                text: "Privacy Policy",
              ),
              _buildMenuItem(
                icon: Icons.article_outlined,
                text: "Term & Condition",
              ),
              _buildMenuItem(icon: Icons.help_outline, text: "Help & Support"),

              _buildMenuItem(
                icon: Icons.logout,
                text: "Log Out",
                iconColor: Colors.red,
                textColor: Colors.red,
                showTrailing: true,
                onTap: () {
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
