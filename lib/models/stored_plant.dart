import 'package:flutter/cupertino.dart';

class StoredPlant with ChangeNotifier {

  final String nickname;

  StoredPlant(
    {
      this.nickname
    }
  );
}