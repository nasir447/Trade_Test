import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRedButton extends StatelessWidget {
  const CustomRedButton({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  final CustomColor color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 286.w,
      height: 52.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.redButton,
        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
      ),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 21.sp,
          fontWeight: FontWeight.w600,
          color: color.buttonText,
        ),
      ),
    );
  }
}
