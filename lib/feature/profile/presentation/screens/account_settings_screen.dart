import 'package:flutter/material.dart';
import '../../../../core/widgets/app_scaffold.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Account Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
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
              // Row(
              //   children: [
              //     Stack(
              //       clipBehavior: Clip.none,
              //       children: [
              //         const CircleAvatar(
              //           radius: 35,
              //           backgroundImage: NetworkImage(
              //             "https://randomuser.me/api/portraits/women/44.jpg",
              //           ),
              //         ),
              //         Positioned(
              //           bottom: 0,
              //           right: -2,
              //           child: GestureDetector(
              //             onTap: () {
              //               // Handle image change
              //             },
              //             child: Container(
              //               padding: const EdgeInsets.all(4),
              //               decoration: const BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: Colors.red,
              //               ),
              //               child: const Icon(
              //                 Icons.camera_alt,
              //                 size: 14,
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     const SizedBox(width: 16),
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           'Jerome Bell'.text20Grey700(),
              //           'China'.text16Grey(),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 24),

              // _buildMenuItem(
              //   icon: Icons.settings,
              //   text: "Account Settings",
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => const AccountSettingsScreen(),
              //       ),
              //     );
              //   },
              // ),
              _buildMenuItem(icon: Icons.person, text: "Personal Information"),
              _buildMenuItem(
                icon: Icons.document_scanner_outlined,
                text: "About Me",
              ),
              _buildMenuItem(
                icon: Icons.language_outlined,
                text: "Spoken Language",
              ),
              _buildMenuItem(
                icon: Icons.lock_outline_rounded,
                text: "Change Password",
              ),

              // _buildMenuItem(
              //   icon: Icons.logout,
              //   text: "Log Out",
              //   iconColor: Colors.red,
              //   textColor: Colors.red,
              //   showTrailing: true,
              //   onTap: () {
              //     // Implement logout logic here
              //   },
              // ),
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
