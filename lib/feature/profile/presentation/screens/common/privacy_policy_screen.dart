import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle headerStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );

    final TextStyle bodyStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black87,
      height: 1.5,
    );

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Privacy Policy – Hatchr", style: headerStyle),
              const SizedBox(height: 8),
              Text(
                "Last updated: [2025]\n\n"
                "Hatchr we values your privacy and is committed to protecting your personal data. "
                "This Privacy Policy explains how we collect, use, and safeguard information when you use the Hatchr mobile application (“App”) and related services.",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("1. Information We Collect", style: headerStyle),
              Text(
                "• Account Information: name, email address, profile photo, age, gender, nationality, spoken languages, and role (Tourist or Local).\n"
                "• Profile Details (Locals): city, services offered, descriptions, rates, and availability.\n"
                "• Location Data: GPS-based data to show nearby locals and experiences (only with your consent).\n"
                "• Booking & Transaction Data: experience bookings, payments, receipts, and Stripe Connect details.\n"
                "• Chat & Communication: messages exchanged within the app.\n"
                "• Reviews & Ratings: feedback you provide.\n"
                "• Device Information: device type, OS, identifiers, IP address, app version, crash logs.",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("2. How We Use Your Information", style: headerStyle),
              Text(
                "We use your data to:\n"
                "• Create and manage your account.\n"
                "• Match tourists with locals.\n"
                "• Enable chat and communication.\n"
                "• Process bookings and payments securely.\n"
                "• Verify profiles and ensure platform safety.\n"
                "• Provide support and notifications.\n"
                "• Analyze trends and improve services.",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("3. Legal Basis for Processing", style: headerStyle),
              Text(
                "• Contractual necessity – to deliver services.\n"
                "• Consent – for location, marketing, analytics.\n"
                "• Legitimate interest – to ensure safety and reliability.\n"
                "• Legal obligations – compliance with laws and taxes.",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("4. Sharing of Information", style: headerStyle),
              Text(
                "We do not sell your data. We may share limited data with:\n"
                "• Other users (public profile info).\n"
                "• Stripe (for payments).\n"
                "• Service providers (hosting, analytics).\n"
                "• Authorities (when legally required).",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("5. Data Storage & Security", style: headerStyle),
              Text(
                "• Data stored in trusted cloud providers.\n"
                "• Encryption and secure authentication applied.\n"
                "• Data retained only as long as needed.",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("6. International Data Transfers", style: headerStyle),
              Text(
                "Your data may be processed globally. We apply safeguards for international transfers.",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("7. Your Rights", style: headerStyle),
              Text(
                "You may:\n"
                "• Access, update, or delete your data.\n"
                "• Restrict or object to processing.\n"
                "• Withdraw consent.\n"
                "• Request data portability.\n\n"
                "Contact us at: privacy@hatchr.app",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("8. Children’s Privacy", style: headerStyle),
              Text(
                "Hatchr is not intended for children under 16. We do not knowingly collect data from minors.",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("9. Retention of Data", style: headerStyle),
              Text(
                "We retain data only as long as necessary for service, legal, or dispute purposes.",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("10. Changes to this Policy", style: headerStyle),
              Text(
                "We may update this policy. Updates will be notified via the app or email.",
                style: bodyStyle,
              ),

              const SizedBox(height: 16),
              Text("11. Contact Us", style: headerStyle),
              Text(
                "If you have questions, contact us:\n"
                "📧 privacy@hatchr.app\n"
                "🌍 https://example.com",
                style: bodyStyle,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// // import 'package:url_launcher/url_launcher.dart';

// class PrivacyPolicyScreen extends StatelessWidget {
//   const PrivacyPolicyScreen({super.key});

//   Future<void> _launchLink(String text) async {
//     final Uri url = Uri.parse("https://example.com");
//     // if (await canLaunchUrl(url)) {
//     //   await launchUrl(url);
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(),
//         title: const Text("Privacy Policy – Hatchr"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi lobortis risus eget magna euismod rhoncus. Vivamus eu lectus et lectus interdum placerat.",
//                   style: TextStyle(
//                     color: Colors.black,
//                     decoration: TextDecoration.underline,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
