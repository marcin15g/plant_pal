import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plantpal/models/plant_details.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/widgets/overview_widgets/plant_details.dart';
import 'package:provider/provider.dart';

class PlantDetailScreen extends StatelessWidget {
  static const routeName = '/plant-detail';

  @override
  Widget build(BuildContext context) {
    final plantData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Future<PlantDetails> plant =
        Provider.of<Plants>(context).fetchPlantDetails(plantData['id']);

  final spinkit = SpinKitFadingCube(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(color: Colors.green)
      );
    },
  );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          plantData['name'],
        ),
      ),
      body: FutureBuilder(
        future: plant,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return spinkit;
            default:
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return PlantDetailsWidget(snapshot.data);
          }
        },
      ),
    );
  }
}

// Function plantDetails(PlantDetails plant) {
//   return
// }
