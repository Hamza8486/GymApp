import 'package:flutter/material.dart';

import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_text.dart';



Widget textAuth({text,Color?color,Color?textColor}){
  return Row(
    children: [
      AppText(
        title: "$text",
        size: AppSizes.size_14,
        fontWeight: FontWeight.w400,
        fontFamily: AppFont.regular,
        color:textColor?? AppColor.white.withOpacity(0.8),
      ),
      AppText(
        title: " *",
        size: AppSizes.size_14,
        fontWeight: FontWeight.w400,
        fontFamily: AppFont.regular,
        color: color??
            AppColor.boldBlackColor.withOpacity(0.8),
      ),
    ],
  );
}
Widget textAuth2({text,Color?color,Color?textColor}){
  return Row(
    children: [
      AppText(
        title: "$text",
        size: AppSizes.size_14,
        fontWeight: FontWeight.w600,
        fontFamily: AppFont.medium,
        color:textColor?? AppColor.white.withOpacity(0.9),
      ),
      AppText(
        title: " *",
        size: AppSizes.size_14,
        fontWeight: FontWeight.w400,
        fontFamily: AppFont.regular,
        color: color??
            AppColor.boldBlackColor.withOpacity(0.8),
      ),
    ],
  );
}
Widget textAuth1({text,Color?color}){
  return Row(
    children: [
      AppText(
        title: "$text",
        size: AppSizes.size_14,
        fontWeight: FontWeight.w500,
        fontFamily: AppFont.medium,
        color: AppColor.white.withOpacity(0.8),
      ),
      AppText(
        title: " *",
        size: AppSizes.size_14,
        fontWeight: FontWeight.w400,
        fontFamily: AppFont.regular,
        color: color??
            AppColor.boldBlackColor.withOpacity(0.8),
      ),
    ],
  );
}

