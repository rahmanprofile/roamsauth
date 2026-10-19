import 'dart:convert';
import 'package:example/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:roamsauth/service/web/web_roamsauth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROAMSAUTH 2.0 ~ CMM CRIS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: WebRoamsauth(
        onSuccess: (Map<String, dynamic> token) async {
          print("onSuccess response: ${jsonEncode(token)}");
          Navigator.push(context, MaterialPageRoute(builder: (context) =>SuccessScreen()));
        },
        onError: (Map<String, dynamic> error) {
          print("onError response: ${jsonEncode(error)}");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error['message'])));
        },
      ),
    );
  }
}
