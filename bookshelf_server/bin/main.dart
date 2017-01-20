import 'dart:async';
import 'itemsearch.dart';
import 'package:bookshelf_server/book.dart';
import 'package:bookshelf_server/book_anchor.dart';
import 'package:bookshelf_server/index.rsp.dart';
import 'package:bookshelf_server/list-page.rsp.dart';
import 'package:bookshelf_server/user.dart';
import "package:stream/stream.dart";
import 'package:firebase_dart/firebase_dart.dart';
import 'dart:convert';
import 'dart:io';


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
    new User("user1", "ユーザー１"),
    new User("user2", "ユーザー２"),
    new User("user3", "ユーザー３"),
    new User("user4", "ユーザー４"),
  ];
}

class Handler {

  final DataBase dataBase;
  final AmazonAPI amazon = new AmazonAPI();
  final BookAnchor anchor = new BookAnchor();

  Handler(this.dataBase);

  Future top(HttpConnect connect) async {
    var users = dataBase.getUsers();
    await index(connect, users: users);
    connect.response.close();
  }


  Future user(HttpConnect connect) async {
    var userID = connect.dataset["user"];
    var year = int.parse(connect.dataset["year"]);
    var month = int.parse(connect.dataset["month"]);

    var user = dataBase.getUser(userID);
    var uid = user.uid;
    var bookList = dataBase.getBooks(uid);
    var escapedUserID = user.getEscapedID();
    var res = connect.response;
    var years = anchor.createBookAnchor(bookList, year, month);
    var activeBooks = bookList
        .where((b) => b.datetime.year == year)
        .where((b) => b.datetime.month == month)
        .toList()
      ..sort((b1, b2) => b1.title.compareTo(b2.title));
    await listPage(
        connect, books: activeBooks,
        escapedUserID: escapedUserID,
        years: years,
        activeYear: year,
        activeMonth: month);
    res.close();
  }

  Future userRedirect(HttpConnect connect) async {
    var userID = connect.request.uri.pathSegments[1];
    var user = dataBase.getUser(userID);
    var uid = user.uid;
    var bookList = dataBase.getBooks(uid);
    var escapedUserID = user.getEscapedID();
    var res = connect.response;
    var maxYear = anchor.getMaxYear(bookList);
    var maxMonth = anchor.getMaxMonth(bookList, maxYear);
    res.redirect(Uri.parse("/user/$userID/$maxYear/$maxMonth"));
    res.close();
  }


  void health(HttpConnect connect) {
    var res = connect.response;
    res.statusCode = HttpStatus.OK;
    res.write(connect.request.uri.toString());
    res.close();
  }

  void letsencrypt(HttpConnect connect) {
    var challenge = new File("secret/letsencrypt").readAsStringSync().split(
        "\n");
    var segments = connect.request.uri.pathSegments;
    if (segments[2] == challenge[0]) {
      connect
        ..response.write(challenge[1])
        ..response.close();
    }
  }

  void mypage(HttpConnect connect) {
    connect.response
      ..headers.contentType = ContentType.HTML
      ..write("""<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            background: lightgray;
        }

        #my-app {
            background: white;
        }
    </style>
    <title>Angular 2</title>
    <base href="/mypage/">
    <!--<base href="http://localhost:63342/bookshelf/bookshell_client/web/mypage/index.html">-->
    <meta charset="utf-8"/>
    <script src="https://www.gstatic.com/firebasejs/3.6.4/firebase.js"></script>
    <script async src="main.dart" type="application/dart"></script>
    <script async src="packages/browser/dart.js"></script>
    <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-89660523-1', 'auto');
  ga('send', 'pageview');

</script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
</head>
<body>
<my-app id="my-app">Loading...</my-app>

</body>
</html>""")
      ..close();
  }

  search(HttpConnect connect) async {
    var keyword = connect.request.uri.pathSegments[1];
    var result = await amazon.search(keyword);
    var json = JSON.encode(result);
    var res = connect.response;
    res
      ..statusCode = HttpStatus.OK
      ..headers.contentType = ContentType.JSON
      ..write(json)
      ..close();
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
        var user = new User(uid, user_map["id"]);
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
      if (books_map == null) {
        continue;
      }
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
    "/user/(user:[^/]*)/(year:[^/]*)/(month:[^/]*)": handler.user,
    "/user/(user:[^/]*)": handler.userRedirect,
    "/mypage":handler.mypage,
    "/mypage/":handler.mypage,
    "/search/.*":handler.search,
    "/.well-known/acme-challenge/.*":handler.letsencrypt,
    "/.*": handler.health,
  }).start();
}