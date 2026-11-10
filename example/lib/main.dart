import 'package:flutter/material.dart';
import 'package:roamsauth/roamsauth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROAMSAUTH ~ CMM CRIS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: WebRoamsauth(
        onSuccess: (Map<String, dynamic> token) {},
        onError: (Map<String, dynamic> error) {},
      ),
    );
  }
}
