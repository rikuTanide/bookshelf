
URLParams parseURL(List<String> path, String username) {
  if (path.length == 0) {
    return new URLParams(top: new Top());
  } else if (path.length == 4 && path[0] == "booklogs" && path[1] == username) {
    var year = int.parse(path[2]);
    var month = int.parse(path[3]);
    return new URLParams(myBookLogs: new MyBookLogs(year, month));
  } else if (path.length == 4 && path[0] == "booklogs" && path[1] != username) {
    var year = int.parse(path[2]);
    var month = int.parse(path[3]);
    return new URLParams(bookLogs: new BookLogs(path[1], year, month));
  } else if (path.length == 2 && path[0] == "stocks" && path[1] == username) {
    return new URLParams(myStocks: new MyStocks());
  } else if (path.length == 2 && path[0] == "stocks" && path[1] != username) {
    return new URLParams(stocks: new Stocks(path[1]));
  }
  throw path;
}

class URLParams {
  Top top;
  MyBookLogs myBookLogs;
  BookLogs bookLogs;
  MyStocks myStocks;
  Stocks stocks;
  Setting setting;

  URLParams({this.top,
  this.myBookLogs,
  this.bookLogs,
  this.myStocks,
  this.stocks,
  this.setting});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is URLParams &&
        this.top == other.top &&
        this.myBookLogs == other.myBookLogs &&
        this.bookLogs == other.bookLogs &&
        this.myStocks == other.myStocks &&
        this.stocks == other.stocks &&
        this.setting == other.setting;
  }

  @override
  int get hashCode {
    return top.hashCode ^ myBookLogs.hashCode ^ bookLogs.hashCode ^ myStocks
        .hashCode ^ stocks.hashCode ^ setting.hashCode;
  }
}

class Top {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Top;
  }

  @override
  int get hashCode {
    return 0;
  }
}

class MyBookLogs {
  final int year, month;

  MyBookLogs(this.year, this.month);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MyBookLogs &&
        this.year == other.year &&
        this.month == other.month;
  }

  @override
  int get hashCode {
    return year.hashCode ^ month.hashCode;
  }
}

class BookLogs {
  final String username;

  final int year, month;

  BookLogs(this.username, this.year, this.month);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BookLogs &&
        this.username == other.username &&
        this.year == other.year &&
        this.month == other.month;
  }

  @override
  int get hashCode {
    return username.hashCode ^ year.hashCode ^ month.hashCode;
  }

}

class MyStocks {

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MyStocks;
  }

  @override
  int get hashCode {
    return 0;
  }
}

class Stocks {
  final String username;

  Stocks(this.username);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Stocks &&
        this.username == other.username;
  }

  @override
  int get hashCode {
    return username.hashCode;
  }

}

class Setting {

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Setting;
  }

  @override
  int get hashCode {
    return 0;
  }
}