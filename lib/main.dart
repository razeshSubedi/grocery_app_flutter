import 'package:flutter/material.dart';
import 'package:grocery_app/Auth/ui/landing_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blueGrey.shade50,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(Colors.blue), // Button color
            foregroundColor:
                WidgetStateProperty.all(Colors.white), // Text color
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
            textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          labelStyle: TextStyle(color: Colors.blueGrey.shade700),
          hintStyle: TextStyle(color: Colors.blueGrey.shade400),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.blue),
            textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
            padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
          ),
        ),
      ),
      home: LandingPage(),
    );
  }
}