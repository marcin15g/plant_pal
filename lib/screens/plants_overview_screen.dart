import 'package:flutter/material.dart';
import 'package:plantpal/models/plant.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/widgets/plants_grid.dart';
import 'package:provider/provider.dart';

class PlantsOverviewScreen extends StatefulWidget {
  @override
  _PlantsOverviewScreenState createState() => _PlantsOverviewScreenState();
}

class _PlantsOverviewScreenState extends State<PlantsOverviewScreen> {
  Future<List<Plant>> _plants;

  @override
  void initState() {
    Provider.of<Plants>(context, listen: false).fetchDemoPlants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PlantsGrid(),
    );
  }
}
