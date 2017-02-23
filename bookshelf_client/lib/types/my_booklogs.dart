library bookshelf_client.types.my_booklogs;

import 'package:bookshelf_client/types/share.dart';

class MyBookLogsProps {
  final HeaderLinkParams headerLinkParams;

  final int year, month;

  final List<YearSelectState> yearSelectStates;
  final List<MonthEnabled> monthEnableds;

  final bool isLoading;

  final List<BookLog> bookLogs;

  MyBookLogsProps(this.headerLinkParams,
      this.year,
      this.month,
      this.yearSelectStates,
      this.monthEnableds,
      this.isLoading,
      this.bookLogs);
}


class AddBookLogState {
  bool isLocking, isVarid;
}

class EditReviewState {
  final String review;
  final bool isVaridURL;

  EditReviewState(this.review, this.isVaridURL);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is EditReviewState &&
        this.review == other.review &&
        this.isVaridURL == other.isVaridURL;
  }

  @override
  int get hashCode {
    return review.hashCode ^ isVaridURL.hashCode;
  }

  @override
  String toString() {
    return 'EditReviewState{review: $review, isVaridURL: $isVaridURL}';
  }

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
  final bool isEditing, isLocking, isVarid, isSaving, isDeleting;

  BookLogState(this.isEditing,
      this.isLocking,
      this.isVarid,
      this.isSaving,
      this.isDeleting);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BookLogState &&
        this.isEditing == other.isEditing &&
        this.isLocking == other.isLocking &&
        this.isVarid == other.isVarid &&
        this.isSaving == other.isSaving &&
        this.isDeleting == other.isDeleting;
  }

  @override
  int get hashCode {
    return isEditing.hashCode ^ isLocking.hashCode ^ isVarid.hashCode ^ isSaving
        .hashCode ^ isDeleting.hashCode;
  }

  @override
  String toString() {
    return 'BookLogState{isEditing: $isEditing, isLocking: $isLocking, isVarid: $isVarid, isSaving: $isSaving, isDeleting: $isDeleting}';
  }
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is BookLog &&
        this.id == other.id &&
        this.bookAttrs == other.bookAttrs &&
        this.titleSuggestions == other.titleSuggestions &&
        this.authorSuggestions == other.authorSuggestions &&
        this.hasReview == other.hasReview &&
        this.editReviewState == other.editReviewState &&
        this.bookLogState == other.bookLogState;
  }

  @override
  int get hashCode {
    return id.hashCode ^ bookAttrs.hashCode ^ titleSuggestions
        .hashCode ^ authorSuggestions.hashCode ^ hasReview
        .hashCode ^ editReviewState.hashCode ^ bookLogState.hashCode;
  }

  @override
  String toString() {
    return 'BookLog{id: $id, bookAttrs: $bookAttrs, titleSuggestions: $titleSuggestions, authorSuggestions: $authorSuggestions, hasReview: $hasReview, editReviewState: $editReviewState, bookLogState: $bookLogState}';
  }
}

class MonthEnabled {
  final int year;
  final int month;
  final bool active;

  MonthEnabled(this.year,
      this.month,
      this.active);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MonthEnabled &&
        this.year == other.year &&
        this.month == other.month &&
        this.active == other.active;
  }

  @override
  int get hashCode {
    return year.hashCode ^ month.hashCode ^ active.hashCode;
  }
}