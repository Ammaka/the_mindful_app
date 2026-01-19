import 'package:flutter/material.dart';
import 'package:mindful_app/data/sp_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController username = TextEditingController();
  final List<String> _images = ["sky", "shore", "beach", "lake"];
  String _selectedImage = "sky";
  final SpHelper sphelper = SpHelper();

  @override
  void initState() {
    getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: const InputDecoration(hintText: "Enter your name"),
            ),
            DropdownButton<String>(
              value: _selectedImage,
              items: _images.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newvalue) {
                setState(() {
                  _selectedImage = newvalue ?? "sky";
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveSettings().then((value) {
            String message = value
                ? "Settings have been saved"
                : "Settings could not be saved";
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 3),
              ),
            );
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<bool> saveSettings() async {
    return await sphelper.setSettings(username.text, _selectedImage);
  }

  Future<void> getSettings() async {
    final Map<String, String> settings = await sphelper.getSettings();
    _selectedImage = settings["image"] ?? "lake";
    username.text = settings["name"] ?? " ";
    if (_selectedImage == '') {
      _selectedImage = 'lake';
    }
    setState(() {});
  }

  @override
  dispose() {
    username.dispose();
    super.dispose();
  }
}
