import 'dart:async';

import 'package:angular2/core.dart';


abstract class PersistenceService {

  List<Book> get books;

  void addBook(Book book);

  void setBook(Book book);
}

abstract class AuthService {


  bool get loading;

  bool get login;

  bool get register;

  bool get edit;

  String get uid;

  String get userID;

  void doTwitterLogin();

  void doFacebookLogin();

  void doGoogleLogin();

  void doPasswordLogin(String mailAddr, String password);

  void viewPasswordRegisterPage();

  void doPasswordRegister(String mailAddr, String password);

}

@Injectable()
class MockPersistenceService implements PersistenceService {

  @override
  List<Book> books = [];

  void setBookList(List<Book> books) {
    this.books = books;
  }

  @override
  void addBook(Book book) {
    books.add(book);
  }

  @override
  void setBook(Book book) {
    // TODO: implement setBook
  }
}

@Injectable()
class MockAuthService implements AuthService {

  bool loading = false;

//  bool loading = true;

//  bool login = false;
  bool login = true;

  bool register = false;

//  bool register = true;

  bool edit = false;

//  bool edit = true;


  @override
  String get uid => null;

  @override
  String get userID => null;

  @override
  void doFacebookLogin() {
    loading = false;
    login = false;
    edit = true;
  }

  @override
  void doGoogleLogin() {
    loading = false;
    login = false;
    edit = true;
  }

  @override
  void doTwitterLogin() {
    loading = false;
    login = false;
    edit = true;
  }


  @override
  void doPasswordLogin(String mailAddr, String password) {
    print([mailAddr, password]);
  }

  @override
  void viewPasswordRegisterPage() {
    loading = false;
    login = false;
    register = true;
  }

  @override
  void doPasswordRegister(String mailAddr, String password) {
    print([mailAddr, password]);
  }
}

class Book {
  String id;
  String title;
  String author;
  DateTime datetime;
}