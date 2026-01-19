import 'package:flutter/material.dart';
import 'package:mindful_app/screens/quote_screen.dart';

import '../data/sp_helper.dart';

class Introscreen extends StatefulWidget {
  const Introscreen({super.key});

  @override
  State<Introscreen> createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  String name = " ";
  String image = "lake";

  @override
  void initState() {
    super.initState();
    final SpHelper helper = SpHelper();
    helper.getSettings().then((settings) {
      name = settings["name"] ?? " ";
      image = settings["image"] ?? "lake";
      if (image == '') image = 'lake';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/$image.jpg', fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment(0, -0.5),
            child: Text(
              "welcome $name",
              style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 15.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
                fontSize: 32,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const QuoteScreen(),
                  ),
                );
              },
              child: const Text("start"),
            ),
          ),
        ],
      ),
    );
  }
}
