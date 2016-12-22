import "package:stream/stream.dart";
import 'package:firebase_dart/firebase_dart.dart';
import 'dart:convert';
import 'dart:io';

class User {
  final String uid;
  final String userID;
  final String name;

  final HtmlEscape sanitizer = new HtmlEscape();

  User(this.uid, this.userID, this.name);

  String getEscapedName() => name != null ? sanitizer.convert(name) : null;
}

class Book {
  final String title;
  final String author;
  final DateTime datetime;

  final HtmlEscape sanitizer = new HtmlEscape();

  Book(this.title, this.author, this.datetime);

  String getEscapedTitle() => sanitizer.convert(title);

  String getEscapedAuthor() => sanitizer.convert(author);

  String getFormattedDateTime() => "${datetime.year}/${datetime.month}";
}

abstract class DataBase {
  List<User> getUsers();

  User getUser(String userID);

  List<Book> getBooks(String uid);
}

class MockDataBase implements DataBase {
  @override
  List<Book> getBooks(String UserID) =>
      [
        new Book("本１", "著者１", new DateTime.now()),
        new Book("本２", "著者２", new DateTime.now()),
        new Book("本３", "著者３", new DateTime.now()),
        new Book("本４", "著者４", new DateTime.now()),
      ];


  @override
  User getUser(String userID) =>
      getUsers().firstWhere((u) => u.userID == userID, orElse: () => null);


  @override
  List<User> getUsers() => [
    new User("1111", "user1", "ユーザー１"),
    new User("2222", "user2", "ユーザー２"),
    new User("3333", "user3", "ユーザー３"),
    new User("4444", "user4", "ユーザー４"),
  ];
}

class Handler {
  final DataBase dataBase;

  Handler(this.dataBase);

  void top(HttpConnect connect) {
    connect.response.headers.contentType = ContentType.HTML;
    connect.response.writeln(
        "<html><title>bookshell</title><body><h1>bookshell</h1><ul>");
    for (var user in dataBase.getUsers()) {
      var pagePath = "/user/" + user.userID;
      var userName = user.getEscapedName();
      connect.response.writeln(
          "<li><a href=\"$pagePath\">$userName</a></li>");
    }
    connect.response.writeln("</ul></body></html>");
    connect.response.close();
  }


  void user(HttpConnect connect) {
    var userID = connect.request.uri.pathSegments[1];
    var user = dataBase.getUser(userID);
    var uid = user.uid;
    var userName = user.getEscapedName();
    var bookList = dataBase.getBooks(uid);
    var res = connect.response;
    printBookList(userName, bookList, res);
  }

  void printBookList(String userName, List<Book> bookList, HttpResponse res) {
    res.headers.contentType = ContentType.HTML;
    res.writeln(
        "<html><title>$userName bookshell</title><body><h1>$userName bookshell</h1><ul>");
    for (var book in bookList) {
      var title = book.getEscapedTitle();
      var author = book.getEscapedAuthor();
      var date = book.getFormattedDateTime();
      res.writeln(
          "<li>$title $author $date</li>");
    }
    res.writeln("</body></html>");
    res.close();
  }

  void health(HttpConnect connect) {
    var res = connect.response;
    res.statusCode = HttpStatus.OK;
    res.close();
  }
}

class FirebaseDatabase implements DataBase {

  Map<String, List<Book>> _bookMap = {};
  List<User> _users = [];

  FirebaseDatabase() {
    _listen();
  }

  _listen() async {
    var uid = "author";
    var authData = {
      "uid": uid,
      "debug": true,
      "provider": "custom"
    };
    var codec = new FirebaseTokenCodec(
        new File("secret/secretkey").readAsStringSync());
    var token = codec.encode(new FirebaseToken(authData, admin: true));

    var ref = new Firebase("https://bookshell-isyumi.firebaseio.com/");
    var auth = await ref.authWithCustomToken(token);
    _listenBooks(ref);
    _listenUsers(ref);
  }

  _listenUsers(Firebase ref) async {
    await for (var e in ref
        .child("Users")
        .onValue) {
      Map<String, Map<String, String>> users_map = e.snapshot.val;
      var list = <User>[];
      for (var uid in users_map.keys) {
        var user_map = users_map[uid];
        var user = new User(uid, user_map["id"], user_map["name"]);
        list.add(user);
      }
      _users = list;
    }
  }

  _listenBooks(Firebase ref) async {
    await for (var books in ref
        .child("Books")
        .onValue) {
      Map<String, Map<String, Map<String, String>>> books_map = books.snapshot
          .val;
      var map = <String, List<Book>>{};
      for (var userID in books_map.keys) {
        var list = <Book>[];
        for (var historyID in books_map[userID].keys) {
          var book_map = books_map[userID][historyID];
          var title = book_map["title"];
          var author = book_map["author"];
          var date = DateTime.parse(book_map["datetime"]);
          var book = new Book(title, author, date);
          list.add(book);
        }
        map[userID] = list;
      }
      this._bookMap = map;
    }
  }

  @override
  List<Book> getBooks(String uid) => _bookMap[uid];

  @override
  User getUser(String userID) =>
      _users.firstWhere((u) => u.userID == userID, orElse: () => null);

  @override
  List<User> getUsers() => _users;
}

void main() {
//  var database = new MockDataBase();
  var database = new FirebaseDatabase();
  var handler = new Handler(database);
  new StreamServer(uriMapping: {
    "/": handler.top,
    "/user/.*": handler.user,
    "/.*": handler.health,
  }).start();
}

