import 'package:flutter/cupertino.dart';

class CollectionPlant with ChangeNotifier {
  final String id;
  final String nickName;
  final String commonName;
  final String imageUrl;
  bool assistantEnabled = false;
  int daysAmount = 3;
  DateTime lastWatering;

  CollectionPlant({
    this.id,
    this.nickName,
    this.commonName,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {  
      'nickName': this.nickName,
      'commonName': this.commonName,
      'imageUrl': this.imageUrl,
      'assistantEnabled': this.assistantEnabled,
      'daysAmount': this.daysAmount,
      'lastWatering': this.lastWatering.toString()
    };
  }

  factory CollectionPlant.fromSnapshot(key, value) {
    
    final plant = new CollectionPlant(
      id: key,
      nickName: value['nickName'],
      commonName: value['commonName'],
      imageUrl: value['imageUrl']
    );
    plant.assistantEnabled = value['assistantEnabled'];
    plant.daysAmount = value['daysAmount'];
    print(value['lastWatering'].runtimeType);
    plant.lastWatering = value['lastWatering'] != 'null' ? DateTime.parse(value['lastWatering']) : null; 

    return plant;
  }

}