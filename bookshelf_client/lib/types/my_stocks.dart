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

}

class StockState {
  final bool isEditing, isLocking, isVarid, isDeleting;

  StockState(this.isEditing,
      this.isLocking,
      this.isVarid,
      this.isDeleting);
}