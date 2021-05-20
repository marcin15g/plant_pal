import 'package:flutter/material.dart';
import 'package:plantpal/database.dart';
import 'package:plantpal/models/collection_plant.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/widgets/assistant_widgets/a_plant_tile.dart';
import 'package:provider/provider.dart';

class AssistantScreen extends StatefulWidget {
  @override
  _AssistantScreenState createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {

  void initState() {
    Provider.of<Plants>(context, listen: false).fetchAssistantPlants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Plants plantsProvider = Provider.of<Plants>(context);
    final List<CollectionPlant> assistantPlants = plantsProvider.assistantPlants;

    callback(int index) {
      setState(() {
        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);

        assistantPlants[index].lastWatering = date;
        updateCollectionPlant(assistantPlants[index]);
      });
    }

    return Container(
      padding: EdgeInsets.all(15.0),
      child: ListView.builder(
        itemCount: assistantPlants.length,
        itemBuilder: (_, index) {
          return AssistantPlantTile(assistantPlants[index], index, callback);
        },
      )
    );
  }
}