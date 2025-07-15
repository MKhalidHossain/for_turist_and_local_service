import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? drawer;
  final bool removePadding;
  final Widget? floatingActionButton;
  final bool resizeToAvoidBottomInset; // ✅ Add this

  const AppScaffold({
    super.key,
    this.appBar,
    this.drawer,
    required this.body,
    this.removePadding = false,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true, // ✅ Default to true
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: appBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset, // ✅ Correct placement
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: removePadding ? 0 : 18),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
