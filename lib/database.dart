import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:plantpal/models/collection_plant.dart';
import 'package:plantpal/models/plant.dart';


final databaseReference = FirebaseDatabase.instance.reference();
final FirebaseAuth auth = FirebaseAuth.instance;
final String uid = auth.currentUser.uid;

DatabaseReference saveCollectionPlant(CollectionPlant plant) {
  var id = databaseReference.child('plants_collections').child(uid).push();
  id.set(plant.toJson());
  return id;
}

Future<DataSnapshot> fetchCollectionPlantsFromDB(String uid) async {
  DataSnapshot dataSnapshot = await databaseReference.child('plants_collections').child(uid).once();
  return dataSnapshot;
}