import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantpal/screens/login.dart';
import 'package:plantpal/auth.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  final Map<String, User> userInfo;

  MainDrawer(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(),
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.green[900]),
                          height: 150,
                          width: double.infinity,
                          child: Stack(alignment: Alignment.center, children: [
                            Image.asset(
                              'assets/placeholder.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Text(
                              "Plant Pal",
                              style: TextStyle(
                                  fontFamily: 'Pacifico',
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                        ),
                        ListTile(
                          leading: Icon(Icons.api),
                          title: Text('More about Trefle.io'),
                          onTap: () {
                            _launchURL('https://trefle.io');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.code),
                          title: Text('Checkout this project on GitHub'),
                          onTap: () {
                            _launchURL(
                                "https://github.com/marcin15g/plant_pal");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.list_alt),
                          title: Text('Flutter Documentation'),
                          onTap: () {
                            _launchURL('https://flutter.dev/docs');
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                color: Colors.green[900],
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  leading: ClipRRect(
                    child: Image.network(userInfo['user'].photoURL),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userInfo['user'].displayName,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  trailing: GestureDetector(
                    child: Container(
                      child: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      signOutGoogle();
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw "Can't launch";

// DrawerHeader(
//   padding: EdgeInsets.zero,
//   child: Container(
//     padding: EdgeInsets.zero,
//     child: Text("Plant Pal"),
//   ),
// ),
