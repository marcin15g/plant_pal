import 'package:flutter/material.dart';
import 'package:plantpal/models/plant.dart';

class PlantTile extends StatelessWidget {
  final Plant plant;

  PlantTile({this.plant});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Image.network(
            plant.imageUrl,
            fit: BoxFit.cover
          ),
        ),
      ),
    );
  }
}
