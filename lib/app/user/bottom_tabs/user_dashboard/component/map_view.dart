// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart' show rootBundle;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/confirm_book.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/user_detail.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class MapViewPage extends StatefulWidget {
  MapViewPage({Key? key,this.data,this.data1}) : super(key: key);
  var data;
  var data1;

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  late GoogleMapController _controller;
  final CustomInfoWindowController _customInfoWindowController =
  CustomInfoWindowController();
  // late String _mapStyle;
  String googleApikey = "AIzaSyCKGSdPZC7sop4YTu2zCqNiN2jPeBjWoik";
  CameraPosition? cameraPosition;
  late Position currentLocation;
  var geoLocator = Geolocator();
  final List<Marker> _markers = <Marker>[];
  BitmapDescriptor? myIcon;
  Future setCustomMapPin() async {

    myIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(1, 1)),

        GetPlatform.isIOS?
        'assets/icons/g3.png':'assets/icons/g3.png'


    );
  }



  void locationPosition() async {
    await setCustomMapPin();
    print(widget.data1.length);
    for (int i = 0; i < widget.data1.length; i++) {
      final double offset = 0.0001;
      final random = Random();
      final double latOffset = offset * (random.nextDouble() - 0.5);
      final double lngOffset = offset * (random.nextDouble() - 0.5);
      _markers.add(
          Marker(
              onTap: () {
                setState(() {
                  print("This is deal name ${widget.data1[i].name}");

                  _customInfoWindowController.addInfoWindow!(
                      GestureDetector(
                        onTap: () {

                          Get.put(UserController()).getVideoData(id:widget.data1[i].id.toString() );

                          Get.to(UserGymDetail(data:widget.data1[i] ,));


                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.whiteColor,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        widget.data1[i].img,
                                        height: Get.height * 0.09,
                                        width: Get.height * 0.09,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, exception, stackTrace) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                              "assets/img/gym.jpeg",
                                              height: Get.height * 0.09,
                                              width: Get.height * 0.09,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.015),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Get.width * 0.33,
                                                  child: AppText(
                                                    title:
                                                    widget.data1[i].name,
                                                    maxLines: 1,
                                                    overFlow: TextOverflow.ellipsis,
                                                    fontFamily: AppFont.medium,
                                                    size: AppSizes.size_12,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ),
                                                Text("${widget.data1[i].fees.toString()}₣",
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
                                              height: Get.height * 0.006,
                                            ),

                                            Row(

                                              children: [
                                                Icon(Icons.female,color: AppColor.primaryColor,
                                                  size: 22,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.005,
                                                ),
                                                AppText(
                                                  title: widget.data1[i].gender,
                                                  overFlow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  size: Get.height * 0.014,
                                                  textAlign: TextAlign.start,
                                                  color: AppColor.greyColors,
                                                  fontFamily: AppFont.medium,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.007,
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.access_time_outlined,color: AppColor.greyColors,
                                                      size:17,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.005,
                                                    ),
                                                    AppText(
                                                      title: " ${DateFormat.jm().format(DateFormat("hh:mm").parse(widget
                                                          .data1[i].startTime??""))} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(widget
                                                          .data1[i].endTime??""))}",
                                                      overFlow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      size: Get.height * 0.012,
                                                      textAlign: TextAlign.start,
                                                      color: AppColor.greyColors,
                                                      fontFamily: AppFont.medium,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: Get.width*0.012,),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color:  AppColor.primaryColor,
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.027,vertical: Get.height*0.007),
                                                    child: AppText(
                                                      title: "See Detail",
                                                      size: Get.height * 0.009,
                                                      fontFamily: AppFont.semi,
                                                      color: AppColor.whiteColor,
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

                              ],
                            ),
                          ),
                        ),
                      ),


                      LatLng(
                          double.parse(widget
                              .data1[i].lat.toString()) +
                              latOffset,
                          double.parse(widget
                              .data1[i].loong.toString()) +
                              lngOffset)


                  );
                });
              },
              icon:  myIcon!,
              markerId: MarkerId(widget.data1[i].id.toString()
              ),
              position:


              LatLng(
                  double.parse(widget
                      .data1[i].lat.toString()) +
                      latOffset,
                  double.parse(widget
                      .data1[i].loong.toString()) +
                      lngOffset)
          )
      );
    }

    setState(() {});
  }



  @override
  void initState() {
    super.initState();
    setState(() {
      locationPosition();
    });

    rootBundle.loadString('assets/img/uber.json').then((string) {
      mapStyle = string;
    });

  }
  String mapStyle ="";
  LatLng firstLocation = LatLng(28.3605, 81.5101);
  LatLng secondLocation = LatLng(28.3605, 81.5101);
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height,
              child: Stack(
                children: [
                  GoogleMap(
                    onTap: (position) {
                      setState(() {
                        _customInfoWindowController.hideInfoWindow!();
                      });
                    },
                    onCameraMove: (position) {
                      _customInfoWindowController.onCameraMove!();
                    },
                    markers: Set<Marker>.of(_markers),
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationEnabled: false,
                    initialCameraPosition:  CameraPosition(
                      target:
                      LatLng(double.parse(widget.data1.first.lat.toString()), double.parse(widget.data1.first.loong.toString())),
                      zoom:
                          Get.put(UserController()).radius.value=="10"?12.0:
                          Get.put(UserController()).radius.value=="20"?11.0:
                          Get.put(UserController()).radius.value=="30"?10.0:
                          Get.put(UserController()).radius.value=="40"?10.0:
                          Get.put(UserController()).radius.value=="50"?9.0:

                      5.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      setState(() {
                        _customInfoWindowController.googleMapController =
                            controller;
                        _controller = controller;
                        _controller.setMapStyle(mapStyle);
                      });
                    },
                  ),
                  CustomInfoWindow(
                    controller: _customInfoWindowController,
                    width: Get.height * 0.35,
                    offset: 30,
                    height: Get.height * 0.13,
                  ),
                ],
              ),
            ),

            Positioned(
                top: size.height * 0.07,
                left: size.width * 0.03,
                child: InkWell(
                  onTap: () {

                  },
                  child:    backButton(onTap: (){

                    Get.back();
                  }),

                )

            ),
          ],
        ));
  }
}
