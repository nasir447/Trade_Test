import 'package:disneyland_character_votin_app/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        locale: const Locale("en", "US"),
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          backgroundColor: Color(0xffCAB2B2),
          // indicatorColor: Color(0xffCBDCF8),
          // buttonColor: Color(0xffF1F5FB),
          // hintColor: Color(0xffEECED3),
          // highlightColor: Color(0xffFCE192),
          // hoverColor: Color(0xff4285F4),
          // focusColor: Color(0xffA8DAB5),
          // disabledColor: Colors.grey,
          // textSelectionColor: Colors.black,
          cardColor: Colors.white,
          //canvasColor: Colors.grey[50],
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
