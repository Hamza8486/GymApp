
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/components/add_gym.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/components/components.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/components/edit_gym.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/gym/home/controller/home_controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/bottom_sheet.dart';
import 'package:gym_app/app/widgets/helper_function.dart';
import 'package:intl/intl.dart';


class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

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
                        AppText(
                          title: "My Gyms",
                          color: AppColor.blackColor,
                          size: AppSizes.size_17,
                          fontFamily: AppFont.semi,
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.put(GymController()).clear();
                            Get.put(GymController()).clearEdit();
                            Get.put(AuthController()).clear();
                            Get.to(AddGym());
                          },
                          child: Container(
                            height: Get.height * 0.042,
                            width: Get.height * 0.042,
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Get.height * 0.1))),
                            child: Icon(
                              Icons.add,
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
                      return
                        homeController.isLoading.value?

                        ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: 7,
                            itemBuilder: (BuildContext context, int index) {
                              return  Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                margin:  EdgeInsets.only(  top:
                                index==0?0:
                                10,bottom: 10),
                                child: getShimmerLoading(),
                              );
                            }):
                        homeController.gymList.isNotEmpty?
                        ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount:homeController.gymList.length,
                            itemBuilder: (BuildContext context, int index) {

                              return
                                Padding(
                                  padding:  EdgeInsets.only(top:
                                  index ==0?0:
                                  Get.height*0.01,
                                      bottom: Get.height*0.01

                                  ),
                                  child: gymWidget(
                                    onTap1: (){
                                      Get.put(GymController()).clear();
                                      Get.put(GymController()).clearEdit();
                                      Get.put(AuthController()).clear();
                                      Get.to(EditGym(data: homeController.gymList[index],));
                                    },
                                    onTap2: (){
                                      showAlertDialog(
                                          context: context,
                                          text: 'Do you want to delete it ? ',
                                          yesOnTap: () {
                                            Get.back();
                                            showLoading(context: context);
                                            ApiManger().deleteResponse(id:homeController.gymList[index].id.toString() );
                                          });
                                    },
                                      onTap: (){


                                      },
                                      image:homeController.gymList[index].img??"",
                                      name:homeController.gymList[index].name??"",
                                    group:homeController.gymList[index].sessions??"" ,
                                    fee:homeController.gymList[index].fee.toString() ,
                                      address:homeController.gymList[index].address??"" ,
                                      type:homeController.gymList[index].gender??"",
                                    time1: DateFormat.jm().format(DateFormat("hh:mm:ss").parse(homeController.gymList[index].endTime.toString())),
                                    time:DateFormat.jm().format(DateFormat("hh:mm:ss").parse(homeController.gymList[index].startTime.toString())),
                                    days:homeController.gymList[index].days??"",


                                  ),
                                );
                            }):noData();
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
