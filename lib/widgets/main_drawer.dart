import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:plantpal/notification_service.dart';
import 'package:plantpal/screens/login.dart';
import 'package:plantpal/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class MainDrawer extends StatelessWidget {
  final Map<String, User> userInfo;
  MainDrawer(this.userInfo);

  showAlertDialog(BuildContext context) {
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      title: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Positioned(
            top: 0,
            child: Container(
              transform: Matrix4.translationValues(0.0, -80.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/avatar.jpeg'),
                              fit: BoxFit.fitHeight,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      content: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '',
          style: DefaultTextStyle.of(context).style,
          children: const <TextSpan>[
            TextSpan(
                text: 'Hello!\n\n',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            TextSpan(text: "My name is ", style: TextStyle(fontSize: 20.0)),
            TextSpan(
                text: 'Marcin',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            TextSpan(
                text: ' and I\'m a student at ',
                style: TextStyle(fontSize: 20.0)),
            TextSpan(
                text: 'Rzeszów University of Technology. \n\n',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'The app you are currently using has been built by me as my graduation project. \n',
                style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                onPressed: () {
                  launchMail();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Contact me', style: TextStyle(fontSize: 25.0)),
                ),
              ),
            ),
          ]),
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  launchMail() async {
    final mailtoLink = Mailto(to: ['marcin15g@gmail.com']);
    await launch('$mailtoLink');
  }

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
                              'assets/login_bg.jpg',
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
                          title: Text('More about FloraCodex'),
                          onTap: () {
                            _launchURL('https://floracodex.com');
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
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('About Author'),
                          onTap: () {
                            Navigator.of(context).pop();
                            showAlertDialog(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(bottom: 10.0),
            //   child: ListTile(
            //     leading: Icon(Icons.person),
            //     title: Text('About Author'),
            //     onTap: () {
            //       Navigator.of(context).pop();
            //       showAlertDialog(context);
            //     },
            //   ),
            // ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                color: Colors.green[900],
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      NotificationService().showNotification();
                    },
                    child: ClipRRect(
                      child: Image.network(userInfo['user'].photoURL),
                      borderRadius: BorderRadius.circular(50),
                    ),
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
