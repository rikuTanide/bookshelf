import 'header_link_params.dart';
import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/stocks.dart';
import 'package:bookshelf_client/types/view_model.dart';

@Injectable()
class StocksPropsMock {

  final HeaderLinkParamsMock headerLinkParamsMock;

  StocksPropsMock(this.headerLinkParamsMock);


  ViewModel getStocksProps(bool isLoading) {
    var header = headerLinkParamsMock.getHeaderLinkParams();
    if (isLoading) {
      return new ViewModel(stocks: new StocksProps(header, [], true));
    } else {
      return new ViewModel(stocks: new StocksProps(header, getStocks(), false));
    }
  }

  List<Stock> getStocks() => [
    getStock(),
    getStock(isSaving: true),
    getStock(iRecommend: true),
    getStock(iRecommend: true,isSaving: true),
  ];

  Stock getStock({bool iRecommend: false, bool isSaving: false}) {
    var attr = new BookAttrs("タイトル１", "著者１", "img.png");
    return new Stock("id1", attr, iRecommend, isSaving);
  }
}