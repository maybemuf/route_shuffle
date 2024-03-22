import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:route_shuffle/features/map/presentation/providers/notifiers/place_notifier/places_notifier.dart';

class PlacePredictionsList extends ConsumerWidget {
  const PlacePredictionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(placesNotifierProvider.notifier);
    final places = ref.watch(
      placesNotifierProvider.select((state) => state.places),
    );

    if (places.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 30),
        child: const Text(
          'No places. Start typing to search!',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return ListTile(
          title: Text(place.description),
          onTap: () async => notifier.setStartingLocation(
            place.placeId,
            onError: (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(failure.message),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
