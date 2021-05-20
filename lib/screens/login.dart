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
    return OutlinedButton(
      onPressed: this.click,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)))),
      child: Container(
        height: 60,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Image.asset(
                'assets/google_logo.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            // SizedBox(
            //   width: 30,
            // ),
            Expanded(
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: new BoxDecoration(color: Color.fromRGBO(255, 254, 229, 1)),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/placeholder.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(
                "Plant Pal",
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 70.0,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ),
            googleLoginButton()
            // Align(alignment: Alignment.bottomCenter, child: googleLoginButton()),
          ],
        ));
  }
}
