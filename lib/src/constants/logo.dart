// **********************************************
// Name of creator: Nasir Khalil
// Date created: 21/10/2022
// Last Updated: 21/10/2022
// Company: VectraCom Pvt. Ltd.
// **********************************************

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w),
      child: Image.asset("assets/logo.png"),
    );
  }
}
