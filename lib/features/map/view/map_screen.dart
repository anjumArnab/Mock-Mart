import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  //final Completer<GoogleMapController> _controller =
 // Completer<GoogleMapController>();


/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(23.83899440413541, 90.3796523012575), // Center the map over London, UK
        initialZoom: 9.2,
      ),
      children: [
        TileLayer( // Bring your own tiles
         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.mock_mart',
        ),
        MarkerLayer(
          markers: [
             Marker(
               point: LatLng(23.83899440413541, 90.3796523012575),
              ///width: 50,
              ///height: 50,
               child: Icon(Icons.location_on, color: Colors.red,size: 50,),
             ),
           ],
         ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              ///onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
  }
  ///Future<void> _goToTheLake() async {
  ///  final GoogleMapController controller = await _controller.future;
   /// await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  ///}
}