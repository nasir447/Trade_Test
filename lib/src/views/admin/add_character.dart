import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:disneyland_character_votin_app/src/constants/custom_red_button.dart';
import 'package:disneyland_character_votin_app/src/constants/my_custom_text_field.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/add_character_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCharacter extends StatelessWidget {
  AddCharacter({
    super.key,
    required this.newCharacter,
  });
  bool newCharacter;
  CustomColor color = CustomColor();

  final controller = Get.put(AddCharacterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.highlight,
        title: Text(newCharacter ? "New Character" : "Update Character"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: Get.height,
            child: GetBuilder<AddCharacterController>(
              builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newCharacter
                      ? Text(
                          "Add A Character",
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            // color: color.highlight,
                          ),
                        )
                      : Text(
                          "Update A Character",
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
                      hintText: "Character Name",
                      textInputType: TextInputType.name,
                      obscureText: false,
                      onPressed: () {},
                      prefix: Icons.star,
                      controller: controller.characterName,
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: MyCustomTextfield(
                      hintText: "Picture Link (optional)",
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
                      onPressed: () {},
                      prefix: Icons.lock,
                      controller: controller.characterPicture,
                    ),
                  ),
                  SizedBox(
                    height: 33.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (newCharacter) {
                        await controller.addCharacter();
                      } else {
                        await controller.updateCharacter();
                      }
                      controller.characterName.clear();
                      controller.characterPicture.clear();
                      Navigator.pop(context);
                    },
                    child: CustomRedButton(
                        color: color, title: newCharacter ? 'Add' : 'Update'),
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
