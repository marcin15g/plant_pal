import 'package:flutter/material.dart';
import 'package:plantpal/models/plant_details.dart';

class PlantDetailsWidget extends StatelessWidget {
  final PlantDetails plantInfo;

  PlantDetailsWidget(this.plantInfo);

  @override
  Widget build(BuildContext context) {
    print(plantInfo.images);
    return Stack(
      children: [
        Container(
          child: getImage(plantInfo.imageUrl),
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.infinity,
        ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.7,
            ),
            width: double.infinity,
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            decoration: new BoxDecoration(
                color: Color.fromRGBO(255, 254, 229, 1),
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(50.0),
                    topRight: const Radius.circular(50.0))),
            child: Container(
              child: Column(
                children: [
                  Container(
                    transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                    // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
                    height: 100.0,
                    width: MediaQuery.of(context).size.width * 0.8,
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
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  plantInfo.year != null ? infoRow("Year", plantInfo.year.toString(),
                      Icons.calendar_today, context)  : SizedBox(),
                  plantInfo.bibliography != null ? infoRow("Bibliography", plantInfo.bibliography.toString(),
                      Icons.book, context): SizedBox(),
                  plantInfo.familyCommonName != null ? infoRow("Family", plantInfo.familyCommonName.toString(),
                      Icons.supervised_user_circle_sharp, context): SizedBox(),
                  plantInfo.observations != null ? infoRow("Observations", plantInfo.observations.toString(),
                      Icons.search_rounded, context) : SizedBox(),
                  // plantInfo.edible
                  //     ? infoRow("Edible part", plantInfo.ediblePart.toString(),
                  //         Icons.calendar_today, context)
                  //     : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ],
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

infoRow(String title, String value, IconData icon, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(10.0),
    width: double.infinity,
    height: 80.0,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 5.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
