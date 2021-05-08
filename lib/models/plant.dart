import 'package:flutter/cupertino.dart';

class Plant with ChangeNotifier {
  final int id;
  final String commonName;
  final String scientificName;
  final String imageUrl;

  Plant({
    this.id,
    this.commonName,
    this.scientificName,
    this.imageUrl
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      commonName: json['common_name'],
      scientificName: json['scientific_name'],
      imageUrl: json['image_url']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commonName': this.commonName,
      'scientificName': this.scientificName,
      'imageUrl': this.imageUrl
    };
  }
}