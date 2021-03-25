import 'package:flutter/cupertino.dart';

class PlantDetails with ChangeNotifier {
  final int id;
  final String commonName;
  final String scientificName;
  final String imageUrl;

  PlantDetails({
    this.id,
    this.commonName,
    this.scientificName,
    this.imageUrl
  });

  factory PlantDetails.fromJson(Map<String, dynamic> json) {
    return PlantDetails(
      id: json['id'],
      commonName: json['common_name'],
      scientificName: json['scientific_name'],
      imageUrl: json['image_url']
    );
  }
}