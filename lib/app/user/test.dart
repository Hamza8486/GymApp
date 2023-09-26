import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapZoomController extends StatefulWidget {
  @override
  _MapZoomControllerState createState() => _MapZoomControllerState();
}

class _MapZoomControllerState extends State<MapZoomController> {
  GoogleMapController? _controller;
  double _startZoomLevel = 14.0; // Set your desired initial zoom level here

  // Define the minimum and maximum zoom levels
  final double minZoomLevel = 1.0;
  final double maxZoomLevel = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Zoom Controller'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _controller = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(37.43296265331129, -122.08832357078792),
                zoom: _startZoomLevel,
              ),
              onCameraMove: (CameraPosition position) {
                setState(() {
                  _startZoomLevel = position.zoom;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text('Start Zoom Level: ${_startZoomLevel.toStringAsFixed(2)}'),
                Expanded(
                  child: Slider(
                    value: _startZoomLevel,
                    min: minZoomLevel,
                    max: maxZoomLevel,
                    onChanged: (double newValue) {
                      setState(() {
                        _startZoomLevel = newValue;
                      });

                      // Optionally, you can add animation here
                      _controller?.animateCamera(
                        CameraUpdate.zoomTo(newValue),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


