import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_shuffle/core/providers/bottom_navigation_bar_index_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(bottomNavigationBarIndexProvider),
        children: const [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
          ),
          Center(
            child: Text('Profile'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(bottomNavigationBarIndexProvider),
        onTap: ref.read(bottomNavigationBarIndexProvider.notifier).update,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
