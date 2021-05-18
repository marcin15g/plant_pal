import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plantpal/database.dart';
import 'package:plantpal/models/collection_plant.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:provider/provider.dart';

class NewPlantScreen extends StatefulWidget {
  static const routeName = '/new-plant';

  @override
  _NewPlantScreenState createState() => _NewPlantScreenState();
}

class _NewPlantScreenState extends State<NewPlantScreen> {
  String _imageUrl = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final plantsProvider = Provider.of<Plants>(context);    
    final plantData = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final CollectionPlant plant = plantData != null ? plantData['plant'] : null;
    final bool editMode = plant != null ? true : false;
    String _nickname = "";
    String _commonName = "";

    final spinkit = SpinKitFadingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Colors.green)
        );
      },
    );

    if(plant != null) {
      _nickname = plant.nickName;
      _commonName = plant.commonName;
      _imageUrl = plant.imageUrl;
    }

    _loadCameraImage() async {
      final _storage = FirebaseStorage.instance;
      final _picker = ImagePicker();
      PickedFile image;

      await Permission.camera.request();
      var permissionStatus = await Permission.camera.status;
      if (permissionStatus.isGranted) {
        image = await _picker.getImage(source: ImageSource.camera);
        var file = File(image.path);
        if (image != null) {
          var snapshot = await _storage
              .ref()
              .child(DateTime.now().toString())
              .putFile(file);

          var downloadUrl = await snapshot.ref.getDownloadURL();
          setState(() {
            _imageUrl = downloadUrl;
          });
        } else {
          print('No path');
        }
      } else {
        print('Grant Permissions and try again!');
      }
    }

    _loadGalleryImage() async {
      final _storage = FirebaseStorage.instance;
      final _picker = ImagePicker();
      PickedFile image;

      await Permission.photos.request();
      var permissionStatus = await Permission.photos.status;
      if (permissionStatus.isGranted) {
        image = await _picker.getImage(source: ImageSource.gallery);
        var file = File(image.path);
        if (image != null) {
          var snapshot = await _storage
              .ref()
              .child(DateTime.now().toString())
              .putFile(file);

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
    }

    _uploadPLant() {
      //UPLOAD NEW PLANT TO COLLECTION
      if (!_formKey.currentState.validate()) return;
      _formKey.currentState.save();
      var newPlant = new CollectionPlant(
          nickName: _nickname,
          commonName: _commonName,
          imageUrl: _imageUrl);
      editMode ? updateCollectionPlant(newPlant) : saveCollectionPlant(newPlant);
      _formKey.currentState.reset();
      _imageUrl = _nickname = _commonName = "";
      plantsProvider.fetchCollectionPlants();
      Navigator.of(context).pop();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(editMode ? 'Edit plant' : 'Add new plant'),
        ),
        body: Container(
          child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: _imageUrl != null && _imageUrl != ''
                              ? CachedNetworkImage(
                                  placeholder: (context, url) => spinkit,
                                  imageUrl: _imageUrl,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/placeholder.jpg',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 100.0,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: 100.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: _loadCameraImage,
                                  child: Icon(
                                    Icons.camera,
                                    size: 40.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: _loadGalleryImage,
                                  child: Icon(Icons.image, size: 40.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(25.0),
                        child: Column(
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
                              controller:
                                  new TextEditingController(text: _commonName),
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
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: _uploadPLant,
                                child: Text(editMode ? 'UPDATE' : 'ADD')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
