
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/auth/login.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/components/video_view.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/component/give_rating.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';

import 'package:intl/intl.dart';



class UserGymDetail extends StatefulWidget {
  UserGymDetail({Key? key,this.data,this.data1}) : super(key: key);
  var data1;

  var data;

  @override
  State<UserGymDetail> createState() => _UserGymDetailState();
}

class _UserGymDetailState extends State<UserGymDetail> {
  final homeController = Get.put(UserController());

  String ? valueDrop;















  @override
  Widget build(BuildContext context) {
    double TotalRate = double.parse(widget.data.avgRating==null?"0":widget.data.avgRating.toString());
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
                          title: "Gym Details",
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
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),

                      ClipRRect(
                        borderRadius:BorderRadius.circular(10),
                        child:CachedNetworkImage(
                          placeholder: (context, url) =>  Center(
                            child: SpinKitThreeBounce(
                                size: 25,
                                color: AppColor.primaryColor
                            ),
                          ),
                          imageUrl: widget.data.img,
                          height: Get.height * 0.21,
                          memCacheHeight: 180,
                          memCacheWidth: 180,
                          width: Get.width,
                          fit: BoxFit.cover,

                          errorWidget: (context, url, error) => Image.asset(
                            "assets/img/gym.jpeg",
                            fit: BoxFit.cover,
                            height: Get.height * 0.21,
                            width: Get.width,
                          ),
                        ),




                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Center(
                        child: const CircleAvatar(radius: 4,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.data1=="my"?
                          RatingBar.builder(
                            initialRating:
                            double.parse(widget.data.rating==null?"0":widget.data.rating.toString()),
                            itemSize: 17,
                            ignoreGestures: true,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              debugPrint(rating.toString());
                            },
                          ):RatingBar.builder(
                            initialRating:

                            TotalRate,
                            itemSize: 17,
                            ignoreGestures: true,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              debugPrint(rating.toString());
                            },
                          ),

                          AppText(
                            title:"(${widget.data.totalRatings==0?"0":widget.data.totalRatings.toString()})",
                            size: AppSizes.size_11,
                            color: AppColor.blackColor,
                            fontFamily: AppFont.medium,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.data.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,

                            style: TextStyle(fontSize: AppSizes.size_14,

                                color: AppColor.blackColor,
                                height:Get.height*0.002,
                                fontFamily: AppFont.semi,
                                fontWeight: FontWeight.w600),),
                          Text("${DateFormat.jm().format(DateFormat("hh:mm").parse(widget.data.startTime.toString()))} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(widget.data.endTime.toString()))}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,

                            style: TextStyle(fontSize: AppSizes.size_12,

                                color: AppColor.blackColor,
                                height:Get.height*0.002,
                                fontFamily: AppFont.regular,
                                fontWeight: FontWeight.w600),),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(

                            children: [
                              Icon(Icons.female,color: AppColor.primaryColor,
                                size: 28,
                              ),
                              SizedBox(
                                width: Get.width * 0.005,
                              ),
                              AppText(
                                title: widget.data.gender,
                                overFlow: TextOverflow.ellipsis,
                                maxLines: 1,
                                size: Get.height * 0.017,
                                textAlign: TextAlign.start,
                                color: AppColor.greyColors,
                                fontFamily: AppFont.medium,
                              ),
                            ],
                          ),
                          AppText(
                            title: widget.data.sessions,
                            overFlow: TextOverflow.ellipsis,
                            maxLines: 1,
                            size: Get.height * 0.017,
                            textAlign: TextAlign.start,
                            color: AppColor.greyColors,
                            fontFamily: AppFont.medium,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Row(

                        children: [
                          Icon(Icons.calendar_month,color: AppColor.primaryColor,
                            size: 24,
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          AppText(
                            title: widget.data.days,
                            overFlow: TextOverflow.ellipsis,
                            maxLines: 1,
                            size: Get.height * 0.017,
                            textAlign: TextAlign.start,
                            color: AppColor.greyColors,
                            fontFamily: AppFont.medium,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Row(

                        children: [
                          Icon(Icons.sports_gymnastics,color: AppColor.primaryColor,
                            size: 24,
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          AppText(
                            title: widget.data.types,
                            overFlow: TextOverflow.ellipsis,
                            maxLines: 1,
                            letterSpacing: 1,
                            size: Get.height * 0.017,
                            textAlign: TextAlign.start,
                            color: AppColor.greyColors,
                            fontFamily: AppFont.medium,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Divider( color: AppColor.greyColors.withOpacity(0.5),),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(

                        children: [
                          SvgPicture.asset(
                            "assets/icons/pin.svg",
                            color: AppColor.primaryColor,
                            height: Get.height * 0.025,
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Flexible(
                            child: SizedBox(
                              width: Get.width*0.8,
                              child: AppText(
                                title: widget.data.address,
                                overFlow: TextOverflow.ellipsis,
                                maxLines: 2,
                                size: Get.height * 0.015,
                                textAlign: TextAlign.start,
                                color: AppColor.greyColors,
                                fontFamily: AppFont.medium,
                              ),
                            ),
                          ),
                        ],
                      ),

                     widget.data1=="my"?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Obx(
                                  () {
                                return
                                  homeController.otherGymsList.isNotEmpty?

                                  Column(
                                    crossAxisAlignment:
                                    homeController.otherGymsList.isNotEmpty?  CrossAxisAlignment.start:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: AppText(
                                          title: "Other premium members:",
                                          overFlow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          size: AppSizes.size_16,
                                          textAlign: TextAlign.start,
                                          color: AppColor.black,
                                          fontFamily: AppFont.semi,
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.03,
                                      ),
                                      Obx(
                                              () {
                                            return


                                              SizedBox(
                                                height: Get.height*0.085,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    scrollDirection: Axis.horizontal,
                                                    physics: const BouncingScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemCount:homeController.otherGymsList.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return Padding(
                                                        padding:  EdgeInsets.only(left:index==0?0: 10,right: 10),
                                                        child: Card(
                                                          margin: EdgeInsets.symmetric(vertical: 1),
                                                          color:AppColor.white,
                                                          elevation: 1.5,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(10),
                                                              side: BorderSide(
                                                                  color: AppColor.primaryColor
                                                                      .withOpacity(0.1))),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                              left: Get.width * 0.022,right: Get.width * 0.082,
                                                            ),
                                                            child: Row(

                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:BorderRadius.circular(100),
                                                                  child:CachedNetworkImage(
                                                                    placeholder: (context, url) =>  Center(
                                                                      child: SpinKitThreeBounce(
                                                                          size: 25,
                                                                          color: AppColor.primaryColor
                                                                      ),
                                                                    ),
                                                                    imageUrl: "",
                                                                    height: Get.height * 0.052,
                                                                    width: Get.height * 0.052,
                                                                    fit: BoxFit.cover,

                                                                    errorWidget: (context, url, error) => ClipRRect(
                                                                      borderRadius: BorderRadius.circular(100),
                                                                      child: Image.asset(
                                                                        "assets/img/person1.png",
                                                                        fit: BoxFit.cover,
                                                                        height: Get.height * 0.055,
                                                                        width: Get.height * 0.055,
                                                                      ),
                                                                    ),
                                                                  ),




                                                                ),
                                                                SizedBox(width: Get.width*0.025,),
                                                                AppText(
                                                                  title: homeController.otherGymsList[index].fullName??"",
                                                                  size: AppSizes.size_16,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: AppFont.medium,
                                                                  color: AppColor.black,
                                                                ),


                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              );
                                          }
                                      )
                                    ],
                                  ):SizedBox.shrink();
                              }
                          )
                        ],
                      ):SizedBox.shrink(),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            title: "Video Gallery : ",
                            overFlow: TextOverflow.ellipsis,
                            maxLines: 1,
                            letterSpacing: 1,
                            size: AppSizes.size_16,
                            textAlign: TextAlign.start,
                            color: AppColor.blackColor,
                            fontFamily: AppFont.semi,
                          ),
                        Container()
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),

                      Obx(
                              () {



                            return

                              homeController.isVideoLoading.value?
                              Column(
                                children: [
                                  SizedBox(height: Get.height*0.05,),
                                  const Center(
                                      child: SpinKitThreeBounce(
                                          size: 25, color: AppColor.primaryColor)
                                  ),
                                ],
                              ):
                              homeController.getVideoList.isNotEmpty?

                              SizedBox(
                                  height: Get.height*0.16,
                                  child:   ListView.builder(
                                      itemCount: homeController.getVideoList.length,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index) {
                                        return  Container(
                                          margin: EdgeInsets.symmetric(horizontal: Get.width*0.015,vertical: 10),
                                          width: Get.width*0.26,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.black),



                                          ),
                                          child: GestureDetector(
                                            onTap:(){
                                              Get.to(VideoViewDetail(data:homeController.getVideoList[index].path ,));
                                            },
                                            child: SvgPicture.asset("assets/icons/video.svg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),


                                        );
                                      })):

                                  noData(height: Get.height*0.05);
                          }
                      ),
                      SizedBox(
                        height: Get.height * 0.015,),
                    ],
                  ),
                ),
              )
          ),


