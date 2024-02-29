import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:route_shuffle/features/map/presentation/notifiers/map_notifier.dart';

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = useMemoized(Completer<GoogleMapController>.new);
    final mapState = ref.watch(mapNotifierProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(mapNotifierProvider.notifier).getCurrentLocation(
          onSuccess: (coords) async{
            final controller = await mapController.future;
            await controller.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(coords.lat, coords.lng),
              ),
            );
          },
          onError: (failure, openSettings) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error),
                    Expanded(child: Text(failure.message)),
                    TextButton(
                      onPressed: openSettings,
                      child: const Text('Open Settings'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        child: const Icon(Icons.gps_fixed),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 300,
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Bottom Sheet'),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 1,
            ),
            onMapCreated: mapController.complete,
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: FloatingActionButton(
          //       onPressed: () =>
          //           ref.read(mapNotifierProvider.notifier).getCurrentLocation(
          //         onSuccess: (coords) async{
          //           final controller = await mapController.future;
          //           await controller.animateCamera(
          //             CameraUpdate.newLatLng(
          //               LatLng(coords.lat, coords.lng),
          //             ),
          //           );
          //         },
          //         onError: (failure, openSettings) {
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             SnackBar(
          //               content: Row(
          //                 children: [
          //                   const Icon(Icons.error),
          //                   Expanded(child: Text(failure.message)),
          //                   TextButton(
          //                     onPressed: openSettings,
          //                     child: const Text('Open Settings'),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //       child: const Icon(Icons.gps_fixed),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
