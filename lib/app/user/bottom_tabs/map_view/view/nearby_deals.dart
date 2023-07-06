import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_app/app/auth/register.dart';
import 'package:gym_app/app/user/bottom_tabs/map_view/component/deals_list.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/confirm_book.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:intl/intl.dart';


class NearbyDealsView extends StatefulWidget {
  const NearbyDealsView({Key? key}) : super(key: key);

  @override
  State<NearbyDealsView> createState() => _NearbyDealsViewState();
}

class _NearbyDealsViewState extends State<NearbyDealsView> {
  final List<Marker> _markers = <Marker>[];
  late BitmapDescriptor customMarker;
  late GoogleMapController _controller;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  String googleApikey = "AIzaSyCKGSdPZC7sop4YTu2zCqNiN2jPeBjWoik";
  CameraPosition? cameraPosition;
  late Position currentLocation;
  var geoLocator = Geolocator();

  BitmapDescriptor? myIcon;
  BitmapDescriptor? myIcon1;
  Future setCustomMapPin() async {

    myIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(1, 1)),

        GetPlatform.isIOS?
        'assets/icons/g3.png':'assets/icons/g3.png'


    );
  }
  Future setCustomMapPin1() async {

    myIcon1 = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(1, 1)),

        GetPlatform.isIOS?
        'assets/icons/g4.png':'assets/icons/g4.png'


    );
  }

  final nearController = Get.put(UserController());

  void locationPosition() async {
    await setCustomMapPin();

    for (int i = 0; i < nearController.mapList.length; i++) {
      final double offset = 0.0001;
      final random = Random();
      final double latOffset = offset * (random.nextDouble() - 0.5);
      final double lngOffset = offset * (random.nextDouble() - 0.5);
      _markers.add(
          Marker(
              onTap: () {
                setState(() {
                  print("This is deal name ${nearController.mapList[i].name}");

                  _customInfoWindowController.addInfoWindow!(
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              isDismissible: true,
                              context: context,
                              builder: (context) => ConfirmOrder(
                                gymId:nearController.mapList[i].id.toString() ,
                                amount:nearController.mapList[i].fees.toString() ,
                              ));

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
                                        nearController.mapList[i].img??"",
                                        height: Get.height * 0.09,
                                        width: Get.height * 0.09,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, exception, stackTrace) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                              "assets/img/gym.jpeg",
                                              height: Get.height * 0.11,
                                              width: Get.height * 0.11,
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
                                                    nearController.mapList[i].name??"",
                                                    maxLines: 1,
                                                    overFlow: TextOverflow.ellipsis,
                                                    fontFamily: AppFont.medium,
                                                    size: AppSizes.size_12,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ),
                                                AppText(
                                                  title:"\$${nearController.mapList[i].fees.toString()}",
                                                  maxLines: 1,
                                                  overFlow: TextOverflow.ellipsis,
                                                  fontFamily: AppFont.medium,
                                                  size: AppSizes.size_12,
                                                  color: AppColor.blackColor,
                                                ),
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
                                                  title: nearController.mapList[i].gender??"",
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
                                            SizedBox(
                                              width: Get.width * 0.44,
                                              child: AppText(
                                                title:
                                                "${nearController.mapList[i].address}",
                                                maxLines: 1,
                                                overFlow: TextOverflow.ellipsis,
                                                color: AppColor.greyColors,
                                                fontFamily: AppFont.medium,
                                                size: AppSizes.size_12,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.008,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color:  AppColor.primaryColor,
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.027,vertical: Get.height*0.007),
                                                    child: AppText(
                                                      title: "Book Now",
                                                      size: Get.height * 0.01,
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
                                      title: " ${DateFormat.jm().format(DateFormat("hh:mm").parse(nearController.mapList[i].startTime??""))} - "
                                          "${DateFormat.jm().format(DateFormat("hh:mm").
                                      parse(nearController.mapList[i].endTime??""))}",
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
                                  height: Get.height * 0.008,
                                ),

                                Row(
                                  children: [
                                    AppText(
                                      title: "Open Days: ",
                                      overFlow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      size: Get.height * 0.014,
                                      letterSpacing: 0.7,
                                      textAlign: TextAlign.start,
                                      color: AppColor.black,
                                      fontFamily: AppFont.semi,
                                    ),
                                    SizedBox(width: 5,),
                                    AppText(
                                      title:nearController.mapList[i].days??"",
                                      overFlow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      size: Get.height * 0.014,
                                      letterSpacing: 0.7,
                                      textAlign: TextAlign.start,
                                      color: AppColor.greyColors,
                                      fontFamily: AppFont.medium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                      LatLng(
                          double.parse(nearController.mapList[i].lat.toString()) +
                              latOffset,
                          double.parse(nearController.mapList[i].loong.toString()) +
                              lngOffset)


                  );
                });
              },
              icon:  myIcon!,
              markerId: MarkerId(nearController.mapList[i].id.toString()
              ),
              position:


              LatLng(
                  double.parse(nearController.mapList[i].lat.toString()) +
                      latOffset,
                  double.parse(nearController.mapList[i].loong.toString()) +
                      lngOffset)
          )
      );
    }


  }

  String mapStyle = "";

  void locationCurrentPosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation = position;
    LatLng latPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPositin =
        CameraPosition(target: latPosition, zoom: 12.0);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPositin));

    setState(() {
      _markers.add(
          Marker(

              markerId: MarkerId("location"),
              position: LatLng(position.latitude, position.longitude),
              icon: myIcon1!

          )
      );
    });
  }

  @override
  void initState() {
    super.initState();
    locationCurrentPosition();

    setState(() {
      locationCurrentPosition();
      locationPosition();
      setCustomMapPin1();
    });

    rootBundle.loadString('assets/img/uber.json').then((string) {
      mapStyle = string;
    });
  }

  Timer? debounce;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // setState(() {
    //   locationPosition();
    // });
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          width: Get.width,
          height: Get.height * 0.6,
          child: Stack(
            children: [
              Obx(() {
                locationPosition();
                  return GoogleMap(
                    markers: Set<Marker>.of(_markers),
                    trafficEnabled: false,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,

                    onTap: (position) {
                      _customInfoWindowController.hideInfoWindow!();

                    },
                    onCameraMove: (position) {
                      _customInfoWindowController.onCameraMove!();
                      if (debounce != null) debounce?.cancel();

                      setState(() {
                        debounce = Timer(const Duration(milliseconds: 500), () {
                          _markers.removeRange(1, _markers.length);
                          nearController.mapMyData(
                              lat: position.target.latitude,
                              lng: position.target.longitude);
                          locationPosition();
                        });
                      });
                    },
                    myLocationEnabled:nearController.isLoading.value?false: false,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(37.43296265331129, -122.08832357078792),
                      zoom: 14.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      setState(() {
                        _customInfoWindowController.googleMapController =
                            controller;
                        _controller = controller;
                        _controller.setMapStyle(mapStyle);
                      });
                    },
                  );
                }
              ),
              CustomInfoWindow(
                controller: _customInfoWindowController,
                width: Get.height * 0.35,
                offset: 30,
                height: Get.height * 0.2,
              ),

            ],
          ),
        ),
        NearByDealList(),
        Positioned(
            top: size.height * 0.08,
            right: size.width * 0.03,
            child: InkWell(
                onTap: () {
                  setState(() {
                    locationCurrentPosition();
                  });
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColor.whiteColor.withOpacity(0.9),
                  child: Icon(
                    Icons.location_searching,
                    color: AppColor.primaryColor,
                  ),
                ))),
      ],
    ),
      floatingActionButton: Obx(
        () {
          return
            Get.put(UserController()).name.value.isNotEmpty?SizedBox.shrink():
            FloatingActionButton.extended(
            backgroundColor: AppColor.primaryColor,
            onPressed: () {
              Get.to(Register());
            },
            label: Text('Add New Gyms'),
            icon: Icon(Icons.add),
          );
        }
      ),



    );

  }

}
