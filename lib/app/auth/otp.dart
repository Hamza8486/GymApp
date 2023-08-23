import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, this.data}) : super(key: key);
  var data;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  String currentText = "";
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: AppPaddings.mainHomePadding,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: Get.height * 0.035,
                            ))),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    AppText(
                      title: 'Verify your\nEmail Address ?',
                      size: AppSizes.size_22,
                      fontWeight: FontWeight.w700,
                      color: AppColor.boldBlackColor,
                      fontFamily: AppFont.semi,
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            title: "Check your SMS messages. we've sent you",
                            size: AppSizes.size_14,
                            color: AppColor.boldBlackColor,
                            fontFamily: AppFont.medium,
                          ),
                          Row(
                            children: [
                              AppText(
                                title: "the Pin at ",
                                size: AppSizes.size_14,
                                color: AppColor.boldBlackColor,
                                fontFamily: AppFont.medium,
                              ),
                              AppText(
                                title: widget.data == "otp"
                                    ? Get.put(AuthController())
                                        .emailRegController
                                        .text
                                    : Get.put(AuthController())
                                        .emailController
                                        .text,
                                size: AppSizes.size_14,
                                color: Colors.grey,
                                fontFamily: AppFont.medium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "Please enter valid otp";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          fieldHeight: Get.height * 0.06,
                          fieldWidth: Get.height * 0.06,
                          shape: PinCodeFieldShape.box,
                          borderWidth: 1,
                          activeColor: AppColor.blackColor,
                          inactiveColor: AppColor.greyColor,
                          inactiveFillColor: AppColor.whiteColor,
                          activeFillColor: AppColor.whiteColor,
                          selectedFillColor: AppColor.whiteColor,
                          selectedColor: AppColor.blackColor,
                          disabledColor: AppColor.blackColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        cursorColor: AppColor.primaryColor,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        autoDisposeControllers: false,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: "Verify Otp",
                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_15,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap:
                          widget.data=="otp"?
                            ()

                        {
                          if (formKey.currentState!.validate()) {
                            if(currentText.length==4){
                              Get.put(AuthController()).updateOtp(true);
                              ApiManger().otpResponse(context: context,email: Get.put(AuthController()).emailRegController.text,
                                  otp: textEditingController.text
                              );
                            }
                            else{
                              flutterToast(msg: "Please enter valid otp");
                            }

                          }
                        }:    ()

                          {
                            if (formKey.currentState!.validate()) {
                              if(currentText.length==4){
                                Get.put(AuthController()).updateOtp(true);
                                ApiManger().otpResponse(context: context,email: Get.put(AuthController()).emailController.text,
                                    otp: textEditingController.text
                                );
                              }
                              else{
                                flutterToast(msg: "Please enter valid otp");
                              }

                            }
                          }

                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          return Get.put(AuthController()).otp.value == false
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
