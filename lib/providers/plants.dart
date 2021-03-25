import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:plantpal/models/plant.dart';
import 'package:plantpal/models/plant_details.dart';

class Plants with ChangeNotifier {
  
  static String token = 'tGDID0HQZK1PpArN2eGAKyoV5j7uiNcT2UJedHoR5H0';

  List<Plant> _plants = [];

  List<Plant> get plants {
    return [..._plants];
  }

  Future<void> fetchDemoPlants() async {
    final url = Uri.https('trefle.io', 'api/v1/plants', {'token': token});
    final http.Response response = await http.get(url);
    List<Plant> fetchedPlants = [];

    if(response.statusCode == 200) {
      final jsonDataArray = jsonDecode(response.body)['data'];

      for(var i=0; i<jsonDataArray.length; i++) {
        fetchedPlants.add(Plant.fromJson(jsonDataArray[i]));
      }
      _plants = fetchedPlants;
      notifyListeners();
    }
    else {
      throw Exception('Failed to load demo plants');
    }
  }

  Future<void> searchForPlants(String searchInput) async {
    final url = Uri.https('trefle.io', 'api/v1/plants/search', {'q': searchInput,'token': token});
    final http.Response response = await http.get(url);
    List<Plant> fetchedPlants = [];

    if(response.statusCode == 200) {
      final jsonDataArray = jsonDecode(response.body)['data'];

      for(var i=0; i<jsonDataArray.length; i++) {
        fetchedPlants.add(Plant.fromJson(jsonDataArray[i]));
      }
      _plants = fetchedPlants;
      _plants.forEach((element) {print(element.imageUrl);});
      notifyListeners();
    }
    else {
      throw Exception('Failed to load demo plants');
    }   
  }

  Future<PlantDetails> fetchPlantDetails(int plantId) async {
    final url = Uri.https('trefle.io', 'api/v1/plants/${plantId.toString()}', {'token': token});
    final http.Response response = await http.get(url);

    if(response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];
      final plantDetails = PlantDetails.fromJson(jsonData);

      print(jsonData);
      return plantDetails;
      // return jsonData;
    }
    else {
      throw Exception('Failed to load plant details');
    }    
  }
}