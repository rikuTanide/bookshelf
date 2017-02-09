import 'dart:async';
import 'itemsearch.dart';
import 'package:bookshelf_server/book.dart';
import 'package:bookshelf_server/book_anchor.dart';
import 'package:bookshelf_server/index.rsp.dart';
import 'package:bookshelf_server/list-page.rsp.dart';
import 'package:bookshelf_server/login-user-list-page.rsp.dart';
import 'package:bookshelf_server/my-book-list-page.rsp.dart';
import 'package:bookshelf_server/read.dart';
import 'package:bookshelf_server/review_request.dart';
import 'package:bookshelf_server/stack-list-page.rsp.dart';
import 'package:bookshelf_server/user.dart';
import "package:stream/stream.dart";
import 'package:firebase_dart/firebase_dart.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

abstract class DataBase {
  List<User> getUsers();

  User getUser(String userID);

  List<Book> getBooks(String uid);

  bool isLogin(String value);

  List<BookRead> getIsRead(String advocate, String publish,
      List<Book> activeBooks);

  getUID(String value);

  getPublish(id);

  void putRead(visitorUid, String publish, id);

  List<String> getReads(String advocate, String publish, String id);

  Future delRead(String id);

  Future putReviewRequest(String visitorUid, String publish, String id);

  List<String> getReviewRequests(String wanted, String publish, String id);

  Future delReviewRequest(String id);

  List<Book> getStacks(String uid);
}

class CookieReader {

  bool isLogin(List<Cookie> cookies, DataBase dataBase) {
    var cookie = cookies
        .firstWhere((c) => c.name == "sessionid", orElse: () => null);
    if (cookie == null) {
      return false;
    }
    return dataBase.isLogin(cookie.value);
  }


  getUID(List<Cookie> cookies, DataBase dataBase) {
    var cookie = cookies
        .firstWhere((c) => c.name == "sessionid", orElse: () => null);
    if (cookie == null) {
      return false;
    }
    return dataBase.getUID(cookie.value);
  }
}

class Handler {

  final DataBase dataBase;
  final AmazonAPI amazon = new AmazonAPI();
  final GoogleAPI google = new GoogleAPI();
  final BookAnchor anchor = new BookAnchor();
  final CookieReader cookieReader = new CookieReader();

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
    var trackingID = user.trackingID;
    var res = connect.response;
    var years = anchor.createBookAnchor(bookList, year, month);
    var activeBooks = bookList
        .where((b) => b.datetime.year == year)
        .where((b) => b.datetime.month == month)
        .toList()
      ..sort((b1, b2) => b1.title.compareTo(b2.title));

    if (cookieReader.isLogin(connect.request.cookies, dataBase)) {
      var visitorUid = cookieReader.getUID(connect.request.cookies, dataBase);

      if (uid == visitorUid) {
        await myBookListPage(connect, books: activeBooks,
            escapedUserID: escapedUserID,
            years: years,
            activeYear: year,
            activeMonth: month);
        res.close();
        return;
      }

      var readList = dataBase.getIsRead(visitorUid, uid, activeBooks);
      await loginUserListPage(
          connect,
          books: readList,
          escapedUserID: escapedUserID,
          years: years,
          activeYear: year,
          activeMonth: month);
      res.close();
      return;
    }

