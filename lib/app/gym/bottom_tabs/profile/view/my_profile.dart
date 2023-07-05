import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/gym/bottom_tabs/profile/component/edit_profile.dart';
import 'package:gym_app/app/gym/bottom_tabs/profile/component/profile_component.dart';
import 'package:gym_app/app/gym/home/controller/home_controller.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/view/my_profile.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_text.dart';



class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final gymController = Get.put(GymController());

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
                        GestureDetector(
                          onTap: (){
                            Get.to(EditProfile());
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
                          Get.put(HomeController()).name.value.isEmpty?"":
                          Get.put(HomeController()).name.value,
                          email: Get.put(HomeController()).email.value,
                          image:"");
                    }
                  ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      profileWidget(
                        onTap: () {
                          Get.to(EditProfile());


                        },
                        image: "assets/icons/profile.svg",
                        text: "Edit Profile",),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),

                      logOut(
                          onTap: () {
                            setState(() {
                              showExit(
                                  context: context,
                                );
                            });

                          },
                          color:
                          AppColor.primaryColor)


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
