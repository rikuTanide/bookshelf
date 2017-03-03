import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:test/test.dart';

void main() {
  group("URLのパース", () {
    test("/ならTop", () {
      var reqPar = parseURL([], "user1");
      expect(reqPar, equals(new URLParams(top: new Top())));
    });
    test("/booklogs/user1/2017/1ならmyBookLogs", () {
      var reqPar = parseURL(["booklogs", "user1", "2017", "1"], "user1");
      expect(
          reqPar, equals(new URLParams(myBookLogs: new MyBookLogs(2017, 1))));
    });
    test("/booklogs/user2/2017/1ならbookLogs", () {
      var reqPar = parseURL(["booklogs", "user2", "2017", "1"], "user1");
      expect(reqPar,
          equals(new URLParams(bookLogs: new BookLogs("user2", 2017, 1))));
    });
    test("/stocks/user1ならstocks", () {
      var reqPar = parseURL(["stocks", "user1"], "user1");
      expect(reqPar, equals(new URLParams(myStocks: new MyStocks())));
    });
    test("/stocks/user2", () {
      var reqPar = parseURL(["stocks", "user2"], "user1");
      expect(reqPar, equals(new URLParams(stocks: new Stocks("user2"))));
    });
  });

  group("", () {

  });
}