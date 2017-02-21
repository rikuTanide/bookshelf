import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/stocks.dart';

@Component(
  selector: 'bookshelf-stocks',
  templateUrl: 'bookshelf_stocks_component.html',
  styleUrls: const <String>['bookshelf_stocks_component.css'])
class BookshelfStocksComponent  {

  @Input()
  StocksProps stocksProps;

  String get username => stocksProps.headerLinkParams.username;

  int get latest_year => stocksProps.headerLinkParams.latest_year;

  int get latest_month => stocksProps.headerLinkParams.latest_month;

  bool get isLoading => stocksProps.isLoading;

  List<Stock> get stocks => stocksProps.stocks;

}
