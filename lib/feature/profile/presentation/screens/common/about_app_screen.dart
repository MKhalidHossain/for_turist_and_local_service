import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text("About App"),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi lobortis risus eget magna euismod rhoncus. Vivamus eu lectus et lectus interdum placerat.\n\n"
            "Praesent consectetur ante orci, non mattis massa posuere in. Integer blandit ut mi eu efficitur. Praesent congue, arcu vitae malesuada vehicula, lacus velit facilisis velit, ut vehicula sapien erat id dui. Proin nisi ante, ullamcorper vitae libero eu, mollis venenatis lectus. Integer auctor et sem at sollicitudin. Sed eget diam nisi. Nulla in id.\n\n"
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
