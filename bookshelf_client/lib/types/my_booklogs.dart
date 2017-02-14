library bookshelf_client.types.my_booklogs;

import 'package:bookshelf_client/types/share.dart';

class MyBookLog {
  final String username;
  final int latestYear, latestMonth;

  final List<YearSelectState> yearSelectStates;
  final List<MonthEnabled> monthEnableds;

  final bool isLoading;

  final List<BookLog> bookLogs;

  MyBookLog(this.username, this.latestYear, this.latestMonth, this.yearSelectStates,
      this.monthEnableds, this.isLoading, this.bookLogs);

}


class TitleSuggestions {
  final bool isViewing;
  final bool isLoading;
  final List<String> suggestions;

  TitleSuggestions(this.isViewing, this.isLoading, this.suggestions);
}

class AuthorSuggestions {
  final bool isViewing;
  final bool isLoading;
  final List<AuthorSuggest> authorSuggests;

  AuthorSuggestions(this.isViewing, this.isLoading, this.authorSuggests);
}

class AuthorSuggest {
  final String author, image;

  AuthorSuggest(this.author, this.image);
}

class AddBookLogState {
  bool isLocking, isVarid;
}

class EditReviewState {
  final String review;
  final bool isVaridURL;

  EditReviewState(this.review, this.isVaridURL);

}

class AddBookLog {

  final BookAttrs bookAttrs;
  final TitleSuggestions titleSuggestions;
  final AuthorSuggestions authorSuggestions;


  final EditReviewState editReviewState;

  final AddBookLogState addBookLogState;

  AddBookLog(this.bookAttrs,
      this.titleSuggestions,
      this.authorSuggestions,
      this.editReviewState,
      this.addBookLogState);

}

class BookLogState {
  final bool isEditing , isLocking , isVarid;

  BookLogState(this.isEditing, this.isLocking, this.isVarid);
}


class BookLog {
  final String id;
  final BookAttrs bookAttrs;
  final TitleSuggestions titleSuggestions;
  final AuthorSuggestions authorSuggestions;

  final bool hasReview;
  final EditReviewState editReviewState;

  final BookLogState bookLogState;

  BookLog(this.id,
      this.bookAttrs,
      this.titleSuggestions,
      this.authorSuggestions,
      this.hasReview,
      this.editReviewState,
      this.bookLogState);
}