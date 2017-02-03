import 'dart:async';

import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:http/browser_client.dart' as http;
import 'dart:math';
import 'dart:html';
import 'package:cookie/cookie.dart' as cookie;

abstract class PersistenceService {

  List<Book> get books;

  void addBook(Book book);

  void setBook(Book book);

  void onLogin(String uid);

  bool isEnableUserName(String userName);

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

  void doPasswordRegister(String mailAddr, String password);

  void logout();


  void setUserID();
}

@Injectable()
class FirebaseAuthService implements AuthService {

  final firebase.Auth fbAuth;

  final PersistenceService store;

  FirebaseAuthService(this.store) :fbAuth = firebase.auth() {
//    firebase.auth().signOut().then((_) {
    fbAuth
      ..onAuthStateChanged
          .listen(onUserChange);
//    });
  }

  @override
  void doFacebookLogin() {
    fbAuth.signInWithRedirect(new firebase.FacebookAuthProvider());
  }

  @override
  void doGoogleLogin() {
    fbAuth.signInWithRedirect(new firebase.GoogleAuthProvider());
  }

  @override
  void doPasswordLogin(String mailAddr, String password) {
    fbAuth.signInWithEmailAndPassword(mailAddr, password);
  }

  @override
  void doPasswordRegister(String mailAddr, String password) {
    fbAuth.createUserWithEmailAndPassword(mailAddr, password);
  }

  @override
  void doTwitterLogin() {
    fbAuth.signInWithRedirect(new firebase.TwitterAuthProvider());
  }


  @override
  bool loading = true;

  @override
  bool login = false;

  @override
  bool register = false;

  @override
  bool edit = false;

  @override
  String uid = null;

  @override
  String userID = "";


  void onUserChange(firebase.AuthEvent event) {
    if (event.user == null) {
      loading = false;
      login = true;
      edit = false;
    } else {
      loading = false;
      login = false;
      uid = event.user.uid;
      loading = false;
      edit = true;
      store.onLogin(uid);
      fetchUserID();
    }
  }

  Future fetchUserID() async {
    var e = await firebase.database().ref("/Users/$uid/id").once("value");
    userID = e.snapshot.val();
  }

  @override
  void logout() {
    fbAuth.signOut();
  }

  @override
  void setUserID() {
    var ref = firebase.database().ref("/Users/$uid/id").set(userID);
    firebase.database().ref("/UserNames/$userID").set(uid);
  }
}

@Injectable()
class FirebasePersistenceService implements PersistenceService {

  final firebase.Database db;
  String uid;
  Map<String, String> usersNames = {};
  Map<String, String> namesUsers = {};

  FirebasePersistenceService() :db = firebase.database();

  @override
  void addBook(Book book) {
    book = _trim(book);
    db.ref("/Books/$uid/").push({
      "author" : book.author,
      "title" : book.title,
      "datetime" : book.datetime.toString(),
      "review" : book.review,
    });
  }

  List<Book> _books = [];

  List<Book> get books => _books;

  @override
  void setBook(Book book) {
    book = _trim(book);
    db.ref("/Books/$uid/${book.id}").set({
      "author" : book.author,
      "title" : book.title,
      "datetime" : book.datetime.toString(),
      "review" : book.review,
    });
  }

  Book _trim(Book book) {
    return new Book()
      ..id = book.id
      ..title = book.title.trim()
      ..author = book.author.trim()
      ..datetime = book.datetime
      ..review = book.review?.trim() == "" ? null : book.review?.trim();
  }

  String _randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(
        length,
        (index) {
      return rand.nextInt(26) + 97;
    }
    );

    return new String.fromCharCodes(codeUnits);
  }

  void setDeviceID() {
    if (!window.localStorage.containsKey("device_id")) {
      var random = _randomString(16);
      window.localStorage["device_id"] = random;
    }
  }

  String getDeviceID() {
    return window.localStorage["device_id"];
  }

  @override
  void onLogin(String uid) {
    setDeviceID();
    var device_id = getDeviceID();
    var random = _randomString(16);
    db.ref("/SessionIDs/$device_id").set({
      "uid" : uid,
      "sessionid" : random,
    });
    cookie.set("sessionid", random);
    this.uid = uid;
    listenBookList(uid).listen(print);
    listenUserNameList(uid).listen(print);
    listenUserList(uid).listen(print);
  }

  Stream listenUserNameList(uid) async* {
    await for (Map<String, Map<String, String>> e in db
        .ref("/Users")
        .onValue
        .map((e) => e.snapshot.val())) {
      this.usersNames = {};
      for (var key in e.keys) {
        this.usersNames[key] = e[key]["id"];
      }
    }
  }

  Stream listenUserList(uid) async* {
    await for (Map<String, String> e in db
        .ref("/UserNames/")
        .onValue
        .map((e) => e.snapshot.val())) {
      this.namesUsers = {};
      for (var key in e.keys) {
        this.namesUsers[key] = e[key];
      }
    }
  }


  Stream listenBookList(String uid) async* {
    await for (var e in db
        .ref("/Books/$uid/")
        .onValue) {
      Map<String, Map<String, String>> val = e.snapshot.val();
      if (val == null) {
        continue;
      }
      var list = <Book>[];
      for (var historyID in val.keys) {
        var book_map = val[historyID];
        var title = book_map["title"];
        var author = book_map["author"];
        var date = DateTime.parse(book_map["datetime"]);
        var review = book_map["review"];
        var book = new Book()
          ..id = historyID
          ..title = title
          ..author = author
          ..datetime = date
          ..review = review;
        list.add(book);
      }
      list.sort((a, b) => b.datetime.compareTo(a.datetime));
      this._books = list;
    }
  }


  @override
  bool isEnableUserName(String userName) {
    if (!namesUsers.containsKey(userName)) {
      return true;
    }
    if (namesUsers[userName] == uid) {
      return true;
    }
    if(usersNames[namesUsers[userName]] != userName){
      return true;
    }
    return false;
  }

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
  void doPasswordRegister(String mailAddr, String password) {
    print([mailAddr, password]);
  }
}

class Book {
  String id;
  String title;
  String author;
  DateTime datetime;
  String review;
}

class Candidate {
  String title;
  String author;
}

abstract class AutoComplete {
  Future<List<Candidate>> autoComplete(String keywords);
}

@Injectable()
class ServerAutoComplete implements AutoComplete {
  @override
  Future<List<Candidate>> autoComplete(String keyword) async {
    var res = await new http.BrowserClient().get(
        "/search/" + Uri.encodeComponent(keyword));
    return parseList(res.body).toList();
  }

  Iterable<Candidate> parseList(String body) sync* {
    var json = JSON.decode(body);
    for (var item in json) {
      yield new Candidate()
        ..author = item["author"]
        ..title = item["title"];
    }
  }

}