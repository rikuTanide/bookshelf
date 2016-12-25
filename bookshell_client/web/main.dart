import "dart:core";

import 'package:angular2/platform/browser.dart';
import "package:angular2/core.dart";
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:bookshell_client/app_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:angular2_components/angular2_components.dart';

main() async {
  var mockAuthService = new MockAuthService();
  var persistenceService = new Provider(
      PersistenceService, useClass: MockPersistenceService);
  var authService = new Provider(AuthService, useValue: mockAuthService);
  ComponentRef ref = await bootstrap(
      AppComponent, [persistenceService, materialProviders, authService]);

  mockAuthService.load = true;

}
