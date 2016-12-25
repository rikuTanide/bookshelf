class Model {
  bool loading = true;
  bool login = true;

  String uid;
  String userID;

  List<Book> book;

}

class Book {
  String title;
  String author;
  DateTime datetime;
}