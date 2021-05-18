import 'dart:convert' as convert;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:plantpal/database.dart';
import 'package:plantpal/models/collection_plant.dart';
import 'package:plantpal/models/plant.dart';
import 'package:plantpal/models/plant_details.dart';

class Plants with ChangeNotifier {
  
  static String token = 'H7bfxssQjiaQ6aIUMlEL';


  List<Plant> _plants = [];
  List<CollectionPlant> _collectionPlants = [];

  List<Plant> get plants {
    return [..._plants];
  }

  List<CollectionPlant> get collectionPlants {
    return [..._collectionPlants];
  }

  Future<void> fetchCollectionPlants() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String uid = auth.currentUser.uid;
    final List<CollectionPlant> collPlantsArray = [];


    DataSnapshot snapshot = await fetchCollectionPlantsFromDB(uid);
    snapshot.value.forEach((key, value) => {
      collPlantsArray.add(CollectionPlant.fromSnapshot(key, value))
    });

    _collectionPlants = collPlantsArray;
    notifyListeners();
  }

  Future<void> fetchDemoPlants() async {
    final url = Uri.https('api.floracodex.com', 'api/v1/plants/search', {'q': 'lily','token': token});
    final http.Response response = await http.get(url);
    List<Plant> fetchedPlants = [];

    if(response.statusCode == 200) {
      final jsonDataArray = convert.jsonDecode(response.body)['data'];

      for(var i=0; i<jsonDataArray.length; i++) {
        fetchedPlants.add(Plant.fromJson(jsonDataArray[i]));
      }
      _plants = fetchedPlants;
      notifyListeners();
    }
    else {
      throw Exception('Failed to load demo plants');
    }
    
    // List<Plant> fetchedPlants = [];
    // var jsonDataArray = convert.jsonDecode(await rootBundle.loadString('assets/json/demo/demo.json'));
    // for(var i=0; i<jsonDataArray.length; i++) {
    //   fetchedPlants.add(Plant.fromJson(jsonDataArray[i]));
    // }
      _plants = fetchedPlants;
      notifyListeners();   
  }

  Future<void> searchForPlants(String searchInput) async {
    final url = Uri.https('api.floracodex.com', 'api/v1/plants/search', {'q': searchInput,'token': token});
    final http.Response response = await http.get(url);
    List<Plant> fetchedPlants = [];

    if(response.statusCode == 200) {
      final jsonDataArray = convert.jsonDecode(response.body)['data'];

      for(var i=0; i<jsonDataArray.length; i++) {
        fetchedPlants.add(Plant.fromJson(jsonDataArray[i]));
      }
      _plants = fetchedPlants;
      notifyListeners();
    }
    else {
      throw Exception('Failed to load plants');
    }   
  }

  Future<PlantDetails> fetchPlantDetails(String plantId) async {
    final url = Uri.https('api.floracodex.com', 'api/v1/plants/' + plantId, {'token': token});
    final http.Response response = await http.get(url);

    if(response.statusCode == 200) {
      final jsonData = convert.jsonDecode(response.body)['data'];
      final plantDetails = PlantDetails.fromJson(jsonData);
      return plantDetails;
      // return jsonData;
    }
    else {
      throw Exception('Failed to load plant details');
    }    
  
      // var jsonData = convert.jsonDecode(await rootBundle.loadString('assets/json/demo/details.json'));
      // final plantDetails = PlantDetails.fromJson(jsonData);
      // return plantDetails;
  }
}