    await listPage(
        connect, books: activeBooks,
        escapedUserID: escapedUserID,
        years: years,
        activeYear: year,
        activeMonth: month,
        trackingID: trackingID);
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
    <script async src="/mypage/angular/main.dart" type="application/dart"></script>
    <script async src="/mypage/angular/packages/browser/dart.js"></script>
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
    var result = await google.search(keyword);
    var json = JSON.encode(result);
    var res = connect.response;
    res
      ..statusCode = HttpStatus.OK
      ..headers.contentType = ContentType.JSON
      ..write(json)
      ..close();
  }

  author(HttpConnect connect) async {
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

  read(HttpConnect connect) async {
    var id = connect.dataset["id"];
    if (cookieReader.isLogin(connect.request.cookies, dataBase)) {
      var visitorUid = cookieReader.getUID(connect.request.cookies, dataBase);
      var publish = dataBase.getPublish(id);
      await dataBase.putRead(visitorUid, publish, id);
    }
    connect.response.close();
  }

  unread(HttpConnect connect) async {
    var id = connect.dataset["id"];
    if (cookieReader.isLogin(connect.request.cookies, dataBase)) {
      var visitorUid = cookieReader.getUID(connect.request.cookies, dataBase);
      var publish = dataBase.getPublish(id);
      var reads = dataBase.getReads(visitorUid, publish, id);
      for (var r in reads) {
        await dataBase.delRead(r);
      }
    }
    connect.response.close();
  }

  reviewRequest(HttpConnect connect) async {
    var id = connect.dataset["id"];
    if (cookieReader.isLogin(connect.request.cookies, dataBase)) {
      var visitorUid = cookieReader.getUID(connect.request.cookies, dataBase);
      var publish = dataBase.getPublish(id);
      await dataBase.putReviewRequest(visitorUid, publish, id);
    }
    connect.response.close();
  }

  unReviewRequest(HttpConnect connect) async {
    var id = connect.dataset["id"];
    if (cookieReader.isLogin(connect.request.cookies, dataBase)) {
      var visitorUid = cookieReader.getUID(connect.request.cookies, dataBase);
      var publish = dataBase.getPublish(id);
      var reviewRequest = dataBase.getReviewRequests(visitorUid, publish, id);
      for (var r in reviewRequest) {
        await dataBase.delReviewRequest(r);
        connect.response.close();
      }
    }
  }

  stack(HttpConnect connect) async {
    var userID = connect.dataset["user"];
    var user = dataBase.getUser(userID);
    var uid = user.uid;
    var bookList = dataBase.getStacks(uid);
    var escapedUserID = user.getEscapedID();

    await stackListPage(connect, books: bookList, escapedUserID: escapedUserID);
    connect.response.close();
  }


}

class GoogleAPI {
  Future<List<String>> search(String str) async {
    var uri = new Uri.https('www.google.com', '/complete/search', {
      "hl":"en",
      "q" : str,
      "output" : "toolbar"
    });
    var res = await http.get(
        uri, headers: {"Content-Type": "text/xml; charset=UTF-8"});
    return _response(res.body).toList();
  }

  Iterable<String> _response(String res) sync* {
    var resXml = xml.parse(res);
    var items = resXml.findAllElements("suggestion");
    for (var e in items) {
      try {
        yield e.getAttribute('data');
      } catch (e) {

      }
    }
  }

}

class FirebaseDatabase implements DataBase {

  Map<String, List<Book>> _bookMap = {};
  List<User> _users = [];
  Map<String, List<Book>> _stacks = {};
  Map<String, String> _sessionIDs = {};
  List<Read> read = [];
  List<ReviewRequest> reviewRequests = [];
  Firebase ref;

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