         widget.data1=="my"?(
             widget.data.isRated!=0?SizedBox.shrink():
             Padding(
           padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: 10),
           child: AppButton(buttonName: "Give Rating", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor,
             fontFamily: AppFont.semi,

             onTap:  (){
               showModalBottomSheet(
                   backgroundColor: Colors.transparent,
                   isScrollControlled: true,
                   isDismissible: true,
                   context: context,
                   builder: (context) => ReviewSheet(
                     data: widget.data,

                   ));



             },
             buttonRadius: BorderRadius.circular(10),
             buttonWidth: Get.width,
           ),
         )):
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(
               height: Get.height * 0.03,),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   AppText(
                     title: "Total fees ",
                     color: AppColor.blackColor,
                     fontFamily: AppFont.medium,
                     size: AppSizes.size_15,
                   ),
                   Text("₣ ${widget.data.fees.toString()}",
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                     textAlign: TextAlign.start,

                     style: TextStyle(fontSize: AppSizes.size_15,

                         color: AppColor.greyColors,
                         height:Get.height*0.002,
                         fontWeight: FontWeight.w600),),



                 ],
               ),
             ),
             SizedBox(
               height: Get.height * 0.02,
             ),

             Obx(
                     () {
                   return
                     Get.put(UserController()).payLoader.value?
                     Center(
                         child: SpinKitThreeBounce(
                             size: 25, color: AppColor.primaryColor1)
                     ):

                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                       child: AppButton(buttonName: "Pay Now", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor,
                         fontFamily: AppFont.semi,

                         onTap:  (){
                           Get.put(UserController()).updatePayLoader(true);
                           ApiManger().payResponse(gym: widget.data.id.toString(),amount: widget.data.fees.toString());



                         },
                         buttonRadius: BorderRadius.circular(10),
                         buttonWidth: Get.width,
                       ),
                     );
                 }
             )

           ],
         )


        ],
      ),
    );
  }
}
