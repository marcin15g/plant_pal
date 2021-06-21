import 'package:flutter/material.dart';
import 'package:plantpal/notification_service.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:plantpal/providers/user.dart';
import 'package:plantpal/screens/collection_details_screen.dart';
import 'package:plantpal/screens/login.dart';
import 'package:plantpal/screens/new_plant_screen.dart';
import 'package:plantpal/screens/plant_details_screen.dart';
import 'package:plantpal/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Plants()),
      ],
      child: MaterialApp(
        title: 'PlantPal',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Patrick',
        ),
        home: LoginScreen(),
        routes: {
          TabScreen.routeName: (ctx) => TabScreen(),
          PlantDetailScreen.routeName: (ctx) => PlantDetailScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          NewPlantScreen.routeName: (ctx) => NewPlantScreen(),
          CollectionDetailsScreen.routeName: (ctx) => CollectionDetailsScreen()
        },
      ),
    );
  }
}
