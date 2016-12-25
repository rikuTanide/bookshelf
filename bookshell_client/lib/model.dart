import 'dart:async';

import 'package:angular2/core.dart';


abstract class PersistenceService {

  Stream<List<Book>> get books;

  void addBook(Book book);

  void setBook(Book book);
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

  StreamController<List<Book>> _books = new StreamController();

  @override
  Stream<List<Book>> get books => _books.stream;

  void setBookList(List<Book> books) {
    _books.add(books);
  }

  @override
  void addBook(Book book) {
    // TODO: implement addBook
  }

  @override
  void setBook(Book book) {
    // TODO: implement setBook
  }
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
  String id;
  String title;
  String author;
  DateTime datetime;
}