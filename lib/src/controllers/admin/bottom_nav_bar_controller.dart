import 'package:disneyland_character_votin_app/src/views/admin/analytics.dart';
import 'package:disneyland_character_votin_app/src/views/admin/settings.dart';
import 'package:disneyland_character_votin_app/src/views/admin/stars.dart';
import 'package:disneyland_character_votin_app/src/views/admin/users.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int index = 0;

  void changePage(number) {
    if (number == 0) {
      index = 0;
    } else if (number == 1) {
      index = 1;
    } else if (number == 2) {
      index = 2;
    } else if (number == 3) {
      index = 3;
    }
    update();
  }

  page() {
    if (index == 0) {
      return Analytics();
    } else if (index == 1) {
      return Users();
    } else if (index == 2) {
      return Stars();
    } else if (index == 3) {
      return Settings();
    }
    update();
  }
}
