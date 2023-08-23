import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/address.dart';
import 'package:gym_app/app/auth/component.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/auth/login.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';



class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: AppPaddings.mainPadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.06,
                  ),

                  Center(
                    child: AppText(
                      title: "Create an Account",
                      size: AppSizes.size_22,
                      fontFamily: AppFont.medium,
                      fontWeight: FontWeight.w500,
                      color: AppColor.boldBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.004,
                  ),
                  Center(
                    child: AppText(
                      title: "Please enter your data to create account ",
                      size: AppSizes.size_13,
                      fontFamily: AppFont.regular,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.042,
                  ),
                  textAuth(text: "User Type"),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  SizedBox(
                      width: Get.width,
                      child: Obx(() {
                        return dropDownAppAdd(
                          hint: "Select User Type",
                          width: Get.width * 0.92,
                          items: [
                            "User",
                            "Gym",

                          ],
                          value:authController.userType.value.isEmpty?null:authController.userType.value,
                          onChange: (value) {
                            authController.updateUserType(value.toString());


                          },
                        );
                      })),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  textAuth(text: "Full Name"),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  betField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return null;
                      }
                      if (!RegExp("[a-zA-Z]").hasMatch(value)) {
                        return null;
                      }
                      return null;
                    },
                    hint: "Full name",
                    controller: authController.fullNameController,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  textAuth(text: "Email"),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  betField( validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "Please enter a valid email",
                    hint: "Example@gmail.com",
                    controller: authController.emailRegController,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  textAuth(text: "Phone number"),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  betField(
                    validator: (val){},
                    hint: "Phone Number",
                    controller: authController.phoneController,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      textAuth(text: "Address"),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),

                      betField(

                        hint: "Select Address",
                        cur: true,
                        isRead: true,
                        onTap: (){
                          Get.to(AddAddress());
                        },

                        textInputType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,

                        controller: authController.addressController,
                        child:    IconButton(
                            onPressed: () {

                            },
                            icon: Icon(
                                Icons.location_searching,
                                size: Get.height * 0.022,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                 // Obx(
                 //   () {
                 //     return
                 //     authController.userType.value=="Gym"?
                 //       Column(
                 //       crossAxisAlignment: CrossAxisAlignment.start,
                 //       children: [
                 //         SizedBox(
                 //           height: Get.height * 0.02,
                 //         ),
                 //         textAuth(text: "Address"),
                 //         SizedBox(
                 //           height: Get.height * 0.01,
                 //         ),
                 //
                 //         betField(
                 //
                 //           hint: "Select Address",
                 //           textInputType: TextInputType.visiblePassword,
                 //           textInputAction: TextInputAction.done,
                 //           controller: authController.addressController,
                 //           child:    IconButton(
                 //               onPressed: () {
                 //                 Get.to(AddAddress());
                 //               },
                 //               icon: Icon(
                 //                   Icons.location_searching,
                 //                   size: Get.height * 0.022,
                 //                   color: Colors.red)),
                 //         ),
                 //       ],
                 //     ):SizedBox.shrink();
                 //   }
                 // ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  textAuth(text: "Password"),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),

                  Obx(() {
                    return betField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        // if(value.length<8)
                        // {
                        //   return 'Password must be greater then 8 character';
                        // }
                        return null;
                      },
                      hint: "Password",
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscure: authController.isVisible1.value,
                      controller: authController.passRegController,
                      child:    IconButton(
                          onPressed: () {
                            authController.updateVisible1Status();
                          },
                          icon: Icon(
                              authController.isVisible1.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: Get.height * 0.022,
                              color: AppColor.blackColor)),
                    );
                  }),


                  SizedBox(
                    height: Get.height * 0.032,
                  ),
                  AppButton(
                      buttonWidth: Get.width,
                      buttonRadius: BorderRadius.circular(10),
                      buttonName: "Sign up",
                      fontWeight: FontWeight.w500,
                      textSize: AppSizes.size_15,
                      buttonColor: AppColor.primaryColor,
                      textColor: AppColor.whiteColor,
                      onTap: () {
                        if(validateProfile(context)){
                          authController.updateLoader(true);
                          ApiManger().registerResponse(context: context);
                        }


                      }),
                  SizedBox(
                    height: Get.height * 0.022,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(LoginView());

                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account ? ",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontFamily: AppFont.regular,
                              fontWeight: FontWeight.w500,
                              fontSize: AppSizes.size_15),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Sign in",
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontFamily: AppFont.medium,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppSizes.size_15)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          return authController.loader.value == false
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
  bool validateProfile(BuildContext context) {

    if (Get.put(AuthController()).userType.value.isEmpty) {
      flutterToast(msg: "Please select user type");
      return false;
    }
    if (Get.put(AuthController()).fullNameController.text.isEmpty) {
      flutterToast(msg: "Please enter full name");
      return false;
    }
    if (Get.put(AuthController()).emailRegController.text.isEmpty) {
      flutterToast(msg: "Please enter email");
      return false;
    }
    if (Get.put(AuthController()).phoneController.text.isEmpty) {
      flutterToast(msg: "Please enter phone number");
      return false;
    }
    if (Get.put(AuthController()).phoneController.text.length<10) {
      flutterToast(msg: "Please enter valid phone number");
      return false;
    }
    if (Get.put(AuthController()).addressController.text.isEmpty) {
      flutterToast(msg: "Please select address");
      return false;
    }
    if (Get.put(AuthController()).passRegController.text.isEmpty) {
      flutterToast(msg: "Please enter password");
      return false;
    }
    if (Get.put(AuthController()).passRegController.text.length<7) {
      flutterToast(msg: "Password must be greater then 7 ");
      return false;
    }






    return true;
  }
}
