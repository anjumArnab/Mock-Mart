import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/map/controllers/coordinate_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  LatLngBounds boundWithMaximumLatLngPoint(List<LatLng> list) {
    assert(list.isNotEmpty);
    var s = list.first.latitude,
        n = list.first.latitude,
        w = list.first.longitude,
        e = list.first.longitude;
    for (var i = 1; i < list.length; i++) {
      var latlng = list[i];
      s = min(s, latlng.latitude);
      n = max(n, latlng.latitude);
      w = min(w, latlng.longitude);
      e = max(e, latlng.longitude);
    }
    return LatLngBounds(southwest: LatLng(s, w), northeast: LatLng(n, e));
  }

  Future<void> zoomToFit(GoogleMapController? controller, LatLngBounds? bounds, LatLng centerBounds, double bearing, {double padding = 0.5}) async {
    if (controller == null || bounds == null) return;

    bool keepZoomingOut = true;

    while(keepZoomingOut) {
      final LatLngBounds screenBounds = await controller.getVisibleRegion();
      if(fits(bounds, screenBounds)) {
        keepZoomingOut = false;
        final double zoomLevel = await controller.getZoomLevel() - padding;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
          bearing: bearing,
        )));
        break;
      }
      else {
        // Zooming out by 0.1 zoom level per iteration
        final double zoomLevel = await controller.getZoomLevel() - 0.3;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck = screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck = screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck = screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck = screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck && northEastLongitudeCheck && southWestLatitudeCheck && southWestLongitudeCheck;
  }

  void _onMapCreated(GoogleMapController controller, List<LatLng> points) async {
    _mapController = controller;

    // Wait for map to be ready
    await Future.delayed(const Duration(milliseconds: 500));

    if (points.length >= 2) {
      final LatLngBounds bounds = boundWithMaximumLatLngPoint(points);

      final LatLng centerBounds = LatLng(
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
      );

      await zoomToFit(_mapController, bounds, centerBounds, 0.0, padding: 0.5);
    }
  }

  final LatLng _startLocation = LatLng(23.83899440413541, 90.3796523012575);
  final LatLng _endLocation = LatLng(23.3546, 90.232);

  Set<Polyline> _createPolylines() {
    final PolylineId polylineId = PolylineId('route');

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      color: Colors.blue,
      width: 5,
      points: [_startLocation, _endLocation],
      patterns: [
        PatternItem.dash(30),
        PatternItem.gap(20),
      ],
    );

    return {polyline};
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Branches Map')),
      body: GetBuilder<CoordinateController>(
        builder: (coordinateController) {
          if (coordinateController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (coordinateController.branchList.isEmpty) {
            return const Center(child: Text('No branches found.'));
          }

          final List<LatLng> points = coordinateController.branchList
              .map((branch) {
            final lat = double.tryParse(branch.latitude) ?? 0;
            final lng = double.tryParse(branch.longitude) ?? 0;
            return LatLng(lat, lng);
          })
              .where((point) => point.latitude != 0 && point.longitude != 0)
              .toList();

          final firstBranch = coordinateController.branchList.first;
          final mapCenter = LatLng(
            double.tryParse(firstBranch.latitude) ?? 0,
            double.tryParse(firstBranch.longitude) ?? 0,
          );

          final CameraPosition initialCameraPosition = CameraPosition(
            target: mapCenter,
            zoom: 10,
          );

          final Set<Marker> branchMarkers = coordinateController.branchList
              .map((branch) {
            final lat = double.tryParse(branch.latitude) ?? 0;
            final lng = double.tryParse(branch.longitude) ?? 0;
            return Marker(
              markerId: MarkerId(branch.name ?? 'branch_${branch.id}'),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(
                title: branch.name ?? 'Branch',
                snippet: branch.address ?? '',
              ),
              onTap: () => Get.snackbar(
                branch.name ?? 'Branch',
                branch.address ?? '',
                snackPosition: SnackPosition.BOTTOM,
              ),
            );
          })
              .toSet();

          return RepaintBoundary(
            child: GoogleMap(
               initialCameraPosition: initialCameraPosition,
              mapType: MapType.normal,
              onMapCreated: (controller) => _onMapCreated(controller, points),
              markers: branchMarkers,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              polylines: _createPolylines(),
            ),
          );
        },
      ),
    );
  }
}