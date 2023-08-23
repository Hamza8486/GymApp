import 'package:cached_network_image/cached_network_image.dart';
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
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>  const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black26,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColor.primaryColor //<-- SEE HERE

                        ),
                      ),
                    ),
                    imageUrl: image,
                    fit:  BoxFit.cover,
                    height: Get.height * 0.1,
                    width: Get.height * 0.1,
                    errorWidget: (context, url, error) =>

                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:

                          Image.asset(
                            'assets/img/gym.jpeg',
                            fit: BoxFit.cover,
                            height: Get.height * 0.1,
                            width: Get.height * 0.1,
                          ),
                        ),
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
                                Text("Fee :  $fee",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,

                                  style: TextStyle(fontSize: AppSizes.size_14,

                                      color: AppColor.blackColor,
                                      height:Get.height*0.002,
                                      fontWeight: FontWeight.w700),),


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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,size: 23, color: AppColor.black.withOpacity(0.8),),
                    SizedBox(width: Get.width*0.01,),
                    SizedBox(
                      width: Get.width*0.55,
                      child: AppText(
                        title: address,
                        overFlow: TextOverflow.ellipsis,
                        maxLines: 1,
                        fontFamily: AppFont.medium,
                        size: AppSizes.size_13,
                        color: AppColor.black.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    child: AppText(
                      title: "See More",
                      overFlow: TextOverflow.ellipsis,
                      maxLines: 1,
                      size: Get.height * 0.012,
                      letterSpacing: 0.7,
                      textAlign: TextAlign.start,
                      color: AppColor.white,
                      fontFamily: AppFont.semi,
                    ),
                  ),
                ),
              ],
            ),



          ],
        ),
      ),
    ),
  );
}