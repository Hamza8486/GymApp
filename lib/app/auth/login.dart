import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/component.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/auth/register.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/bottom_tabs/map_view/controller/map_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';



class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    SizedBox(
                      height: Get.height * 0.25,
                    ),
                    AppText(
                      title: "Sign in",
                      size: AppSizes.size_24,
                      fontFamily: AppFont.medium,
                      fontWeight: FontWeight.w500,
                      color: AppColor.boldBlackColor,
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    AppText(
                      title: "Enter your registered email address to log in. ",
                      size: AppSizes.size_14,
                      fontFamily: AppFont.regular,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    textAuth(text: "Email",color: Colors.transparent),
                    SizedBox(
                      height: Get.height * 0.013,
                    ),
                    betField( validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email",
                      hint: "Example@gmail.com",
                      controller: authController.emailController,
                    ),

                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textAuth(text: "Password",color: Colors.transparent),
                    SizedBox(
                      height: Get.height * 0.013,
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
                        obscure: authController.isVisible.value,
                        controller: authController.passController,
                        child:    IconButton(
                          onPressed: () {
                        authController.updateVisibleStatus();
                      },
                      icon: Icon(
                      authController.isVisible.value
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
                        buttonName: "Sign in",

                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_15,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          print( Get.put(MapController()).gymNAME.value);
                          print( Get.put(MapController()).gymId.value);
                          print( Get.put(MapController()).gymAmount.value);
                          Get.put(AuthController()).clear();
                          if (formKey.currentState!.validate()) {
                            authController.updateLoginLoader(true);
                            ApiManger().loginResponse(context: context,
                            email: authController.emailController.text,
                              password: authController.passController.text
                            );

                          }

                        }),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(Register());
                          Get.put(AuthController()).clear();
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don’t have an account ?  ",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontFamily: AppFont.regular,
                                fontWeight: FontWeight.w500,
                                fontSize: AppSizes.size_15),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Sign up",
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
        ),
        Obx(() {
          return authController.loaderLogin.value == false
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
}
