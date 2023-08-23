import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/gym/bottom_tabs/profile/component/edit_profile.dart';
import 'package:gym_app/app/gym/bottom_tabs/profile/component/profile_component.dart';
import 'package:gym_app/app/gym/home/controller/home_controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/view/my_profile.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/bottom_sheet.dart';
import 'package:gym_app/app/widgets/helper_function.dart';
import 'package:image_picker/image_picker.dart';



class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final gymController = Get.put(GymController());
  final homeController = Get.put(HomeController());

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
                              Get.put(HomeController()).name.value.isEmpty?"":
                              Get.put(HomeController()).name.value,
                              email: Get.put(HomeController()).email.value,
                              );
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
                      Positioned(
                          top: Get.height*0.025,
                          left: Get.width*0.33,
                          child:  Obx(
                            () {
                              return GestureDetector(
                                onTap:
                                Get.put(HomeController()).id.value.isEmpty?(){}:


                                    () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) => bottomSheet(onCamera: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(ImageSource.camera)
                                            .then((value) {
                                          setState(() {
                                            homeController.myProfile = value!;
                                            showLoadingIndicator1(context: context);

                                            ApiManger().editUserResponse1(context: context);

                                          });
                                        });
                                      }, onGallery: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(ImageSource.gallery)
                                            .then((value) {
                                          setState(() {
                                            homeController.myProfile= value!;
                                            showLoadingIndicator1(context: context);
                                            ApiManger().editUserResponse1(context: context);
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
                                                  imageUrl: homeController.image.value,
                                                  fit: homeController.image.value.isEmpty?BoxFit.cover: BoxFit.cover,
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
