import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantpal/screens/tabs_screen.dart';
import 'package:plantpal/auth.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String name;
  TextEditingController controller = new TextEditingController();
  User user;

  void click() {
    signInWithGoogle().then((user) {
      print(user);
      Navigator.of(context)
          .pushNamed(TabScreen.routeName, arguments: {"user": user});
    });
  }

  Widget googleLoginButton() {
    // return ElevatedButton(
    //   onPressed: this.click,
    //   style: ButtonStyle(

    //   ),
    //   child: Text('Sign in with Google '),
    // );
    //
    return Padding(
      padding: EdgeInsets.only(bottom: 200),
      child: OutlinedButton(
          onPressed: this.click,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)))),
          child: Container(
            height: 60,
            width: 220,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image.asset(
                    'assets/google_logo.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Sign in with Google',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Color.fromRGBO(255, 254, 229, 1)),
      child:
          Align(alignment: Alignment.bottomCenter, child: googleLoginButton()),
    );
  }
}