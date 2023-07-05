import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/login.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/gym/bottom_tabs/profile/component/edit_profile.dart';
import 'package:gym_app/app/gym/bottom_tabs/profile/component/profile_component.dart';
import 'package:gym_app/app/gym/home/controller/home_controller.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/component/edit_profile.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/component/my_bookings.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_text.dart';



class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final gymController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color:  AppColor.whiteColor,
            elevation: 1,
            child: SizedBox(
              width: Get.width,
              height: Get.height / 8.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                        vertical: Get.height * 0.018),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          title: "My Profile",
                          color: AppColor.blackColor,
                          size: AppSizes.size_17,
                          fontFamily: AppFont.semi,
                        ),
                        Obx(
                          () {
                            return
                              Get.put(UserController()).name.value.isEmpty?
                              SizedBox.shrink():
                              GestureDetector(
                              onTap: (){
                                Get.to(EditUserProfile());
                              },
                              child: Container(
                                height: Get.height * 0.042,
                                width: Get.height * 0.042,
                                decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Get.height * 0.1))),
                                child: Icon(
                                  Icons.edit,
                                  color: AppColor.whiteColor,
                                  size: AppSizes.size_20,
                                ),
                              ),
                            );
                          }
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),


          SizedBox(
            height: Get.height * 0.005,
          ),
          Expanded(
              child:  Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                  Obx(
                    () {
                      return profileData(
                          name:
                          Get.put(UserController()).name.value.isEmpty?"Guest User":
                          Get.put(UserController()).name.value,
                          email: Get.put(UserController()).email.value,
                          image:"");
                    }
                  ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Obx(
                        () {
                          return


                            profileWidget(
                              onTap:
                              Get.put(UserController()).name.value.isEmpty?(){
                                flutterToast(msg: "Please Login Your Account");
                              }:

                              () {
                                Get.to(EditUserProfile());


                              },
                            image: "assets/icons/profile.svg",
                              text: "Edit Profile",);
                        }
                      ),
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      Obx(
                        () {
                          return profileWidget(
                            onTap:
                            Get.put(UserController()).name.value.isEmpty?(){
                              flutterToast(msg: "Please Login Your Account");
                            }:
                                () {
                              Get.to(MyBookings());


                            },
                            childs: Container(
                              height: Get.height * 0.049,
                              width: Get.height * 0.049,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.primaryColor.withOpacity(0.17)),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.bookmark_border,color: AppColor.primaryColor,)
                              ),
                            ),
                            image: "assets/icons/profile.svg",
                            text: "My Bookings",);
                        }
                      ),
                      SizedBox(
                        height: Get.height * 0.035,
                      ),
                      Obx(
                        () {
                          return
                            Get.put(UserController()).name.value.isEmpty?
                            GestureDetector(
                              onTap:(){
                                Get.to(LoginView());
                              } ,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                width: Get.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.boldBlackColor.withOpacity(0.4),
                                      width: 1.7
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: Get.height * 0.016),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText(
                                        title: "Login Your Account",
                                        size: AppSizes.size_15,
                                        fontFamily: AppFont.semi,
                                        color: AppColor.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ):


                            logOut(
                              onTap: () {
                                setState(() {
                                  showExit1(
                                      context: context,
                                    );
                                });

                              },
                              color:
                              AppColor.primaryColor);
                        }
                      )


                    ],
                  ),
                ),
              )
          ),


        ],
      ),
    );
  }
}
Widget profileWidget({text, image , Widget? child,onTap,Widget?childs}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                childs??
                Container(
                  height: Get.height * 0.049,
                  width: Get.height * 0.049,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.primaryColor.withOpacity(0.17)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      child: SvgPicture.asset(
                        image,
                        color: AppColor.primaryColor,
                        height: Get.height * 0.09,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                AppText(
                  title: text,
                  fontFamily: AppFont.medium,
                  size: AppSizes.size_15,
                  color: AppColor.boldBlackColor,
                ),
              ],
            ),
            child?? SvgPicture.asset(
              "assets/icons/arrow.svg",
              height: Get.height * 0.015,
            ),

          ],
        ),
      ),
    ),
  );
}