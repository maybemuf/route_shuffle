import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:route_shuffle/application.dart';
import 'package:route_shuffle/core/utils/constants_strings.dart';
import 'package:route_shuffle/core/utils/provider_observer.dart';

const _englishLocale = Locale('en', 'US');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      // observers: [ProviderLogger()],
      child: EasyLocalization(
        supportedLocales: const [_englishLocale],
        path: ConstantStrings.translationsPath,
        fallbackLocale: _englishLocale,
        child: const Application(),
      ),
    ),
  );
}
