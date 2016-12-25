import 'dart:async';

import 'package:angular2/core.dart';


abstract class PersistenceService {
  List<Book> get book;

}

abstract class AuthService {
  bool get load;

  bool get login;

  String get uid;

  String get userID;

  void doTwitterLogin();

  void doFacebookLogin();

  void doGoogleLogin();

  void doPasswordLogin();

  void doPasswordRegister();


}

@Injectable()
class MockPersistenceService implements PersistenceService {

  @override
  List<Book> get book => [];

}

@Injectable()
class MockAuthService implements AuthService {

  @override
  bool load = false;

  @override
  bool login = false;

  @override
  String get uid => null;

  @override
  String get userID => null;

  @override
  void doFacebookLogin() {
    login = true;
  }

  @override
  void doGoogleLogin() {
    login = true;
  }

  @override
  void doPasswordLogin() {
    login = true;
  }

  @override
  void doPasswordRegister() {

  }

  @override
  void doTwitterLogin() {
    login = true;
  }
}

class Book {
  String title;
  String author;
  DateTime datetime;
}