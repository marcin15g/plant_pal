import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plantpal/database.dart';
import 'package:plantpal/models/collection_plant.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/screens/assistant_screen.dart';
import 'package:plantpal/screens/collection_screen.dart';
import 'package:plantpal/screens/new_plant_screen.dart';
import 'package:plantpal/screens/plants_overview_screen.dart';
import 'package:plantpal/widgets/main_drawer.dart';
import 'package:plantpal/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': CollectionScreen(), 'title': 'My Collection'},
    {'page': PlantsOverviewScreen(), 'title': 'Browse'},
    {'page': AssistantScreen(), 'title': 'Assistant'}
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _selectedPageIndex = 1;
  String _nickname;
  String _commonName;

  void _selectPage(int index) {
    print(index);
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _searchForPlants(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: SearchBar(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, User> userInfo =
        ModalRoute.of(context).settings.arguments as Map<String, User>;
        String _imageUrl;
        File _image;
        final plantsProvider = Provider.of<Plants>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        actions: _selectedPageIndex == 1
            ? <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () => _searchForPlants(context),
                    child: Icon(
                      Icons.search,
                      size: 24.0,
                    ),
                  ),
                )
              ]
            : null,
      ),
      drawer: MainDrawer(userInfo),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _selectPage(index),
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'My collection'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), label: 'Browse'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in_sharp), label: 'Assistant')
        ],
      ),
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NewPlantScreen.routeName);
                // showDialog(
                //   context: context,
                //   builder: (context) {
                //     return StatefulBuilder(builder: (context, setState) {
                //       //form here
                //       // return _buildPopupDialog(context, setState, _imageUrl);
                //     });
                //   },
                // );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              elevation: 6,
            )
          : null,
    );
  }
}
