import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class CollectionPlant with ChangeNotifier {
  DatabaseReference _dbRef;
  final String id;
  final String nickName;
  final String commonName;
  final String imageUrl;

  CollectionPlant({
    this.id,
    this.nickName,
    this.commonName,
    this.imageUrl
  });

  // setId(String id) {
  //   this.id = id;
  // }


  Map<String, dynamic> toJson() {
    return {  
      'nickName': this.nickName,
      'commonName': this.commonName,
      'imageUrl': this.imageUrl
    };
  }

  factory CollectionPlant.fromSnapshot(key, value) {
    print(key);
    final plant = new CollectionPlant(
      id: key,
      nickName: value['nickName'],
      commonName: value['commonName'],
      imageUrl: value['imageUrl']
    );
    // plant.setId(key);
    return plant;
  }

}