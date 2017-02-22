class MyBookLogs {

  DateTime pageMonth;
  DateTime selectMonth;

  Editing editing;

  TitleSuggestions titleSuggestions;
  AuthorSuggestions authorSuggestions;

  List<BookLog>bookLogs;

}

class Editing {
  bool isAdding;
  bool isSaving;
  bool isDeleting;
  String logID;
  String title;
  String author;
  String image;
  String review;
}

class AuthorSuggestions {
  List<AuthorSuggestion> authorSuggestionsResults;
}

class AuthorSuggestion {
  String author;
  String image;
}

class BookLog {
  String id;
  String title;
  String author;
  String image;
  String review;
}

class TitleSuggestions {
  List<String> titleSuggestionsResult;
}
