class MyBookLogs {

  int year;
  int month;

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
  AuthorSuggestionsResults authorSuggestionsResults;
}

class AuthorSuggestionsResults {
  List<AuthorSuggestion> authorSuggestions;
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
  TitleSuggestionsResult titleSuggestionsResult;
}

class TitleSuggestionsResult {
  List<String> titleSuggestions;
}