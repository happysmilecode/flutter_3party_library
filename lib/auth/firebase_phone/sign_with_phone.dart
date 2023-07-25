import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line/auth/firebase_phone/home_screen.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({Key? key}) : super(key: key);

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<void> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (verificationCompleted) async {
        Navigator.pop(context);
        UserCredential result =
            await _auth.signInWithCredential(verificationCompleted);

        User? user = result.user;
        if (user != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
        } else {
          print("Phone Auth error");
        }
      },
      verificationFailed: (verificationFailed) {
        print("Phone Failed: $verificationFailed");
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Give the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _codeController,
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);
                        UserCredential result =
                            await _auth.signInWithCredential(credential);
                        User? user = result.user;
                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(user: user)));
                        } else {
                          print("Phone Auth error");
                        }
                      },
                      child: Text("Confirm"))
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey)),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Mobile Number"),
                  controller: _phoneController,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    child: Text("LOGIN"),
                    onPressed: () {
                      final phone = _phoneController.text.trim();

                      loginUser(phone, context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
