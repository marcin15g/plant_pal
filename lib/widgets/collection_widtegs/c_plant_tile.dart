import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plantpal/database.dart';
import 'package:plantpal/models/collection_plant.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/screens/collection_details_screen.dart';
import 'package:plantpal/screens/new_plant_screen.dart';
import 'package:provider/provider.dart';

class CollectionPlantTile extends StatelessWidget {
  final CollectionPlant plant;
  CollectionPlantTile({this.plant});

  final spinkit = SpinKitFadingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Colors.green)
        );
      },
    );

  @override
  Widget build(BuildContext context) {
    final plantsProvider = Provider.of<Plants>(context);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
                child: plant.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: plant.imageUrl,
                        placeholder: (context, url) => spinkit,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/placeholder.jpg',
                        fit: BoxFit.cover,
                      )),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.green,
              borderRadius: BorderRadius.circular(10),
              onLongPress: () {
                showAlertDialog(context, plantsProvider,  plant);
              },
              onTap: () {
                Navigator.of(context).pushNamed(CollectionDetailsScreen.routeName, arguments: {"plant": plant});
              },
            ),
          ),
        )
      ],
    );
  }
}

showAlertDialog(BuildContext context, Plants plantsProvider, CollectionPlant plant) {

  
  // Edit Button
  Widget editButton = ElevatedButton(
    child: Text("EDIT"),
    onPressed: () {
      print("EDIT");
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(NewPlantScreen.routeName, arguments: {'plant': plant,});
    },
  );
  Widget removeButton = ElevatedButton(
    child: Text("REMOVE"),
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
    onPressed: () {
      removeCollectionPlant(plant.id);
      plantsProvider.fetchCollectionPlants();
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    titlePadding: EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
    title: Container(
      height: 200.0,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: CachedNetworkImage(
          imageUrl: plant.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    ),
    content: Text(
      "What would you like to do with ${plant.nickName}?",
      textAlign: TextAlign.center,
    ),
    actions: [
      editButton,
      removeButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
