import 'package:flutter/material.dart';
import 'package:location_tracking/pages/home_page/home_page.dart';
import 'package:location_tracking/utilities/services/database_service.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Location Tracking', theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)), home: const HomePage());
  }
}
