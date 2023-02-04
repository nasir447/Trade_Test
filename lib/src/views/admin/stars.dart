import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:disneyland_character_votin_app/src/constants/my_custom_text_field.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/add_character_controller.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/characters_screen_controller.dart';
import 'package:disneyland_character_votin_app/src/views/admin/add_character.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Stars extends StatelessWidget {
  Stars({super.key});
  final controller = Get.put(CharactersScreenController());
  final addCharacterController = Get.put(AddCharacterController());
  CustomColor color = CustomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.highlight,
        title: const Text("Characters"),
        centerTitle: true,
        elevation: 0,
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
                                : controller.characters[index].charactePicture!,
                            width: 50.sp,
                            height: 50.sp,
                            imageBuilder: (context, imageProvider) => Container(
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
                              Icons.edit,
                              color: Colors.green,
                              size: 25.sp,
                            ),
                            onPressed: () {
                              if (controller.search == false) {
                                addCharacterController.characterName.text =
                                    controller.characters[index].characterName;
                                addCharacterController.characterPicture.text =
                                    controller
                                        .characters[index].charactePicture!;
                                addCharacterController.id =
                                    controller.characters[index].id;
                              } else {
                                addCharacterController.characterName.text =
                                    controller
                                        .serchedCharacter[index].characterName;
                                addCharacterController.characterPicture.text =
                                    controller.serchedCharacter[index]
                                        .charactePicture!;
                                addCharacterController.id =
                                    controller.serchedCharacter[index].id;
                                controller.search = false;
                                controller.searchBar.clear();
                              }
                              Get.to(AddCharacter(newCharacter: false))?.then(
                                  (value) => controller.readCharacters());
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddCharacter(
            newCharacter: true,
          ))?.then((value) => {controller.readCharacters()});
        },
        backgroundColor: color.highlight,
        child: Icon(Icons.add),
      ),
    );
  }
}
