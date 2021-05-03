import 'package:flutter/cupertino.dart';

class PlantDetails with ChangeNotifier {
  final int id;
  final String commonName;
  final String scientificName;
  final String imageUrl;
  final int year;
  final Object images;
  final String bibliography;
  final String familyCommonName;
  final String observations;
  final bool vegetable;
  final bool edible;
  final String ediblePart;

  PlantDetails({
    this.id,
    this.commonName,
    this.scientificName,
    this.imageUrl,
    this.year,
    this.images,
    this.bibliography,
    this.familyCommonName,
    this.observations,
    this.vegetable,
    this.edible,
    this.ediblePart
  });

  factory PlantDetails.fromJson(Map<String, dynamic> json) {
    return PlantDetails(
      id: json['id'],
      commonName: json['common_name'],
      scientificName: json['scientific_name'],
      imageUrl: json['image_url'],
      year: json['year'],
      images: json['images'],
      bibliography: json['bibliography'],
      familyCommonName: json['family_common_name'],
      observations: json['observations'],
      vegetable: json['vegetable'],
      edible: json['edible'],
      ediblePart: json['edible_part']
    );
  }
}