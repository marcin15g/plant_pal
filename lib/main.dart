import 'package:flutter/material.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Plants()
        )
      ],
      child: MaterialApp(
        title: 'PlantPal',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
        ),
        home: TabScreen(),

      ),
    );
  }
}
