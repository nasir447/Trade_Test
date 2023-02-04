import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:disneyland_character_votin_app/src/constants/my_custom_text_field.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/add_user_controller.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/users_screen_controller.dart';
import 'package:disneyland_character_votin_app/src/views/admin/add_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Users extends StatelessWidget {
  Users({super.key});
  final controller = Get.put(UsersScreenController());
  final addUserController = Get.put(AddUserController());
  CustomColor color = CustomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.highlight,
        title: const Text("Users"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: GetBuilder<UsersScreenController>(
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
                      controller.searchUsers();
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
                      ? controller.serchedUser.length
                      : controller.users.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                    child: Column(
                      children: [
                        ListTile(
                          title: controller.search
                              ? Text(
                                  'Name: ${controller.serchedUser[index].username}',
                                  style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                )
                              : Text(
                                  'Name: ${controller.users[index].username}',
                                  style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                          subtitle: controller.search
                              ? Text(
                                  'Password: ${controller.serchedUser[index].password}',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )
                              : Text(
                                  'Password: ${controller.users[index].password}',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
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
                                addUserController.username.text =
                                    controller.users[index].username;
                                addUserController.password.text =
                                    controller.users[index].password;
                                addUserController.id =
                                    controller.users[index].id;
                              } else {
                                addUserController.username.text =
                                    controller.serchedUser[index].username;
                                addUserController.password.text =
                                    controller.serchedUser[index].password;
                                addUserController.id =
                                    controller.serchedUser[index].id;
                              }
                              Get.to(AddUser(newUser: false))
                                  ?.then((value) => controller.readUsers());
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
          Get.to(AddUser(
            newUser: true,
          ))?.then((value) => {controller.readUsers()});
        },
        backgroundColor: color.highlight,
        child: Icon(Icons.add),
      ),
    );
  }
}
