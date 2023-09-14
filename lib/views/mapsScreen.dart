import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Constants/elementColors.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MapsScreenWidget();
  }
}

class MapsScreenWidget extends StatefulWidget {
  const MapsScreenWidget({super.key});

  @override
  State<MapsScreenWidget> createState() => _MapsScreenWidgetState();
}

class _MapsScreenWidgetState extends State<MapsScreenWidget> {
  Completer<GoogleMapController> _mapController = Completer();
  bool trafficEnabled = true;
  bool buildingsEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          trafficEnabled: trafficEnabled,
          buildingsEnabled: buildingsEnabled,
          mapToolbarEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(8.354520, 80.510838),
            zoom: 10.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
        ),

      ]),
    );
  }
}
