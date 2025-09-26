import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';

import '../../../../offer/presentation/screens/common/create_first_service_screen.dart';

class StripeConnectFullScreen extends StatefulWidget {
  final String connectUrl;

  const StripeConnectFullScreen({super.key, required this.connectUrl});

  @override
  State<StripeConnectFullScreen> createState() =>
      _StripeConnectFullScreenState();
}

class _StripeConnectFullScreenState extends State<StripeConnectFullScreen> {
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _openStripeUrl();
    _listenDeepLinks();
  }

  Future<void> _openStripeUrl() async {
    final url = Uri.parse(widget.connectUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not launch Stripe Connect");
    }
  }

  void _listenDeepLinks() {
    _appLinks = AppLinks();

    // Listen for incoming deep links
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri == null) return;

      debugPrint("Deep link received: $uri");

      if (uri.toString().contains("stripe/success")) {
        Get.offAll(() => CreateFirstServiceScreen());
      } else if (uri.toString().contains("stripe/cancel")) {
        Get.back();
        Get.snackbar("Cancelled", "Stripe onboarding was cancelled");
      }
    }, onError: (err) {
      debugPrint("Deep link error: $err");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Stripe Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: const Center(
        child: Text(
          "Redirecting to Stripe…\nPlease complete onboarding in your browser.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
