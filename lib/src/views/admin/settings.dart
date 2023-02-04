import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:disneyland_character_votin_app/src/constants/dialogue_box.dart';
import 'package:disneyland_character_votin_app/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  CustomColor color = CustomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.highlight,
        title: Text("Settings"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        height: Get.height,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                changePassDialogue(context, color);
              },
              title: Text(
                'Change Password',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(
              color: color.sideText,
            ),
            ListTile(
              onTap: () {
                Get.off(LoginScreen());
              },
              title: Text(
                'Logout',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(
              color: color.sideText,
            ),
          ],
        ),
      ),
    );
  }
}
