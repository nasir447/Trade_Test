import 'package:disneyland_character_votin_app/src/constants/my_custom_text_field.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/analytics_controller.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/characters_screen_controller.dart';
import 'package:disneyland_character_votin_app/src/models/character.dart';
import 'package:disneyland_character_votin_app/src/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

String? d;
String? start, end;

Future<dynamic> roleSelectDialogue(BuildContext context, controller, color) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.sp))),
            content: Container(
              width: 231.w,
              height: 180.h,
              padding: EdgeInsets.all(25.w),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      controller.setRole('User');
                      Navigator.pop(context);
                    },
                    child: Text(
                      "User",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: color.highlight,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 108.w,
                    height: 1.h,
                    color: color.hintText,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    onPressed: () {
                      controller.setRole('Admin');
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Admin",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: color.highlight,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

Future<dynamic> fliterSelectDialogue(BuildContext context, controller, color) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.sp))),
            content: Container(
              width: 231.w,
              height: 260.h,
              padding: EdgeInsets.all(25.w),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      controller.setFilter('Select Filter');
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Select Filter",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: color.highlight,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 108.w,
                    height: 1.h,
                    color: color.hintText,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    onPressed: () {
                      controller.setFilter('Period');
                      startAndEndDialogue(context, color, controller);
                      // Navigator.pop(context);
                    },
                    child: Text(
                      "Period",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: color.highlight,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 108.w,
                    height: 1.h,
                    color: color.hintText,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    onPressed: () async {
                      controller.setFilter('Characters');

                      characterDialoge(context, "Select Character(s)", color,
                          controller.characters, controller);
                    },
                    child: Text(
                      "Characters",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: color.highlight,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

Future<dynamic> startAndEndDialogue(
    BuildContext context, color, AnalyticsController controller) {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          child: StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.sp))),
              title: Text(
                "Select Dates",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: color.highlight,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: 231.w,
                height: 150.h,
                child: Column(
                  children: [
                    MyCustomTextfield(
                      hintText: "Start Date",
                      textInputType: TextInputType.visiblePassword,
                      obscureText: false,
                      onPressed: () {},
                      prefix: Icons.calendar_month,
                      onTap: () async {
                        DateTime now = DateTime.now();
                        await datesDialoge(
                          context,
                          "Start Date",
                          color,
                        );
                        startDate.text = d!;
                        start = d;
                        d = null;
                      },
                      controller: startDate,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    MyCustomTextfield(
                      hintText: "End Date",
                      textInputType: TextInputType.visiblePassword,
                      obscureText: false,
                      onPressed: () {},
                      prefix: Icons.calendar_month,
                      onTap: () async {
                        DateTime now = DateTime.now();
                        await datesDialoge(context, "End Date", color);
                        endDate.text = d!;
                        end = d;
                        d = null;
                      },
                      controller: endDate,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: color.highlight,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    controller.startDate = start;
                    controller.endDate = end;
                    controller.readVotesByDates(
                        controller.startDate, controller.endDate);
                    Navigator.pop(context);

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ok",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: color.highlight,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Future<dynamic> datesDialoge(BuildContext context, title, color) {
  DateTime date = DateTime.now();
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          width: 332.w,
          height: 402.h,
          child: StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Text(
                title,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(33.sp))),
              content: SingleChildScrollView(
                child: Container(
                  width: 332.w,
                  height: 390.h,
                  // padding: EdgeInsets.all(35.w),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: date,
                    focusedDay: date,
                    headerVisible: false,
                    availableCalendarFormats: const {
                      CalendarFormat.month: "Month"
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      // print(focusedDay);

                      // date = selectedDay;

                      setState(() {
                        d = '${focusedDay.year}-${focusedDay.month}-${focusedDay.day}';
                      });
                      // print(now);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              actions: [],
            ),
          ),
        );
      });
}

Future<dynamic> chartTypeDialogue(BuildContext context, controller, color) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.sp))),
            content: Container(
              width: 231.w,
              height: 350.h,
              padding: EdgeInsets.all(25.w),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      controller.choice = 0;
                      controller.setChartType('Grouped Daily', false);

                      Navigator.pop(context);
                    },
                    child: Text(
                      "Grouped Daily",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: color.highlight,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 150.w,
                    height: 1.h,
                    color: color.hintText,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    onPressed: () {
                      controller.choice = 1;
                      controller.setChartType('Votes per Character', false);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Votes per Character",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: color.highlight,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 150.w,
                    height: 1.h,
                    color: color.hintText,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    onPressed: () {
                      controller.choice = 2;
                      controller.setChartType('Top 5 Charaters', true);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Top 5 Charaters",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: color.highlight,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 150.w,
                    height: 1.h,
                    color: color.hintText,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    onPressed: () {
                      controller.choice = 3;
                      controller.setChartType('Votes by Time of Day', false);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Votes by Time of Day",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: color.highlight,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

Future<dynamic> characterDialoge(BuildContext context, title, color,
    List<Character> characters, AnalyticsController controller) async {
  List<bool> value = [];
  List<int> charID = [];
  for (int i = 0; i < characters.length; i++) {
    value.add(false);
  }
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          // width: 332.w,
          // height: 108.h,
          child: AlertDialog(
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.sp))),
            content: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (context, setState) => SizedBox(
                  // height: 300.h,
                  width: 231.w,
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: characters.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => CheckboxListTile(
                          // groupValue: value[index],
                          value: value[index],
                          onChanged: (v) {
                            value[index] = v!;
                            setState(() {});
                          },
                          activeColor: color.highlight,
                          title: Text(
                            characters[index].characterName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: color.highlight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  for (int i = 0; i < value.length; i++) {
                    if (value[i] == true) {
                      charID.add(characters[i].id!);
                    }
                  }
                  controller.votesOnSelectedCharacters(charID);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Select",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: color.highlight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

Future<dynamic> changePassDialogue(
  BuildContext context,
  color,
) {
  bool obsecure = false;
  IconData suffixPassword = Icons.visibility_off;
  TextEditingController password = TextEditingController();
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          child: StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.sp))),
              title: Text(
                "Change Password",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: color.highlight,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: 231.w,
                height: 80.h,
                child: MyCustomTextfield(
                  hintText: "New Password",
                  textInputType: TextInputType.visiblePassword,
                  obscureText: obsecure,
                  onPressed: () {
                    if (obsecure) {
                      obsecure = false;
                      suffixPassword = Icons.visibility;
                    } else {
                      obsecure = true;
                      suffixPassword = Icons.visibility_off;
                    }
                    setState(() {});
                  },
                  prefix: Icons.lock,
                  suffix: suffixPassword,
                  controller: password,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: color.highlight,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    if (password.text.isNotEmpty) {
                      await prefs.setString('password', password.text.trim());
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ok",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: color.highlight,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
