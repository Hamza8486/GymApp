import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/login.dart';

import 'package:gym_app/app/gym/bottom_tabs/profile/component/profile_component.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/component/edit_profile.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/component/my_bookings.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/helper_function.dart';
import 'package:gym_app/app/widgets/image_pick.dart';
import 'package:image_picker/image_picker.dart';



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
                  child: Stack(
                    children: [
                      Column(
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
                              );
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
                                  Get.to(MyBookings(),
                                  transition: Transition.rightToLeft
                                  );


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
                      Positioned(
                          top: Get.height*0.025,
                          left: Get.width*0.33,
                          child:  Obx(
                            () {
                              return GestureDetector(
                        onTap:

                        Get.put(UserController()).id.value.isEmpty?(){}:
                            () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (builder) => bottomSheet(onCamera: () {
                                    Navigator.pop(context);
                                    HelperFunctions.pickImage(ImageSource.camera)
                                        .then((value) {
                                      setState(() {
                                        gymController.myProfile = value!;
                                        showLoadingIndicator1(context: context);

                                        ApiManger().editUserResponse(context: context);

                                      });
                                    });
                                  }, onGallery: () {
                                    Navigator.pop(context);
                                    HelperFunctions.pickImage(ImageSource.gallery)
                                        .then((value) {
                                      setState(() {
                                        gymController.myProfile= value!;
                                        showLoadingIndicator1(context: context);
                                        ApiManger().editUserResponse(context: context);
                                      });
                                    });
                                  }));
                        },
                        child: Center(
                              child: Stack(
                                children: [

                                  Obx(
                                          () {
                                        return Container(
                                          height: MediaQuery.of(context).size.height * 0.14,
                                          width: MediaQuery.of(context).size.height * 0.14,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(color: AppColor.primaryColor,width: 2)
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>  const Center(
                                                child: CircularProgressIndicator(
                                                  backgroundColor: Colors.black26,
                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                      AppColor.primaryColor //<-- SEE HERE

                                                  ),
                                                ),
                                              ),
                                              imageUrl: gymController.image.value,
                                              fit: gymController.image.value.isEmpty?BoxFit.cover: BoxFit.cover,
                                              errorWidget: (context, url, error) =>

                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child:

                                                    Image.asset(
                                                      'assets/img/gym.jpeg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                            ),






                                          ),
                                        );
                                      }
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Image.asset("assets/img/cam.png",

                                        height: Get.height*0.037,
                                      ))
                                ],
                              ),
                        ),
                      );
                            }
                          ))
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