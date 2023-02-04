import 'package:cached_network_image/cached_network_image.dart';
import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:disneyland_character_votin_app/src/constants/my_custom_text_field.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/characters_screen_controller.dart';
import 'package:disneyland_character_votin_app/src/controllers/login_screen_controller.dart';
import 'package:disneyland_character_votin_app/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VotingScreen extends StatelessWidget {
  VotingScreen({super.key});
  final controller = Get.put(CharactersScreenController());
  CustomColor color = CustomColor();
  LoginScreenController loginScreenController = Get.find();
  DateTime currentBackPressTime1 = DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime1 == null ||
        now.difference(currentBackPressTime1) > Duration(seconds: 1)) {
      currentBackPressTime1 = now;
      Fluttertoast.showToast(msg: "Press again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color.highlight,
          title: const Text("Favourite Characters"),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  loginScreenController.user = null;
                  Get.off(LoginScreen());
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: GetBuilder<CharactersScreenController>(
              builder: (_) => Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: MyCustomTextfield(
                      hintText: "Search",
                      textInputType: TextInputType.text,
                      obscureText: false,
                      onPressed: () {},
                      onValidation: () {
                        controller.searchCharacter();
                      },
                      prefix: Icons.search,
                      controller: controller.searchBar,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ListView.builder(
                    itemCount: controller.search
                        ? controller.serchedCharacter.length
                        : controller.characters.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: controller.search
                                  ? controller
                                      .serchedCharacter[index].charactePicture!
                                  : controller
                                      .characters[index].charactePicture!,
                              width: 50.sp,
                              height: 50.sp,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                color: color.highlight,
                              )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            title: controller.search
                                ? Text(
                                    'Name: ${controller.serchedCharacter[index].characterName}',
                                    style: GoogleFonts.inter(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  )
                                : Text(
                                    'Name: ${controller.characters[index].characterName}',
                                    style: GoogleFonts.inter(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.how_to_vote,
                                color: Colors.green,
                                size: 25.sp,
                              ),
                              onPressed: () async {
                                await controller.voteCast(
                                    loginScreenController.user!.id,
                                    controller.characters[index].id);
                              },
                            ),
                          ),
                          Divider(
                            color: color.sideText,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
