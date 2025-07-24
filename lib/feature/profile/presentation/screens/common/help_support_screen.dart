import 'package:flutter/material.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/widgets/wide_custom_button.dart';
// import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'contact@thatchr.app',
    );
    // if (await canLaunchUrl(emailLaunchUri)) {
    //   await launchUrl(emailLaunchUri);
    // }
  }

  @override
  Widget build(BuildContext context) {
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
                  'Help and Support'.text22Black700(),
                  SizedBox(width: 50),
                ],
              ),
              const Text(
                "If you need help or have any questions about your tour, our support team is ready to help you.\n\nSend an email to ",
                style: TextStyle(fontSize: 14),
              ),
              GestureDetector(
                onTap: _launchEmail,
                child: const Text(
                  "contact@thatchr.app",
                  style: TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const Spacer(),
              WideCustomButton(text: 'Submit', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
