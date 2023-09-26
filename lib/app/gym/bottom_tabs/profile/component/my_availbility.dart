
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/gym/home/controller/home_controller.dart';


import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/helper_function.dart';
import 'package:intl/intl.dart';




class GymAppointAll extends StatefulWidget {
  GymAppointAll({Key? key}) : super(key: key);

  @override
  State<GymAppointAll> createState() => _GymAppointAllState();
}

class _GymAppointAllState extends State<GymAppointAll> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
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
                        GestureDetector(
                          onTap:(){
                            Get.back();
                          },
                          child: Container(
                              color: Colors.transparent,

                              child: Icon(Icons.arrow_back_ios)),
                        ),

                        AppText(
                          title: "My Appointments",
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
              child:  Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.005,
                      ),

                      Obx(
                              () {
                            return
                              homeController.gymAppoint.value?
                              Column(
                                children: [
                                  SizedBox(height: Get.height*0.3,),
                                  Center(
                                      child: SpinKitThreeBounce(
                                          size: 25, color: AppColor.primaryColor1)
                                  ),
                                ],
                              ):

                              homeController.gymAppointList.isNotEmpty?
                              ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  reverse: true,
                                  physics: const BouncingScrollPhysics(),
                                  padding: homeController.gymAppointList

                                      .isNotEmpty
                                      ? EdgeInsets.zero
                                      : EdgeInsets.zero,
                                  itemCount: homeController.gymAppointList
                                      .length,
                                  itemBuilder: (BuildContext context, int index) {

                                    return Padding(
                                      padding: EdgeInsets.symmetric(

                                          vertical: Get.height * 0.01),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: AppColor.secondary,
                                                width: 1
                                            )
                                        ),
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.018),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  AppText(
                                                    title: "User Name : ",
                                                    color: Colors.black,
                                                    size: Get.height * 0.017,
                                                    fontWeight: FontWeight.w600,

                                                  ),
                                                  AppText(
                                                    title: homeController.gymAppointList[index].userName
                                                        .toString(),
                                                    color: Colors.black.withOpacity(0.7),
                                                    size: Get.height * 0.017,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: Get.height*0.017,),
                                              Row(
                                                children: [
                                                  AppText(
                                                    title: "Gym Name : ",
                                                    color: Colors.black,
                                                    size: Get.height * 0.017,
                                                    fontWeight: FontWeight.w600,

                                                  ),
                                                  AppText(
                                                    title: homeController.gymAppointList[index].gymName
                                                        .toString(),
                                                    color: Colors.black.withOpacity(0.7),
                                                    size: Get.height * 0.017,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: Get.height*0.017,),
                                              Row(
                                                children: [
                                                  AppText(
                                                    title: "Appointment Date : ",
                                                    color: Colors.black,
                                                    size: Get.height * 0.017,
                                                    fontWeight: FontWeight.w600,

                                                  ),
                                                  AppText(
                                                    title: homeController.gymAppointList[index].appointmentDate
                                                        .toString(),
                                                    color: Colors.black.withOpacity(0.7),
                                                    size: Get.height * 0.017,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: Get.height*0.017,),
                                              Row(
                                                children: [
                                                  AppText(
                                                    title: "Appointment Time : ",
                                                    color: Colors.black,
                                                    size: Get.height * 0.017,
                                                    fontWeight: FontWeight.w600,

                                                  ),
                                                  AppText(
                                                    title:
                                                    DateFormat.jm().format(DateFormat("hh:mm").parse(homeController.gymAppointList[index].appointmentStartTime.toString()))

                                                    ,
                                                    color: Colors.black.withOpacity(0.7),
                                                    size: Get.height * 0.017,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }):noData(height: Get.height*0.3);
                          }
                      ),


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
