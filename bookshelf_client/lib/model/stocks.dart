import 'package:bookshelf_client/types/share.dart';

class Stocks {
  List<Stock> stocks;
  String savingStockID;
}

class Stock {
  String id, title, author, image;
  bool iRecommend;

}