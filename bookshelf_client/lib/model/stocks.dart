import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;


class Stocks {
  List<Stock> stocks;
  String savingStockID;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Stocks &&
        eq(this.stocks, other.stocks) &&
        this.savingStockID == other.savingStockID;
  }

  @override
  int get hashCode {
    return stocks.hashCode ^ savingStockID.hashCode;
  }
}

class Stock {
  String id, title, author, image;
  bool iRecommend;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Stock &&
        this.id == other.id &&
        this.title == other.title &&
        this.author == other.author &&
        this.image == other.image &&
        this.iRecommend == other.iRecommend;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ author.hashCode ^ image
        .hashCode ^ iRecommend.hashCode;
  }

}