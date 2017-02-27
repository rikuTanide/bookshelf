import 'package:bookshelf_client/types/view_model.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/types/stocks.dart' as v;
import 'package:bookshelf_client/model/stocks.dart' as m;
import 'package:bookshelf_client/types/share.dart';

ViewModel mapToStocksProps(Model model) =>
    new ViewModel(stocks: new v.StocksProps(_getHeaderLinkParams(model),
        _getStocks(model), model.stocks.stocks == null));

HeaderLinkParams _getHeaderLinkParams(Model model) =>
    new HeaderLinkParams(model.username, model.now.year, model.now.month);

List<v.Stock> _getStocks(Model model) =>
    model.stocks.stocks == null ? [] :
    model.stocks.stocks
    .map((s) => new v.Stock(
        s.id,
        _getBookAttrs(s),
        s.iRecommend,
        model.stocks.savingStockID != null &&
            model.stocks.savingStockID == s.id))
    .toList();

BookAttrs _getBookAttrs(m.Stock s) => new BookAttrs(s.title, s.author, s.image);

