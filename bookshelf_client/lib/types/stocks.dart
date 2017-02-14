library bookshelf_client.types.stocks;

import 'package:bookshelf_client/types/share.dart';

class Stocks {
  final HeaderLinkParams headerLinkParams;

  final List<Stock> stocks;

  Stocks(this.headerLinkParams, this.stocks);

}

class Stock {
  final String id;
  final BookAttrs bookAttrs;

  final bool iRecommend, isSaving;

  Stock(this.id, this.bookAttrs, this.iRecommend, this.isSaving);
}