import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/bottom_navigation_bar_index_provider.g.dart';

@riverpod
class BottomNavigationBarIndex extends _$BottomNavigationBarIndex {
  @override
  int build() => 0;

  void update(int index) => state = index;
}
