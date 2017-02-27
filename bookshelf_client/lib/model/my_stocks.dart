class MyStocks {
  Editing editing;
  List<Stock> stocks;
  TitleSuggestions titleSuggestions;
  AuthorSuggestions authorSuggestions;
}

class Stock {
  String id,title,author,image;
}

class Editing {
  bool isAdding;
  bool isSaving;
  bool isDeleting;
  String logID;
  String title;
  String author;
  String image;
}

class AuthorSuggestions {
  List<AuthorSuggestion> authorSuggestionsResults;
}

class AuthorSuggestion {
  String author;
  String image;
}


class TitleSuggestions {
  List<String> titleSuggestionsResult;
}
