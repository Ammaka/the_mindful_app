import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mindful_app/screens/settings_screen.dart';

import '../data/quote.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  static const address = "https://zenquotes.io/api/random";
  Quote quote = Quote(text: '', author: '');

  @override
  void initState() {
    super.initState();
    //_fetchQuote().then((value) {
    //quote = value;
    //setState(() {});
    //});
  }

  Future _fetchQuote() async {
    final Uri url = Uri.parse(address);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List quotesJson = json.decode(response.body);
      final Quote quote = Quote.fromJSON(quotesJson[0]);
      return quote;
    } else {
      return Quote(text: "error retrieving Quote", author: '');
    }
  }

  void _goToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mindful Quotes"),
        actions: [
          IconButton(
            onPressed: _goToSettings,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _fetchQuote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error retrieving quote"));
          } else {
            Quote quote = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      quote.text,
                      style: const TextStyle(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      quote.author,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
