library bookshelf_client.types.my_booklogs;

import 'package:bookshelf_client/types/share.dart';

class MyBookLogsProps {
  final HeaderLinkParams headerLinkParams;

  final List<YearSelectState> yearSelectStates;
  final List<MonthEnabled> monthEnableds;

  final bool isLoading;

  final List<BookLog> bookLogs;

  MyBookLogsProps(this.headerLinkParams, this.yearSelectStates,
      this.monthEnableds, this.isLoading, this.bookLogs);

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
  final bool isEditing, isLocking, isVarid, isDeleting;

  BookLogState(this.isEditing, this.isLocking, this.isVarid, this.isDeleting);
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