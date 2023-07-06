import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:intl/intl.dart';

Widget gymWidget({
  image,name,type,onTap,onTap1,onTap2,address,group,fee,
  days,time,time1
}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      margin: EdgeInsets.zero,
      shadowColor: AppColor.whiteColor,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side:  BorderSide(color: AppColor.greyColors.withOpacity(0.4))),

      // color: AppColor.histColor,

      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.03, vertical: Get.height * 0.02),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                    height: Get.height * 0.1,
                    width: Get.height * 0.1,
                    fit: BoxFit.cover,
                    errorBuilder: (context, exception, stackTrace) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/img/gym.jpeg",
                          height: Get.height * 0.1,
                          width: Get.height * 0.1,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: Get.width * 0.017),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.007,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              title: name,
                              fontFamily: AppFont.bold,
                              size: AppSizes.size_13,
                              color: AppColor.boldBlackColor,
                            ),
                           Row(
                             children: [
                               GestureDetector(
                                   onTap:onTap1,
                                   child: SvgPicture.asset("assets/icons/edits.svg")),
                               SizedBox(width: Get.width*0.045,),
                               GestureDetector(
                                   onTap: onTap2,
                                   child: SvgPicture.asset("assets/icons/del.svg")),
                             ],
                           ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.004,
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              title: "Gender: $type",
                              fontFamily: AppFont.medium,
                              size: AppSizes.size_13,
                              color: AppColor.black.withOpacity(0.8),
                            ),
                            AppText(
                              title: "",
                              fontFamily: AppFont.bold,
                              size: AppSizes.size_13,
                              color: AppColor.boldBlackColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(

                              children: [

                                AppText(
                                  title: "Session :  $group",
                                  fontFamily: AppFont.medium,
                                  size: AppSizes.size_14,
                                  color: AppColor.black.withOpacity(0.7),
                                ),
                              ],
                            ),
                            Row(

                              children: [

                                AppText(
                                  title: "Fee :  $fee",
                                  fontFamily: AppFont.medium,
                                  size: AppSizes.size_14,
                                  color: AppColor.black.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: Get.height*0.013,),
            Row(
              children: [
                Icon(Icons.location_on_outlined,size: 23, color: AppColor.black.withOpacity(0.8),),
                SizedBox(width: Get.width*0.01,),
                AppText(
                  title: address,
                  fontFamily: AppFont.medium,
                  size: AppSizes.size_13,
                  color: AppColor.black.withOpacity(0.8),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.008,
            ),

            Row(
              children: [
                Icon(Icons.access_time_outlined,color: AppColor.greyColors,
                  size:17,
                ),
                SizedBox(
                  width: Get.width * 0.005,
                ),
                AppText(
                  title: " $time - $time1",
                  fontFamily: AppFont.medium,
                  size: AppSizes.size_13,
                  color: AppColor.black.withOpacity(0.8),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.008,
            ),

            Row(
              children: [
                AppText(
                  title: "Open Days: ",
                  overFlow: TextOverflow.ellipsis,
                  maxLines: 1,
                  size: Get.height * 0.014,
                  letterSpacing: 0.7,
                  textAlign: TextAlign.start,
                  color: AppColor.black,
                  fontFamily: AppFont.semi,
                ),
                SizedBox(width: 5,),
                AppText(
                  title: days,
                  fontFamily: AppFont.medium,
                  size: AppSizes.size_13,
                  color: AppColor.black.withOpacity(0.8),
                ),
              ],
            ),

          ],
        ),
      ),
    ),
  );
}