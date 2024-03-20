import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:route_shuffle/features/map/presentation/notifiers/map_notifier.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_bottom_sheet.dart';

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = useMemoized(Completer<GoogleMapController>.new);

    final mapNotifier = ref.watch(mapNotifierProvider.notifier);
    final mapState = ref.watch(mapNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(0, 0),
                        zoom: 1,
                      ),
                      markers: mapState.userMarker != null
                          ? {mapState.userMarker!}
                          : {},
                      onMapCreated: (controller) {
                        mapController.complete(controller);
                        mapNotifier.getCurrentLocation(
                          onSuccess: (coords) {
                            controller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(
                                    coords.lat,
                                    coords.lng,
                                  ),
                                  zoom: 15,
                                ),
                              ),
                            );
                          },
                          onError: (failure) {},
                        );
                      },
                    ),
                    if (mapState.isLoading)
                      ColoredBox(
                        color: Colors.black.withOpacity(.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
              // const SizedBox(height: 300),
            ],
          ),
          const MapBottomSheet(),
        ],
      ),
    );
  }
}
