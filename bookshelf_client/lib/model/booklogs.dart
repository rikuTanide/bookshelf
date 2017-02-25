class BookLogs {
  DateTime pageMonth;
  DateTime selectMonth;

  String savingBookID;

  String username;
  List<BookLog> booklogs;

}

class BookLog {
  String id, title , author, image, review;
  bool isRead;
  DateTime dateTime;
}