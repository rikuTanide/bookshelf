import 'dart:async';
import "dart:core";

import 'package:angular2/platform/browser.dart';
import "package:angular2/core.dart";
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:angular2/src/compiler/view_compiler/property_binder.dart';
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:bookshell_client/app_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'dart:html';

main() async {
  firebase.initializeApp(
      apiKey: "AIzaSyAGnFmjFnXxVfPM1IIJpx3ecEZR5dk6mWs",
      authDomain: "bookshell-isyumi.firebaseapp.com",
      databaseURL: "https://bookshell-isyumi.firebaseio.com",
      storageBucket: "bookshell-isyumi.appspot.com"
  );

  window.history.replaceState("", "", "2017/1");


//  var mockAuthService = new MockAuthService();

//  var mockPersistenceService = new MockPersistenceService();
  var persistenceService = new Provider(
      PersistenceService, useClass: FirebasePersistenceService);
  var authService = new Provider(AuthService, useClass: FirebaseAuthService);
  var autoCompleteService = new Provider(
      AutoComplete, useClass: ServerAutoComplete);
  ComponentRef ref = await bootstrap(
      AppComponent,
      [
        ROUTER_PROVIDERS,
        persistenceService,
        materialProviders,
        authService,
        autoCompleteService,
        new Provider(APP_BASE_HREF,
            useValue: '/bookshelf/bookshell_client/web/mypage/index.html'),
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
