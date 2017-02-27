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


  String toString() {
    return 'Stock{id: $id, bookAttrs: $bookAttrs, iRecommend: $iRecommend, isSaving: $isSaving}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Stock &&
        this.id == other.id &&
        this.bookAttrs == other.bookAttrs &&
        this.iRecommend == other.iRecommend &&
        this.isSaving == other.isSaving;
  }

  @override
  int get hashCode {
    return id.hashCode ^ bookAttrs.hashCode ^ iRecommend.hashCode ^ isSaving
        .hashCode;
  }
}