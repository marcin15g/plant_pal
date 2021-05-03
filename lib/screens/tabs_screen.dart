import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plantpal/models/plant.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/screens/assistant_screen.dart';
import 'package:plantpal/screens/collection_screen.dart';
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

    return Scaffold(
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
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return Form(
                        key: _formKey,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          titlePadding: EdgeInsets.all(0.0),
                          title: Container(
                            height: 200.0,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              child: _imageUrl != null
                                  ? FadeInImage.assetNetwork(placeholder: 'assets/placeholder.jpg', image: _imageUrl, fit: BoxFit.cover,)
                                  : Image.asset(
                                      'assets/placeholder.jpg',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: "Nickname"),
                                validator: (String value) {
                                  return value.isEmpty
                                      ? 'Please enter Nickname'
                                      : null;
                                },
                                controller:
                                    new TextEditingController(text: _nickname),
                                onSaved: (String value) {
                                  _nickname = value;
                                },
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: "Common Name"),
                                controller: new TextEditingController(
                                    text: _commonName),
                                validator: (String value) {
                                  return value.isEmpty
                                      ? 'Please enter Common Name'
                                      : null;
                                },
                                onSaved: (String value) {
                                  _commonName = value;
                                },
                              )
                            ],
                          ),
                          actions: <Widget>[
                            //UPLOAD IMAGE FROM CAMERA
                            new TextButton(
                              child: Icon(Icons.camera),
                              onPressed: () async {
                                final _storage = FirebaseStorage.instance;
                                final _picker = ImagePicker();
                                PickedFile image;

                                await Permission.camera.request();
                                var permissionStatus = await Permission.camera.status;
                                if (permissionStatus.isGranted) {
                                  print("GRANTED");
                                  image = await _picker.getImage(source: ImageSource.camera);
                                  var file = File(image.path);
                                  if (image != null) {
                                    var snapshot =
                                        await _storage.ref().child(DateTime.now().toString()).putFile(file);

                                    var downloadUrl = await snapshot.ref.getDownloadURL();
                                    print(downloadUrl);
                                    setState(() {
                                        _imageUrl = downloadUrl;
                                    });
                                  } else {
                                    print('No path');
                                  }
                                } else {
                                  print('Grant Permissions and try again!');
                                }    
                              },
                            ),
                            //UPLOAD IMAGE FROM GALLERY
                            new TextButton(
                              child: Icon(Icons.image),
                              onPressed: () async {
                                final _storage = FirebaseStorage.instance;
                                final _picker = ImagePicker();
                                PickedFile image;

                                await Permission.photos.request();
                                var permissionStatus = await Permission.photos.status;
                                if (permissionStatus.isGranted) {
                                  print("GRANTED");
                                  image = await _picker.getImage(source: ImageSource.gallery);
                                  var file = File(image.path);
                                  if (image != null) {
                                    var snapshot =
                                        await _storage.ref().child(DateTime.now().toString()).putFile(file);

                                    var downloadUrl = await snapshot.ref.getDownloadURL();
                                    print(downloadUrl);
                                    setState(() {
                                      _imageUrl = downloadUrl;
                                    });
                                  } else {
                                    print('No path');
                                  }
                                } else {
                                  print('Grant Permissions and try again!');
                                }
                              },
                            ),
                            new TextButton(
                              onPressed: () {
                                // Navigator.of(context).pop();
                                if (!_formKey.currentState.validate()) return;
                                _formKey.currentState.save();

                                print(_nickname + "     " + _commonName);
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      );
                      // return _buildPopupDialog(context, setState, _imageUrl);
                    });
                  },
                );
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
