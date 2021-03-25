import 'package:flutter/material.dart';
import 'package:plantpal/models/plant_details.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:provider/provider.dart';

class PlantDetailScreen extends StatelessWidget {

  static const routeName = '/plant-detail';

  @override
  Widget build(BuildContext context) {

    final plantData = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print(plantData);

    final Future<PlantDetails> plant = Provider.of<Plants>(context).fetchPlantDetails(plantData['id']);

    return Scaffold(
      appBar: AppBar(title: Text(plantData['name'],),),
      body: FutureBuilder(
      future: plant,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting: return Text('LOADING');
          default: 
            if(snapshot.hasError) return Text(snapshot.error.toString());
            else return Text(snapshot.data.toString());
        }
      },
    ),
    );

  }
}

// Function plantDetails(PlantDetails plant) {
//   return 
// }