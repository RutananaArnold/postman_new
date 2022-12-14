// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

var global = Get.put(Globals());

class Globals extends GetxController {
  var prefs;

  setValue(String key, value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    update();
  }

  Future<String?> getValue(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
