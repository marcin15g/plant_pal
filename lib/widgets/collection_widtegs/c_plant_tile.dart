import 'package:flutter/material.dart';
import 'package:plantpal/database.dart';
import 'package:plantpal/models/collection_plant.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/screens/new_plant_screen.dart';
import 'package:provider/provider.dart';

class CollectionPlantTile extends StatelessWidget {
  final CollectionPlant plant;
  CollectionPlantTile({this.plant});

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
                    ? FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.jpg',
                        image: plant.imageUrl,
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
        child: Image.network(
          plant.imageUrl,
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
