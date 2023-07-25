import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

class AuthWithLine extends StatefulWidget {
  const AuthWithLine({super.key, required this.title});

  final String title;

  @override
  State<AuthWithLine> createState() => _AuthWithLineState();
}

class _AuthWithLineState extends State<AuthWithLine> {
  Future<void> _lineLogin(BuildContext context) async {
    try {
      final result = await LineSDK.instance.login(scopes: ['profile']);
      print(
          "result" + result.toString() + " :" + result.userProfile.toString());
    } catch (e) {
      print("error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
                onPressed: () => _lineLogin(context),
                child: Container(
                  child: Text("Login by Line"),
                )),
            OutlinedButton(
                onPressed: () => Navigator.of(context).pushNamed('/phone'),
                child: Container(
                  child: Text("Login by Phone"),
                ))
          ],
        ),
      ),
    );
  }
}
