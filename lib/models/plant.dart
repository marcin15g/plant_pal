import 'package:flutter/cupertino.dart';

class Plant with ChangeNotifier {
  final String commonName;
  final String scientificName;
  final String imageUrl;

  Plant({
    this.commonName,
    this.scientificName,
    this.imageUrl
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      commonName: json['common_name'],
      scientificName: json['scientific_name'],
      imageUrl: json['image_url']
    );
  }
}