import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:disneyland_character_votin_app/src/constants/custom_red_button.dart';
import 'package:disneyland_character_votin_app/src/constants/dialogue_box.dart';
import 'package:disneyland_character_votin_app/src/constants/logo.dart';
import 'package:disneyland_character_votin_app/src/controllers/login_screen_controller.dart';
import 'package:disneyland_character_votin_app/src/constants/my_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  CustomColor color = CustomColor();
  final controller = Get.put(LoginScreenController());
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
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: GetBuilder<LoginScreenController>(
                builder: (_) => Column(
                  children: [
                    SizedBox(
                      height: 55.h,
                    ),
                    const Logo(),
                    SizedBox(
                      height: 56.h,
                    ),
                    Text(
                      "Welcome to Disneyland",
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        // color: color.highlight,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Please Login to Continue",
                      style: GoogleFonts.inter(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                        // color: color.highlight,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Role",
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: color.highlight,
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        roleSelectDialogue(context, controller, color);
                      },
                      child: Container(
                        width: 200.w,
                        height: 50.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: color.sideText,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.sp))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.role,
                              style: GoogleFonts.inter(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w400,
                                color: color.sideText,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: color.sideText,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: MyCustomTextfield(
                        hintText: "Username",
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                        onPressed: () {},
                        prefix: Icons.person,
                        controller: controller.email,
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: MyCustomTextfield(
                        hintText: "Password",
                        textInputType: TextInputType.emailAddress,
                        obscureText: controller.obsecure,
                        onPressed: () {
                          controller.toggleObsecure();
                        },
                        prefix: Icons.lock,
                        suffix: controller.suffixPassword,
                        controller: controller.password,
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (controller.role == "User" &&
                            controller.email.text.isNotEmpty &&
                            controller.password.text.isNotEmpty) {
                          controller.loginUser();
                        } else if (controller.role == "Admin" &&
                            controller.email.text.isNotEmpty &&
                            controller.password.text.isNotEmpty) {
                          await controller.loginAdmin();
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please Fill form correctly.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: CustomRedButton(color: color, title: 'Login'),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
