import 'dart:convert';

import 'package:flutter/foundation.dart';


class User with ChangeNotifier {
  
  static String token = 'tGDID0HQZK1PpArN2eGAKyoV5j7uiNcT2UJedHoR5H0';

  Object _userInfo;

 setUser(userInfo) {
   _userInfo = userInfo;
 }
}