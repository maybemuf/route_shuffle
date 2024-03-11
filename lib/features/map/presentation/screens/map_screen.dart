import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:route_shuffle/core/utils/measure_util.dart';
import 'package:route_shuffle/features/map/presentation/notifiers/map_notifier.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_action_block.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_bottom_sheet.dart';

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = useMemoized(Completer<GoogleMapController>.new);

    final mapNotifier = ref.watch(mapNotifierProvider.notifier);
    final mapState = ref.watch(mapNotifierProvider);
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
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
                      SizedBox(height: _getBlockHeight(context).height - 30),
                ],
              );
            },
          ),
          MapBottomSheet(height: _getBlockHeight(context).height),
        ],
      ),
    );
  }

  // This gets the height of the MapActionBlock widget
  // so that the MapBottomSheet initialChildSize can be sized accordingly
  Size _getBlockHeight(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MeasureUtil.measureWidget(
      const ProviderScope(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MapActionBlock(),
        ),
      ),
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
    );
  }
}
