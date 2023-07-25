import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("You are Logged in successfully",
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 32)),
            SizedBox(
              height: 20,
            ),
            Text(
              "${user.phoneNumber}",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
