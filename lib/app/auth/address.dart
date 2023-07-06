// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_app/app/auth/component.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/gym/home/controller/home_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';

// ignore: must_be_immutable
class AddAddress extends StatefulWidget {
  var phone;
  AddAddress({Key? key, this.phone}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  late GoogleMapController _controller;
  String location = "";

  CameraPosition? cameraPosition;
  late Position currentLocation;
  var geoLocator = Geolocator();
  void locationPosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation = position;
    LatLng latlatPostion = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPositions =
    CameraPosition(target: latlatPostion, zoom: 16);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPositions));
  }

  @override
  void initState() {
    locationPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(48.8561, 2.2930),
                  zoom: 13.0,
                ),
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  locationPosition();
                },
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona;
                },
                onCameraIdle: () async {
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      cameraPosition!.target.latitude,
                      cameraPosition!.target.longitude);
                  setState(() {
                    print(placemarks);
                    print(cameraPosition!.target.latitude);
                    print(cameraPosition!.target.longitude);
                    Get.put(AuthController()).updateLat(cameraPosition!.target.latitude.toString());
                    Get.put(AuthController()).updateLng(cameraPosition!.target.longitude.toString());


                    location = placemarks.first.administrativeArea.toString() +
                        ", " +
                        placemarks.first.street.toString() +
                        ", " +
                        placemarks.first.subLocality.toString() +
                        ", " +
                        placemarks.first.locality.toString();

                    Get.put(AuthController()).addressController.text = location;


                  });
                },
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.02,
                          horizontal: size.width * 0.04),
                      child: Column(
                        children: [
                          AppText(
                              title: "Select Address",
                              color: AppColor.blackColor,
                              fontFamily: AppFont.medium),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          widget.phone=="add"?
                          betField(
                            validator: (val){},
                            hint: "Select Address",
                            controller:

                            Get.put(GymController()).addressController,
                          ):betField(
                            validator: (val){},
                            hint: "Select Address",
                            controller:

                            Get.put(AuthController()).addressController,
                          ),

                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          AppButton(
                              buttonRadius: BorderRadius.circular(10),
                              textSize: size.height * 0.02,
                              buttonWidth: size.width,
                              buttonHeight: size.height * 0.063,
                              buttonName: "Confirm Location",
                              buttonColor: AppColor.primaryColor,
                              textColor: AppColor.whiteColor,
                              onTap: () {
                                Get.back();
                              })
                        ],
                      )),
                )),
            Positioned(
                top: size.height * 0.06,
                right: size.width * 0.03,
                child: InkWell(
                    onTap: () {
                      locationPosition();
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColor.whiteColor.withOpacity(0.9),
                      child: Icon(
                        Icons.location_searching,
                        color: AppColor.boldBlackColor,
                      ),
                    ))),
            Positioned(
                top: size.height * 0.06,
                left: size.width * 0.03,
                child: InkWell(
                    onTap: () {
                     Get.back();
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColor.whiteColor.withOpacity(0.9),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColor.boldBlackColor,
                      ),
                    ))),
            Center(
              //picker image on google map
              child: InkWell(
                  onTap: () {
                    location;
                    print(location);
                  },
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: Get.height*0.04,

                  )),
            )
          ],
        ));
  }
}
