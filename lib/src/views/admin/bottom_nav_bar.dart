import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BottomNav extends StatelessWidget {
  BottomNav({Key? key}) : super(key: key);
  CustomColor color = CustomColor();
  final controller = Get.put(BottomNavController());
  DateTime currentBackPressTime1 = DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime1 == null ||
        now.difference(currentBackPressTime1) > const Duration(seconds: 1)) {
      currentBackPressTime1 = now;
      Fluttertoast.showToast(msg: "Press again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    // controller.apiCall();
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: GetBuilder<BottomNavController>(builder: (_) {
          return controller.page();
        }),
      ),
      bottomNavigationBar: GetBuilder<BottomNavController>(
        builder: (_) {
          return Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: color.highlight,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                // primaryColor: Colors.red,
                textTheme: Theme.of(context).textTheme),
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/analytics.png"),
                  ),
                  label: "Analytics",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/user.png"),
                  ),
                  label: "User",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/star.png"),
                  ),
                  label: "Characters",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/settings.png"),
                  ),
                  label: "Settings",
                ),
              ],
              currentIndex: controller.index,
              onTap: (value) {
                controller.changePage(value);
              },
              unselectedItemColor: color.buttonText,
              selectedItemColor: color.redButton,
              // backgroundColor: Colors.amber,
            ),
          );
        },
      ),
    );
  }
}
