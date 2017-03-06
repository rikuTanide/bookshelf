import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;

class MyStocks {
  Editing editing;
  List<Stock> stocks;
  TitleSuggestions titleSuggestions;
  AuthorSuggestions authorSuggestions;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MyStocks &&
        this.editing == other.editing &&
        eq(this.stocks, other.stocks) &&
        this.titleSuggestions == other.titleSuggestions &&
        this.authorSuggestions == other.authorSuggestions;
  }

  @override
  int get hashCode {
    return editing.hashCode ^ stocks.hashCode ^ titleSuggestions
        .hashCode ^ authorSuggestions.hashCode;
  }
}

class Stock {
  String id, title, author, image;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Stock &&
        this.id == other.id &&
        this.title == other.title &&
        this.author == other.author &&
        this.image == other.image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ author.hashCode ^ image.hashCode;
  }
}

class Editing {
  bool isAdding;
  bool isSaving;
  bool isDeleting;
  String logID;
  String title;
  String author;
  String image;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Editing &&
        this.isAdding == other.isAdding &&
        this.isSaving == other.isSaving &&
        this.isDeleting == other.isDeleting &&
        this.logID == other.logID &&
        this.title == other.title &&
        this.author == other.author &&
        this.image == other.image;
  }

  @override
  int get hashCode {
    return isAdding.hashCode ^ isSaving.hashCode ^ isDeleting.hashCode ^ logID
        .hashCode ^ title.hashCode ^ author.hashCode ^ image.hashCode;
  }
}

class AuthorSuggestions {
  List<AuthorSuggestion> authorSuggestionsResults;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AuthorSuggestions &&
        eq(this.authorSuggestionsResults, other.authorSuggestionsResults);
  }

  @override
  int get hashCode {
    return authorSuggestionsResults.hashCode;
  }
}

class AuthorSuggestion {
  String author;
  String image;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AuthorSuggestion &&
        this.author == other.author &&
        this.image == other.image;
  }

  @override
  int get hashCode {
    return author.hashCode ^ image.hashCode;
  }
}


class TitleSuggestions {
  List<String> titleSuggestionsResult;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is TitleSuggestions &&
        eq(this.titleSuggestionsResult, other.titleSuggestionsResult);
  }

  @override
  int get hashCode {
    return titleSuggestionsResult.hashCode;
  }
}
