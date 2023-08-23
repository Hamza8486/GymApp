
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/components/video_view.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/gym/home/controller/home_controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';



class GymDetail extends StatefulWidget {
  GymDetail({Key? key,this.data}) : super(key: key);

  var data;

  @override
  State<GymDetail> createState() => _GymDetailState();
}

class _GymDetailState extends State<GymDetail> {
  final homeController = Get.put(HomeController());

  String ? valueDrop;




  VideoPlayerController? _videoController;
  String? selectedVideoPath;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoController = VideoPlayerController.asset(""); //

  }


  bool isCompressing = false;

  Future<void> pickVideo() async {
    XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    double videoDuration = await getVideoDuration(video.path);

    if (videoDuration > 15) {
      flutterToast(msg: "Please select a video that is 15 seconds or less");

    } else {
      setState(() {
        selectedVideoPath = video.path;
        Get.put(HomeController()).updateVideoLoader(true);
        Get.put(GymController()).videoFile=video;
            ApiManger().uploadVideo(gymId:widget.data.id.toString(),
                file:video
            );
      });
    }
  }

  Future<double> getVideoDuration(String videoPath) async {
    VideoPlayerController videoController = VideoPlayerController.file(File(videoPath));
    await videoController.initialize();
    double duration = videoController.value.duration.inSeconds.toDouble();
    await videoController.dispose();
    return duration;
  }


  @override
  void dispose() {
    _videoController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double TotalRate = double.parse(widget.data.rating==null?"0":widget.data.rating.toString());
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
                          RatingBar.builder(
                            initialRating:TotalRate,
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
                          Obx(
                                  () {
                                return
                                homeController.loaderVideo.value?
                                Center(
                                    child: SpinKitThreeBounce(
                                        size: 25, color: AppColor.primaryColor)
                                ):
                                  homeController.getVideoList.isEmpty?SizedBox.shrink():
                                  GestureDetector(
                                    onTap: ()=>pickVideo(),
                                    child: Container(
                                      decoration: BoxDecoration(color: AppColor.primaryColor,borderRadius: BorderRadius.circular(10)),
                                      child:Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                        child: AppText(
                                          title: "Add More",
                                          color: AppColor.whiteColor,
                                          size: AppSizes.size_13,
                                          fontFamily: AppFont.semi,
                                        ),
                                      ),
                                    ),
                                  );
                              }
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),

                      Obx(
                        () {



                          return
                          homeController.loaderDeleteVideo.value?
                          Column(
                            children: [
                              SizedBox(height: Get.height*0.05,),
                              const Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor)
                              ),
                            ],
                          ):
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
                                    return Stack(
                                      children: [

                                        Container(
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


                                        ),
                                        Positioned(
                                          right:0,

                                          child: GestureDetector(
                                              onTap: () {
                                                showAlertDialog(context: context,text: "Do You want to delete it ?",
                                                    yesOnTap: (){

                                                      homeController.updateVideoDeleteLoader(true);
                                                      ApiManger().deleteVideoSingle(context: context,
                                                          id: homeController.getVideoList[index].id.toString()
                                                      );
                                                      Get.back();
                                                    }
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(


                                                ),
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              )),)

                                      ],
                                    );
                                  })):GestureDetector(
                            onTap: ()=>pickVideo(),
                            child: Column(

                                children: [
                                  SizedBox(height: Get.height * 0.01),
                                  SvgPicture.asset("assets/icons/video.svg",
                                    height: Get.height*0.06,),
                                  SizedBox(height: Get.height * 0.01),
                                  Center(
                                      child: AppText(
                                        title: "Click here to add video",
                                        size: Get.height * 0.017,
                                        color: AppColor.blackColor,
                                        textAlign: TextAlign.center,
                                        fontFamily: AppFont.medium,
                                      )),
                                  SizedBox(height: Get.height * 0.005),

                                  Container(
                                    width: Get.width*0.2,
                                    decoration: BoxDecoration(color: AppColor.primaryColor,borderRadius: BorderRadius.circular(10)),
                                    child:Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(width: Get.width*0.01,),
                                          AppText(
                                            title: "Add",
                                            color: AppColor.whiteColor,
                                            size: AppSizes.size_13,
                                            fontFamily: AppFont.medium,
                                          ),

                                          Icon(Icons.add,color: AppColor.whiteColor,size: Get.height*0.02,)
                                        ],
                                      ),
                                    ),
                                  ),                                      ]
                            ),
                          );
                        }
                      )
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
