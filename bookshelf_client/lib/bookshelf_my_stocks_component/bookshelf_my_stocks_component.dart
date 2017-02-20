import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/my_stocks.dart';

@Component(
    selector: 'bookshelf-my-stocks',
    templateUrl: 'bookshelf_my_stocks_component.html',
    styleUrls: const <String>['bookshelf_my_stocks_component.css'])
class BookshelfMyStocksComponent {

  @Input()
  MyStocksProps myStocksProps;

  String get username => myStocksProps.headerLinkParams.username;

  int get latest_year => myStocksProps.headerLinkParams.latest_year;

  int get latest_month => myStocksProps.headerLinkParams.latest_month;

  bool get isLoading => myStocksProps.isLoading;

  List<Stock> get stocks => myStocksProps.stocks;

}
