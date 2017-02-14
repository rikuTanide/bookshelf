library bookshelf_client.types.stocks;

import 'package:bookshelf_client/types/share.dart';

class MyStocks {
  final HeaderLinkParams headerLinkParams;
  final Stock stocks;

  MyStocks(this.headerLinkParams, this.stocks);

}

class Stock {
  final BookAttrs bookAttrs;

  final TitleSuggestions titleSuggestions;
  final AuthorSuggestions authorSuggestions;

  Stock(this.bookAttrs, this.titleSuggestions, this.authorSuggestions);
}

class StockState {
  final bool isEditing, isLocking, isVarid, isDeleting;

  StockState(this.isEditing,
      this.isLocking,
      this.isVarid,
      this.isDeleting);
}