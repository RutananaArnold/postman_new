import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:postman/screens/panel_body.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/location_services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late LocationData myLocation;
  // myLocation = await LocationService().getLocation();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: size.height * 0.2,
        maxHeight: size.height * 0.9,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        parallaxEnabled: false,
        parallaxOffset: 0,
        panelBuilder: (controller) => PanelBody(
          controller: controller,
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) async {
            myLocation = await LocationService().getLocation();
            setState(() {
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target:
                          LatLng(myLocation.latitude!, myLocation.longitude!),
                      zoom: 27)
                  //17 is new zoom level
                  ));
            });
          },
        ),
      ),
    );
  }
}
