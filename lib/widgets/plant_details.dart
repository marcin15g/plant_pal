import 'package:flutter/material.dart';
import 'package:plantpal/models/plant_details.dart';

class PlantDetailsWidget extends StatelessWidget {
  final PlantDetails plantInfo;

  PlantDetailsWidget(this.plantInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: getImage(plantInfo.imageUrl),
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
          ),
          Container(
            width: double.infinity,
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            decoration: new BoxDecoration(
                color: Color.fromRGBO(255, 254, 229, 1),
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(50.0),
                    topRight: const Radius.circular(50.0))),
            child: Column(
              children: [
                Container(
                  height: 100.0,
                  width: MediaQuery.of(context).size.width * 0.8,
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          plantInfo.commonName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30.0),
                        ),
                        Text(
                          plantInfo.scientificName,
                          style: TextStyle(
                            fontSize: 18.0
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text('Im a test')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

getImage(String url) {
  return url != null
      ? FadeInImage.assetNetwork(
          placeholder: 'assets/placeholder.jpg',
          image: url,
          fit: BoxFit.cover,
        )
      : Image.asset(
          'assets/placeholder.jpg',
          fit: BoxFit.cover,
        );
}

infoRow(String title, String value, Icon icon, BuildContext context) {
  return Container(
    width: double.infinity,
    height: 100.0,
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Card(
        color: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 5.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Text(title),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              child: Text(
                value,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
