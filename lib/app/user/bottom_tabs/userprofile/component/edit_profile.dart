import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/address.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/app_textfield.dart';





class EditUserProfile extends StatefulWidget {
  const EditUserProfile({Key? key}) : super(key: key);


  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final homeController = Get.put(UserController());
  TextEditingController title = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text=homeController.name.value.toString();
    phone.text=homeController.phone.value.toString();
    Get.put(AuthController()).addressController.text=homeController.address.value.toString();
    // password.text=homeController.name.value.toString();


  }
  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(

            body:  Column(
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
                              GestureDetector(
                                onTap:(){
                                  Get.back();
                                },
                                child: Container(
                                    color: Colors.transparent,

                                    child: Icon(Icons.arrow_back_ios)),
                              ),

                              AppText(
                                title: "Edit Profile",
                                color: AppColor.blackColor,
                                size: AppSizes.size_17,
                                fontFamily: AppFont.semi,
                              ),
                              AppText(
                                title: "",
                                color: AppColor.blackColor,
                                size: AppSizes.size_17,
                                fontFamily: AppFont.semi,
                              ),


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



                Expanded(
                    child:Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.02,
                            ),


                            AppText(
                              title: "Name",
                              color: AppColor.boldBlackColor,
                              size: AppSizes.size_15,
                              fontFamily: AppFont.semi,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            AppTextFied(
                              fillColor:AppColor.whiteColor,
                              isFill: true,

                              isborderline: true,
                              controller: title,
                              autovalidateMode:  AutovalidateMode.onUserInteraction,
                              isborderline2: true,
                              isSuffix: true,
                              padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                        borderRadius: BorderRadius.circular(10),
                              borderRadius2: BorderRadius.circular(10),
                              borderColor:AppColor.borderColorField,
                              hint: "name",

                              hintColor: AppColor.blackColor.withOpacity(0.5),
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.done,

                              hintSize: AppSizes.size_13,
                              fontFamily:AppFont.medium,
                              borderColor2: AppColor.primaryColor,

                              maxLines: 1,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),


                            AppText(
                              title: "Phone",
                              color: AppColor.boldBlackColor,
                              size: AppSizes.size_15,
                              fontFamily: AppFont.semi,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            AppTextFied(
                              fillColor:AppColor.whiteColor,
                              isFill: true,

                              isborderline: true,
                              controller: phone,
                              autovalidateMode:  AutovalidateMode.onUserInteraction,
                              isborderline2: true,
                              isSuffix: true,
                              padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                        borderRadius: BorderRadius.circular(10),
                              borderRadius2: BorderRadius.circular(10),
                              borderColor:AppColor.borderColorField,
                              hint: "Enter phone",
                              hintColor: AppColor.blackColor.withOpacity(0.5),
                              textInputType: TextInputType.phone,
                              textInputAction: TextInputAction.next,

                              hintSize: AppSizes.size_13,
                              fontFamily:AppFont.medium,
                              borderColor2: AppColor.primaryColor,

                              maxLines: 1,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),


                            AppText(
                              title: "Address",
                              color: AppColor.boldBlackColor,
                              size: AppSizes.size_15,
                              fontFamily: AppFont.semi,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            AppTextFied(
                              fillColor:AppColor.whiteColor,
                              isFill: true,
                              isShowCursor:false,

                              isborderline: true,
                              controller: Get.put(AuthController()).addressController,
                              autovalidateMode:  AutovalidateMode.onUserInteraction,
                              isborderline2: true,
                              isSuffix: true,
                              isReadOnly: true,
                              padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                        borderRadius: BorderRadius.circular(10),
                              borderRadius2: BorderRadius.circular(10),
                              borderColor:AppColor.borderColorField,
                              hint: "Enter address",
                             onTap: (){
                                Get.to(AddAddress());
                             },

                              hintColor: AppColor.blackColor.withOpacity(0.5),
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.done,

                              hintSize: AppSizes.size_13,
                              fontFamily:AppFont.medium,
                              borderColor2: AppColor.primaryColor,

                              maxLines: 1,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),


                            AppText(
                              title: "Password",
                              color: AppColor.boldBlackColor,
                              size: AppSizes.size_15,
                              fontFamily: AppFont.semi,
                            ),
                            SizedBox(
                              height: Get.height * 0.001,
                            ),
                            AppText(
                              title: "(Leave blank if you don't want to change it)",
                              color: AppColor.boldBlackColor.withOpacity(0.6),
                              size: AppSizes.size_11,
                              fontFamily: AppFont.regular,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            AppTextFied(
                              fillColor:AppColor.whiteColor,
                              isFill: true,
                              isShowCursor:true,



                              isborderline: true,
                              controller: password,
                              autovalidateMode:  AutovalidateMode.onUserInteraction,
                              isborderline2: true,
                              isSuffix: true,

                              padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                        borderRadius: BorderRadius.circular(10),
                              borderRadius2: BorderRadius.circular(10),
                              borderColor:AppColor.borderColorField,
                              hint: "Enter Password",
                              hintColor: AppColor.blackColor.withOpacity(0.5),
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.done,

                              hintSize: AppSizes.size_13,
                              fontFamily:AppFont.medium,
                              borderColor2: AppColor.primaryColor,

                              maxLines: 1,
                            ),
                            SizedBox(
                              height: Get.height * 0.04,
                            ),
                            AppButton(
                                buttonWidth: Get.width,
                                buttonRadius: BorderRadius.circular(10),
                                buttonName: "Update",

                                fontWeight: FontWeight.w500,
                                textSize: AppSizes.size_15,
                                buttonColor: AppColor.primaryColor,
                                textColor: AppColor.whiteColor,
                                onTap: () {
                                  if(validateEditProfile(context)){
                                    homeController.updateLoader(true);
                                    ApiManger().editProfile1Response(name: title.text,
                                    password: password.text,
                                      phone: phone.text,
                                      address: Get.put(AuthController()).addressController.text
                                    );

                                  }

                                }),

                          ],
                        ),
                      ),
                    )
                ),


              ],
            )

        ),
        Obx(() {
          return Get.put(UserController()).loader.value == false
              ? SizedBox.shrink()
              : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black26,
            child:  Center(
                child: SpinKitThreeBounce(
                    size: 25, color: AppColor.primaryColor1)
            ),
          );



        })
      ],
    );
  }

  bool validateEditProfile(BuildContext context) {


    if (title.text.isEmpty) {
      flutterToast(msg: "Please enter name");
      return false;
    }

    if (phone.text.isEmpty) {
      flutterToast(msg: "Please enter phone");
      return false;
    }

    if (Get.put(AuthController()).addressController.text.isEmpty) {
      flutterToast(msg: "Please enter address");
      return false;
    }







    return true;
  }
}



