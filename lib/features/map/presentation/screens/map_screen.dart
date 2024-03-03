import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_bottom_sheet.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_top_bar.dart';

double percentageToRational(double percentage, double minimum, double maximum) {
  return minimum + (percentage / 100) * (maximum - minimum);
}

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = useMemoized(Completer<GoogleMapController>.new);
    final dragController = useMemoized(DraggableScrollableController.new);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 1,
                  ),
                  onMapCreated: mapController.complete,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * .3),
            ],
          ),
          MapBottomSheet(dragController: dragController),
          MapTopBar(dragController: dragController),
        ],
      ),
    );
  }
}
