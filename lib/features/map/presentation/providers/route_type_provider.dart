import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/features/map/domain/entities/enums/route_type.dart';

part 'generated/route_type_provider.g.dart';

@riverpod
class RouteTypeNotifier extends _$RouteTypeNotifier {
  RouteType build() {
    return RouteType.walk;
  }

  void change(RouteType value) {
    state = value;
  }
}
