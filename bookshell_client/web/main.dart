import "dart:core";

import 'package:angular2/platform/browser.dart';
import "package:angular2/core.dart";
import 'package:angular2/src/core/reflection/reflection.dart';
import "package:angular2/router.dart";
import "package:angular2/src/platform/browser/location/hash_location_strategy.dart";
import "package:angular2/platform/common.dart";
import 'package:bookshell_client/app_component.dart';


bool get isDebug =>
    (const String.fromEnvironment("PRODUCTION", defaultValue: "false")) !=
        "true";

main() async {
  if (isDebug) {
    reflector.trackUsage();
  }
  ComponentRef ref = await bootstrap(AppComponent);

  if (isDebug) {
    print("Application in DebugMode");
    enableDebugTools(ref);
    print('Unused keys: ${reflector.listUnusedKeys()}');
  }
}
