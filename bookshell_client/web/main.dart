import "dart:core";

import 'package:angular2/platform/browser.dart';
import "package:angular2/core.dart";
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:bookshell_client/app_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:angular2_components/angular2_components.dart';

main() async {
  var mockAuthService = new MockAuthService();
  var mockPersistenceService = new MockPersistenceService();
  var persistenceService = new Provider(
      PersistenceService, useValue: mockPersistenceService);
  var authService = new Provider(AuthService, useValue: mockAuthService);
  ComponentRef ref = await bootstrap(
      AppComponent, [persistenceService, materialProviders, authService]);

  mockAuthService.load = true;
  mockPersistenceService.setBookList([
    new Book()
    ..title = "タイトル１"
    ..author = "著者１"
    ..datetime = new DateTime.now(),
    new Book()
    ..title = "タイトル２"
    ..author = "著者２"
    ..datetime = new DateTime.now(),
    new Book()
    ..title = "タイトル３"
    ..author = "著者３"
    ..datetime = new DateTime.now(),

  ]);
}
