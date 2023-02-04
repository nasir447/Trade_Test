import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:disneyland_character_votin_app/src/constants/custom_red_button.dart';
import 'package:disneyland_character_votin_app/src/constants/my_custom_text_field.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/add_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUser extends StatelessWidget {
  AddUser({
    super.key,
    required this.newUser,
  });
  bool newUser;
  CustomColor color = CustomColor();

  final controller = Get.put(AddUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.highlight,
        title: Text(newUser ? "New User" : "Update User"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: Get.height,
            child: GetBuilder<AddUserController>(
              builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newUser
                      ? Text(
                          "Add A User",
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            // color: color.highlight,
                          ),
                        )
                      : Text(
                          "Update A User",
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            // color: color.highlight,
                          ),
                        ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: MyCustomTextfield(
                      hintText: "Username",
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
                      onPressed: () {},
                      prefix: Icons.person,
                      controller: controller.username,
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
                      if (newUser) {
                        await controller.addUser();
                      } else {
                        await controller.updateUser();
                      }
                      controller.username.clear();
                      controller.password.clear();
                      Navigator.pop(context);
                    },
                    child: CustomRedButton(
                        color: color, title: newUser ? 'Add' : 'Update'),
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
    );
  }
}
