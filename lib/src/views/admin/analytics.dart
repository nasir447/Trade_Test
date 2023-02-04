import 'package:disneyland_character_votin_app/src/constants/colors.dart';
import 'package:disneyland_character_votin_app/src/constants/dialogue_box.dart';
import 'package:disneyland_character_votin_app/src/controllers/admin/analytics_controller.dart';
import 'package:disneyland_character_votin_app/src/models/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Analytics extends StatelessWidget {
  Analytics({super.key});
  CustomColor color = CustomColor();

  final controller = Get.put(AnalyticsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.highlight,
        title: Text("Analytics"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AnalyticsController>(
          builder: (_) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            width: double.infinity,
            height: Get.height,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: [
                      ColumnSeries(
                          dataSource: controller.chartData,
                          xValueMapper: (ChartData ch, _) => ch.x,
                          yValueMapper: (ChartData ch, _) => ch.y),
                    ],
                    // palette: const [
                    //   Color.fromRGBO(11, 19, 43, 1),
                    //   Color.fromRGBO(28, 37, 65, 1),
                    //   Color.fromRGBO(58, 80, 107, 1),
                    //   Color.fromRGBO(91, 192, 190, 1),
                    // ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  "Data",
                  style: GoogleFonts.roboto(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: color.highlight,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                GestureDetector(
                  onTap: () {
                    chartTypeDialogue(context, controller, color);
                  },
                  child: Container(
                    width: 280.w,
                    height: 50.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: color.sideText,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.sp))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.data,
                          style: GoogleFonts.inter(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                            color: color.sideText,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: color.sideText,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  "Filters",
                  style: GoogleFonts.roboto(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: color.highlight,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                GestureDetector(
                  onTap: () {
                    fliterSelectDialogue(context, controller, color);
                  },
                  child: Container(
                    width: 280.w,
                    height: 50.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: color.sideText,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.sp))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.filter,
                          style: GoogleFonts.inter(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                            color: color.sideText,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: color.sideText,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
