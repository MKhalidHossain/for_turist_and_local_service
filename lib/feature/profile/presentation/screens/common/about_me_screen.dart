import 'package:flutter/material.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';

import '../../../../../core/widgets/wide_custom_button.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

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
                  'About Me'.text22Black700(),
                  SizedBox(width: 50),
                ],
              ),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam venenatis, magna ac auctor posuere, sem elit condimentum sapien, vel placerat velit diam vel felis. Ut varius elementum efficitur. Mauris ac dignissim urna, quis tempus neque. Vivamus ipsum ligula, faucibus sit amet ornare nec, ultrices ut velit. Pellentesque finibus elementum interdum. Donec suscipit risus purus, vitae iaculis odio iaculis at. Curabitur et nisl tempor, luctus mi ac, rutrum augue. Ut condimentum diam a massa sollicitudin finibus. Maecenas convallis augue id ipsum gravida blandit. Duis sollicitudin ante non sapien aliquet pellentesque. ",
                style: TextStyle(fontSize: 14),
              ),
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
              WideCustomButton(text: 'Save', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
