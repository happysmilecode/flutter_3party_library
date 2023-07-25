import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:line/auth/firebase_phone/sign_with_phone.dart';
import 'package:line/auth/line/sign_with_line.dart';
import 'package:line/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LineSDK.instance
      .setup("2000073944")
      .then((_) => print("Line prepared"));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const AuthWithLine(title: "Auth with Line"),
        '/phone': (context) => PhoneScreen(),
      },
      initialRoute: '/',
    );
  }
}
