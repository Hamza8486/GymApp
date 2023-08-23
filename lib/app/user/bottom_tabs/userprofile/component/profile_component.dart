import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/gym/bottom_tabs/profile/component/edit_profile.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_text.dart';

Widget profileData({name,email,image}){
  return  Stack(
    children: [
      Column(
        children: [
          SizedBox(
            height: Get.height * 0.08,
          ),
          GestureDetector(
            onTap: (){
              Get.to(EditProfile());
            },
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                  border:
                  Border.all(color: AppColor.primaryColor)),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.085,
                  ),
                  AppText(
                    title: "$name!",
                    size: AppSizes.size_16,
                    fontFamily: AppFont.bold,
                    fontWeight: FontWeight.bold,
                    color: AppColor.boldBlackColor,
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  AppText(
                    title: "$email",
                    size: AppSizes.size_14,
                    fontFamily: AppFont.medium,
                    color: AppColor.boldGreyColor,
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Positioned(
        top: Get.height * 0.008,
        left: Get.width * 0.31,
        child: Container(
          height: Get.height * 0.14,
          width: Get.height * 0.14,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              border: Border.all(
                  color: AppColor.whiteColor, width: 4)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,

                errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.asset(
                    "assets/img/gym.jpeg",
                    fit: BoxFit.cover,

                  ),
                ),
              )
          ),
        ),
      ),

    ],
  );
}
Widget logOut({onTap,color}){
  return   GestureDetector(
    onTap:onTap ,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(
            color: color,
            width: 1.7
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 12, vertical: Get.height * 0.018),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/logOut.svg",
            color: AppColor.primaryColor,
            ),
            SizedBox(
              width: Get.width * 0.03,
            ),
            AppText(
              title: "Log Out",
              size: AppSizes.size_14,
              fontFamily: AppFont.bold,
              color: AppColor.primaryColor,
            ),
          ],
        ),
      ),
    ),
  );
}