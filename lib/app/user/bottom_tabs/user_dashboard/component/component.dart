

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_text.dart';


class HomeDataWidget extends StatelessWidget {
  HomeDataWidget({Key? key,this.address,this.image,this.desc,required this.onTap,this.session,
    this.child,
    this.male,this.price,
    this.time,
    this.child1,
    this.child2,
    this.days,
    this.time1,
    this.onTap1,

  })
      : super(key: key);

  var image;
  var session;
  var time;
  var days;
  var time1;


  var desc;
  var male;
  var price;
  Widget?child1;

  var address;
  Widget?child;
  Widget?child2;

  VoidCallback onTap;
  VoidCallback?  onTap1;





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:Get.width*0.01 ),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: EdgeInsets.zero,
          color: AppColor.whiteColor,
          shadowColor: Colors.grey.withOpacity(0.5),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),


          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)),
                child:CachedNetworkImage(
                    placeholder: (context, url) =>  Center(
                      child: SpinKitThreeBounce(
                          size: 25,
                          color: AppColor.primaryColor
                      ),
                    ),
                    memCacheHeight: 180,
                    memCacheWidth: 180,
                    imageUrl: image,
                    height: Get.height * 0.099,

                    width: Get.width,
                    fit: BoxFit.cover,

                    errorWidget: (context, url, error) => Image.asset(
                      "assets/img/gym.jpeg",
                      fit: BoxFit.cover,
                      height: Get.height * 0.11,
                      width: Get.width,
                    ),
                ),




              ),
              Container(
                color: Colors.transparent,


                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10,vertical: Get.height*0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(desc??"",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,

                            style: TextStyle(fontSize: AppSizes.size_12,

                                color: AppColor.blackColor,
                                height:Get.height*0.002,
                                fontFamily: AppFont.regular,
                                fontWeight: FontWeight.w600),),
                          Text("$price",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,

                            style: TextStyle(fontSize: AppSizes.size_12,

                                color: AppColor.blackColor,
                                height:Get.height*0.002,
                                fontWeight: FontWeight.w700),),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.007,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(

                            children: [
                              Icon(Icons.female,color: AppColor.greyColors,
                              size: 22,
                              ),
                              SizedBox(
                                width: Get.width * 0.005,
                              ),
                              AppText(
                                title: male,
                                overFlow: TextOverflow.ellipsis,
                                maxLines: 1,
                                size: Get.height * 0.014,
                                textAlign: TextAlign.start,
                                color: AppColor.greyColors,
                                fontFamily: AppFont.medium,
                              ),
                            ],
                          ),
                          AppText(
                            title: session,
                            overFlow: TextOverflow.ellipsis,
                            maxLines: 1,
                            size: Get.height * 0.015,
                            textAlign: TextAlign.start,
                            color: AppColor.greyColors,
                            fontFamily: AppFont.medium,
                          ),
                        ],
                      ),
                      child1??
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.008,
                          ),

                          Row(
                            children: [
                              Icon(Icons.access_time_outlined,color: AppColor.greyColors,
                                size:17,
                              ),
                              SizedBox(
                                width: Get.width * 0.005,
                              ),
                              AppText(
                                title: " $time - $time1",
                                overFlow: TextOverflow.ellipsis,
                                maxLines: 1,
                                size: Get.height * 0.014,
                                textAlign: TextAlign.start,
                                color: AppColor.greyColors,
                                fontFamily: AppFont.medium,
                              ),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(

                        height: Get.height * 0.002,
                      ),
                      Divider( color: AppColor.greyColors.withOpacity(0.5),),
                      child??
                      SizedBox(
                        height: Get.height * 0.005,
                      ),
                      child??
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          child2??
                          Obx(() {
                              return GestureDetector(
                                onTap:
                                Get.put(UserController()).name.value.isEmpty?(){}:

                                onTap1,
                                child: Container(
                                  decoration: BoxDecoration(

                                      border: Border.all(color: AppColor.primaryColor),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.015,vertical: Get.height*0.007),
                                    child: AppText(
                                      title: "Set Appointment",
                                      size: Get.height * 0.011,
                                      fontFamily: AppFont.semi,
                                      color: AppColor.blackColor.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                          Container(
                            decoration: BoxDecoration(

                                border: Border.all(color: AppColor.primaryColor),
                                borderRadius: BorderRadius.circular(6)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width*0.015,vertical: Get.height*0.007),
                              child: AppText(
                                title: "See More",
                                size: Get.height * 0.01,
                                fontFamily: AppFont.semi,
                                color: AppColor.blackColor.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




