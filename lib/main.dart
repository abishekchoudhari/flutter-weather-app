import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/views/weather_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: WeatherPage(),
        ),
    );
  }
}
