import 'package:flutter/material.dart';
import 'package:plantpal/models/plant.dart';
import 'package:plantpal/screens/plant_details_screen.dart';

class PlantTile extends StatelessWidget {
  final Plant plant;

  PlantTile({this.plant});

  

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              PlantDetailScreen.routeName,
              arguments: {'id': plant.id, 'name': plant.commonName}
            );
          },
          child: plant.imageUrl != null ? FadeInImage.assetNetwork(placeholder: 'assets/placeholder.jpg', image: plant.imageUrl, fit: BoxFit.cover,) : Image.asset('assets/placeholder.jpg', fit: BoxFit.cover,)
        ),
        footer: Container(
          height: 80,
          child: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Container(
                margin: EdgeInsets.all(10),
                // child: Icon(
                //   Icons.favorite,
                //   color: Colors.grey,
                // )),
            ),
            title: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    plant.commonName != null ? plant.commonName : '',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    plant.scientificName != null ? plant.scientificName : '',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
