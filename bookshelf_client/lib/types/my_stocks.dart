library bookshelf_client.types.my_stocks;

import 'package:bookshelf_client/types/share.dart';

class MyStocksProps {
  final HeaderLinkParams headerLinkParams;
  final List<Stock> stocks;
  final bool isLoading;

  MyStocksProps(this.headerLinkParams, this.stocks, this.isLoading);

}

class Stock {

  final BookAttrs bookAttrs;

  final TitleSuggestions titleSuggestions;
  final AuthorSuggestions authorSuggestions;

  final bool isEditing;
  final bool isValid;
  final bool isLocking;
  final bool isSaving;
  final bool isDeleting;

  Stock(this.bookAttrs,
      this.titleSuggestions,
      this.authorSuggestions,
      this.isEditing,
      this.isValid,
      this.isLocking,
      this.isSaving,
      this.isDeleting);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Stock &&
        this.bookAttrs == other.bookAttrs &&
        this.titleSuggestions == other.titleSuggestions &&
        this.authorSuggestions == other.authorSuggestions &&
        this.isEditing == other.isEditing &&
        this.isValid == other.isValid &&
        this.isLocking == other.isLocking &&
        this.isSaving == other.isSaving &&
        this.isDeleting == other.isDeleting;
  }

  @override
  int get hashCode {
    return bookAttrs.hashCode ^ titleSuggestions.hashCode ^ authorSuggestions
        .hashCode ^ isEditing.hashCode ^ isValid.hashCode ^ isLocking
        .hashCode ^ isSaving.hashCode ^ isDeleting.hashCode;
  }

  @override
  String toString() {
    return 'Stock{bookAttrs: $bookAttrs, titleSuggestions: $titleSuggestions, authorSuggestions: $authorSuggestions, isEditing: $isEditing, isValid: $isValid, isLocking: $isLocking, isSaving: $isSaving, isDeleting: $isDeleting}';
  }

}

class StockState {
  final bool isEditing, isLocking, isVarid, isDeleting;

  StockState(this.isEditing,
      this.isLocking,
      this.isVarid,
      this.isDeleting);
}