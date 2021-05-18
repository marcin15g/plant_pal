import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:plantpal/database.dart';
import 'package:plantpal/models/collection_plant.dart';

class CollectionDetailsScreen extends StatefulWidget {
  static const routeName = '/collection-details-screen';

  @override
  _CollectionDetailsScreenState createState() =>
      _CollectionDetailsScreenState();
}

class _CollectionDetailsScreenState extends State<CollectionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, CollectionPlant> data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    CollectionPlant plant = data['plant'];


    print(plant.toJson().toString());
    final spinkit = SpinKitFadingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(decoration: BoxDecoration(color: Colors.green));
      },
    );

    return WillPopScope(
      onWillPop: () async {
        print(plant.toJson().toString());
        updateCollectionPlant(plant);
        print('POP');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(plant.nickName),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                child: CachedNetworkImage(
                    imageUrl: plant.imageUrl, fit: BoxFit.cover),
                height: MediaQuery.of(context).size.height * 0.62,
                width: double.infinity,
              ),
              Container(
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
                                plant.nickName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0),
                              ),
                              Text(
                                plant.commonName,
                                style: TextStyle(fontSize: 18.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 120,
                        child: Stack(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                transform: plant.assistantEnabled
                                    ? Matrix4.translationValues(0.0, 0.0, 0.0)
                                    : Matrix4.translationValues(
                                        -200.0, 0.0, -100.0),
                                child: Column(
                                  children: [
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Number of days'),
                                      ),
                                    ),
                                    Container(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 25.0, vertical: 5.0),
                                        child: NumberPicker(
                                          value: plant.daysAmount,
                                          minValue: 1,
                                          maxValue: 30,
                                          itemHeight: 23,
                                          onChanged: (value) => {
                                            setState(() =>
                                                {plant.daysAmount = value})
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                margin: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Container(
                                  padding: EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Watering Assistant',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Switch(
                                        value: plant.assistantEnabled,
                                        onChanged: (value) {
                                          setState(() {
                                            plant.assistantEnabled = value;
                                            print(plant.assistantEnabled);
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
