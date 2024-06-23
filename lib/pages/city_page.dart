import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  const CityPage({super.key});

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  String? cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (String inputValue) {
                cityName = inputValue;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: const Text("SUBMIT"))
          ],
        ),
      ),
    );
  }
}

// Navigator.pop(context, cityName);