import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;

class MyBookLogs {

  DateTime pageMonth;
  DateTime selectMonth;

  Editing editing;

  TitleSuggestions titleSuggestions;
  AuthorSuggestions authorSuggestions;

  List<BookLog>bookLogs;

  @override
  String toString() {
    return 'MyBookLogs{pageMonth: $pageMonth, selectMonth: $selectMonth, editing: $editing, titleSuggestions: $titleSuggestions, authorSuggestions: $authorSuggestions, bookLogs: $bookLogs}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MyBookLogs &&
        this.pageMonth == other.pageMonth &&
        this.selectMonth == other.selectMonth &&
        this.editing == other.editing &&
        this.titleSuggestions == other.titleSuggestions &&
        this.authorSuggestions == other.authorSuggestions &&
        eq(this.bookLogs , other.bookLogs);
  }

  @override
  int get hashCode {
    return pageMonth.hashCode ^ selectMonth.hashCode ^ editing
        .hashCode ^ titleSuggestions.hashCode ^ authorSuggestions
        .hashCode ^ bookLogs.hashCode;
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
  String review;

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
        this.image == other.image &&
        this.review == other.review;
  }

  @override
  int get hashCode {
    return isAdding.hashCode ^ isSaving.hashCode ^ isDeleting.hashCode ^ logID
        .hashCode ^ title.hashCode ^ author.hashCode ^ image.hashCode ^ review
        .hashCode;
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

class BookLog {
  String id;
  String title;
  String author;
  String image;
  String review;
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
        this.dateTime == other.dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ author.hashCode ^ image
        .hashCode ^ review.hashCode ^ dateTime.hashCode;
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
