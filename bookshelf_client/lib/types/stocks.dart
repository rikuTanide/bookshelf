library bookshelf_client.types.stocks;

import 'package:bookshelf_client/types/share.dart';

class StocksProps {
  final HeaderLinkParams headerLinkParams;

  final List<Stock> stocks;
  final bool isLoading;

  StocksProps(this.headerLinkParams, this.stocks, this.isLoading);

}

class Stock {
  final String id;
  final BookAttrs bookAttrs;

  final bool iRecommend, isSaving;

  Stock(this.id, this.bookAttrs, this.iRecommend, this.isSaving);
}