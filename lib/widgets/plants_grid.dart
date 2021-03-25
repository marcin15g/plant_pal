import 'package:flutter/material.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/widgets/plant_tile.dart';
import 'package:provider/provider.dart';

class PlantsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final plantsProvider = Provider.of<Plants>(context);
    final plants = plantsProvider.plants;

    return GridView.builder(
      padding: EdgeInsets.all(15.0),
      itemCount: plants.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: plants[i],
        child: PlantTile(plant: plants[i])
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 /2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15
      ),
    );
  }
}