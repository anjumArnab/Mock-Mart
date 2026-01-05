import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/map/controllers/coordinate_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

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

          final firstBranch = coordinateController.branchList.first;
          final mapCenter = LatLng(
            double.tryParse(firstBranch.latitude) ?? 0,
            double.tryParse(firstBranch.longitude) ?? 0,
          );

          return FlutterMap(
            options: MapOptions(
              initialCenter: mapCenter,
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.mock_mart',
              ),

              MarkerLayer(
                markers: coordinateController.branchList.map((branch) {
                  final lat = double.tryParse(branch.latitude) ?? 0;
                  final lng = double.tryParse(branch.longitude) ?? 0;

                  return Marker(
                    point: LatLng(lat, lng),
                    width: 80,
                    height: 80,
                    child: GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          branch.name,
                          branch.address,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
