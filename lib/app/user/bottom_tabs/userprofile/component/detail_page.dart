
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/component/prof_component.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_text.dart';



class OtherDetail extends StatefulWidget {
  OtherDetail({Key? key,this.data}) : super(key: key);

  var data;

  @override
  State<OtherDetail> createState() => _OtherDetailState();
}

class _OtherDetailState extends State<OtherDetail> {
  final homeController = Get.put(UserController());

  String ? valueDrop;

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
                     const CircleAvatar(radius: 4,
                     backgroundColor: Colors.black,
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
                          Text("\$${widget.data.fees.toString()}",
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
                      Divider( color: AppColor.greyColors.withOpacity(0.5),),
                      SizedBox(
                        height: Get.height * 0.015,
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
                      SizedBox(
                        height: Get.height * 0.03,
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
