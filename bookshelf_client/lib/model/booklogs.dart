import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;

class BookLogs {
  DateTime pageMonth;
  DateTime selectMonth;

  String savingBookID;

  String username;
  List<BookLog> booklogs;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BookLogs &&
        this.pageMonth == other.pageMonth &&
        this.selectMonth == other.selectMonth &&
        this.savingBookID == other.savingBookID &&
        this.username == other.username &&
        eq(this.booklogs, other.booklogs);
  }

  @override
  int get hashCode {
    return pageMonth.hashCode ^ selectMonth.hashCode ^ savingBookID
        .hashCode ^ username.hashCode ^ booklogs.hashCode;
  }

}

class BookLog {
  String id, title, author, image, review;
  bool isRead;
  DateTime dateTime;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BookLog &&
        this.id == other.id &&
        this.title == other.title &&
        this.author == other.author &&
        this.image == other.image &&
        this.review == other.review &&
        this.isRead == other.isRead &&
        this.dateTime == other.dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ author.hashCode ^ image
        .hashCode ^ review.hashCode ^ isRead.hashCode ^ dateTime.hashCode;
  }
}