    ref = new Firebase("https://bookshell-isyumi.firebaseio.com/");
    var auth = await ref.authWithCustomToken(token);
    _listenBooks(ref);
    _listenUsers(ref);
    _listenSessionID(ref);
    _listenRead(ref);
    _listenReviewRequest(ref);
    _listenStack(ref);
  }

  _listenStack(Firebase ref) async {
    await for (Map<String, Map<String, Map<String, String>>> e in ref
        .child("/Stack")
        .onValue
        .map((r) => r.snapshot.val)) {
      if (e == null) {
        continue;
      }

      _stacks = {};

      for (var userID in e.keys) {
        var l = [];
        for (var stackID in e[userID].keys) {
          var author = e[userID][stackID]["author"];
          var title = e[userID][stackID]["title"];
          var asin = e[userID][stackID]['asin'];
          var image = e[userID][stackID]['image'];
          var book = new Book(
              stackID,
              title,
              author,
              new DateTime.now(),
              null,
              image,
              asin);
          l.add(book);
        }
        _stacks[userID] = l;
      }
    }
  }

  _listenReviewRequest(Firebase ref) async {
    await for (Map<String, Map<String, String>> e in ref
        .child("/ReviewRequest")
        .onValue
        .map((r) => r.snapshot.val)) {
      if (e == null) {
        reviewRequests = [];
        continue;
      }
      reviewRequests = [];
      for (var id in e.keys) {
        var publish = e[id]["Publish"];
        var wanted = e[id]["Wanted"];
        var book = e[id]["Book"];
        reviewRequests.add(new ReviewRequest(id, publish, wanted, book));
      }
    }
  }

  _listenRead(Firebase ref) async {
    await for (Map<String, Map<String, String>> e in ref
        .child("/Read")
        .onValue
        .map((r) => r.snapshot.val)) {
      if (e == null) {
        read = [];
        continue;
      }
      read = [];
      for (var id in e.keys) {
        read.add(new Read()
          ..id = id
          ..book = e[id]["Book"]
          ..advocate = e[id]["Advocate"]
          ..publish = e[id]["Publish"]);
      }
    }
  }

  _listenUsers(Firebase ref) async {
    await for (var e in ref
        .child("Users")
        .onValue) {
      Map<String, Map<String, String>> users_map = e.snapshot.val;
      var list = <User>[];
      for (var uid in users_map.keys) {
        var user_map = users_map[uid];
        var user = new User(uid, user_map["id"] , user_map["trackingID"]);
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
          var review = book_map["review"];
          var image = book_map["image"];
          var asin = book_map['asin'];
          var book = new Book(
              historyID,
              title,
              author,
              date,
              review,
              image,
              asin);
          list.add(book);
        }
        map[userID] = list;
      }
      this._bookMap = map;
    }
  }

  _listenSessionID(Firebase ref) async {
    await for (var map in(ref
        .child("/SessionIDs")
        .onValue
        .map((e) => e.snapshot.val)
        .map((Map<String, Map<String, String>> map) => map.values))) {
      _sessionIDs = {};
      for (var m in map) {
        _sessionIDs[m["sessionid"]] = m["uid"];
      }
    }
  }

  @override
  List<Book> getBooks(String uid) => _bookMap[uid];

  @override
  User getUser(String userID) =>
      _users.firstWhere((u) => u.userID == userID, orElse: () => null);

  @override
  List<User> getUsers() => _users;


  @override
  bool isLogin(String value) {
    return _sessionIDs.containsKey(value);
  }

  @override
  Iterable<BookRead> getIsRead(String advocate, String publish,
      List<Book> activeBooks) {
    var read = this
        .read
        .where((r) => r.publish == publish)
        .where((r) => r.advocate == advocate);
    var reviewRequests = this
        .reviewRequests
        .where((r) => r.publish == publish)
        .where((r) => r.wanted == advocate);

    return activeBooks
        .map((b) => new BookRead(b, read.any((r) => r.book == b.id),
        reviewRequests.any((r) => r.bookID == b.id)))
        .toList();
  }

  @override
  getUID(String value) {
    return _sessionIDs[value];
  }

  @override
  getPublish(id) {
    for (var userID in _bookMap.keys) {
      for (var book in _bookMap[userID]) {
        if (book.id == id) {
          return userID;
        }
      }
    }
  }

  @override
  Future putRead(String visitorUid, String publish, String id) {
    return ref.child("/Read/").push({
      "Advocate" : visitorUid,
      "Book" : id,
      "Publish": publish,
    });
  }

  @override
  List<String> getReads(String advocate, String publish, String id) {
    return read.where((r) => r.advocate == advocate)
        .where((r) => r.publish == publish)
        .where((r) => r.book == id)
        .map((r) => r.id)
        .toList();
  }

  @override
  Future delRead(String id) async {
    await ref.child("/Read/$id").remove();
  }

  @override
  Future putReviewRequest(String visitorUid, String publish, String id) {
    return ref.child("/ReviewRequest").push({
      "Book" : id,
      "Publish" : publish,
      "Wanted" : visitorUid
    });
  }

  @override
  List<String> getReviewRequests(String wanted, String publish, String id) {
    return reviewRequests
        .where((r) => r.wanted == wanted)
        .where((r) => r.publish == publish)
        .where((r) => r.bookID == id)
        .map((r) => r.id)
        .toList();
  }

  @override
  Future delReviewRequest(String id) async {
    await ref.child("/ReviewRequest/$id").remove();
  }

  @override
  List<Book> getStacks(String uid) {
    return _stacks[uid];
  }
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
    "/mypage/(year:[^/]*)/(month:[^/]*)":handler.mypage,
    "/search/.*":handler.search,
    "/author/.*" :handler.author,
    "/api/read/(id:[^/]*)": handler.read,
    "/api/unread/(id:[^/]*)": handler.unread,
    "/api/reviewRequest/(id:[^/]*)" : handler.reviewRequest,
    "/api/unReviewRequest/(id:[^/]*)" : handler.unReviewRequest,
    "/stack/(user:[^/]*)" : handler.stack,

  }).start();
}