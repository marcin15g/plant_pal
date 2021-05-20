import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plantpal/models/collection_plant.dart';

class AssistantPlantTile extends StatelessWidget {
  final CollectionPlant plant;
  final int index;
  final Function callback;

  AssistantPlantTile(this.plant, this.index, this.callback);

  @override
  Widget build(BuildContext context) {
    int daysDifference() {
      final DateTime lastWatering = plant.lastWatering;
      if (lastWatering == null) return 0;

      DateTime now = new DateTime.now();
      DateTime date = new DateTime(now.year, now.month, now.day);

      final diff = plant.daysAmount - date.difference(lastWatering).inDays;
      return diff;
    }

    final int diff = daysDifference();

    String daysUntilWatering(diff) {
      String text;
      if (diff == 0)
        text = 'Today!';
      else if (diff == 1)
        text = 'Tomorrow';
      else if (diff > 0)
        text = 'In ${diff.toString()} days';
      else
        text = '${diff.abs().toString()} days ago';

      return text;
    }

    updateLastWatering() {
      callback(index);
    }

    return Container(
        height: 120,
        margin: EdgeInsets.only(top: 15.0),
        child: Card(
          shape: StadiumBorder(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.only(right: 10.0),
                  // width: MediaQuery.of(context).size.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    child: CachedNetworkImage(
                      imageUrl: plant.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Text(plant.nickName, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),),
                  ),
                  Text('Watering: ' + daysUntilWatering(diff))
                ],
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                  onPressed: diff > 0 ? null : updateLastWatering,
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), primary: Colors.blue),
                  child: Icon(MdiIcons.water),
                ),
              )
            ],
          ),
        ));
  }
}
