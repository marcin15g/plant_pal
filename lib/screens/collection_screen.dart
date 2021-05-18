import 'package:flutter/material.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/widgets/collection_widtegs/c_plant_tile.dart';
import 'package:provider/provider.dart';

class CollectionScreen extends StatefulWidget {
  
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  void initState() {
    Provider.of<Plants>(context, listen: false).fetchCollectionPlants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final plantsProvider = Provider.of<Plants>(context);
    final collectionPlants = plantsProvider.collectionPlants;

    return GridView.builder(
      padding: EdgeInsets.all(15.0),
      itemCount: collectionPlants.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: collectionPlants[i],
        child: CollectionPlantTile(
          plant: collectionPlants[i],
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15),
    );
  }
}
