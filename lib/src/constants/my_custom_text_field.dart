import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCustomTextfield extends StatelessWidget {
  MyCustomTextfield({
    Key? key,
    required this.textInputType,
    required this.onPressed,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    required this.hintText,
    required this.controller,
    this.onValidation,
    this.onTap,
  }) : super(key: key);

  late TextInputType textInputType;
  Function? onValidation = (String v) {};
  Function? onTap = (String v) {};
  late Function onPressed;

  bool obscureText = false, disable = false;
  IconData? prefix;
  IconData? suffix;
  String hintText;
  TextEditingController controller;
  CustomColor color = CustomColor();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText,
      onTap: () {
        onTap!();
      },
      autofocus: false,
      onChanged: (value) {
        onValidation!();
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: color.highlight,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Icon(
            suffix,
            color: color.highlight,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(40, 15, 12, 15),
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
          color: color.sideText,
        ),
        filled: true,
        fillColor: Colors.white54,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.sideText),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.sideText),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
