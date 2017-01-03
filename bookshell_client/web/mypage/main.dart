import 'dart:async';
import "dart:core";

import 'package:angular2/platform/browser.dart';
import "package:angular2/core.dart";
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:bookshell_client/app_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:firebase/firebase.dart' as firebase;

main() async {
  firebase.initializeApp(
      apiKey: "AIzaSyAGnFmjFnXxVfPM1IIJpx3ecEZR5dk6mWs",
      authDomain: "bookshell-isyumi.firebaseapp.com",
      databaseURL: "https://bookshell-isyumi.firebaseio.com",
      storageBucket: "bookshell-isyumi.appspot.com"
  );
//  var mockAuthService = new MockAuthService();

//  var mockPersistenceService = new MockPersistenceService();
  var persistenceService = new Provider(
      PersistenceService, useClass: FirebasePersistenceService);
  var authService = new Provider(AuthService, useClass: FirebaseAuthService);
  var autoCompleteService = new Provider(
      AutoComplete, useClass: ServerAutoComplete);
  ComponentRef ref = await bootstrap(
      AppComponent,
      [persistenceService, materialProviders, authService, autoCompleteService
      ]);

//  mockAuthService.loading = false;
//  mockAuthService.login = true;

//  mockPersistenceService.setBookList([
//    new Book()
//      ..title = "タイトル１"
//      ..author = "著者１"
//      ..datetime = new DateTime.now(),
//    new Book()
//      ..title = "タイトル２"
//      ..author = "著者２"
//      ..datetime = new DateTime.now(),
//    new Book()
//      ..title = "タイトル３"
//      ..author = "著者３"
//      ..datetime = new DateTime.now(),
//
//  ]);
}
