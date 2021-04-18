import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantpal/screens/login.dart';
import 'package:plantpal/auth.dart';

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
                          child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/placeholder.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Text("Plant Pal",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),)
                              ]
                          ),
                        ),
                        ListTile(
                          title: Text('Item 1'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Item 2'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Item 3'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Item 4'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.green[900]),
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
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
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

// DrawerHeader(
//   padding: EdgeInsets.zero,
//   child: Container(
//     padding: EdgeInsets.zero,
//     child: Text("Plant Pal"),
//   ),
// ),
