import 'package:angular2/core.dart';
import 'package:bookshelf_client/bookshelf_top_component/bookshelf_top_component.dart';
import 'package:bookshelf_client/services/view_model_service.dart';
import 'package:bookshelf_client/types/my_booklogs.dart';
import 'package:bookshelf_client/types/booklogs.dart';
import 'package:bookshelf_client/types/my_stocks.dart';
import 'package:bookshelf_client/types/stocks.dart';
import 'package:bookshelf_client/types/top.dart';

@Component(
    selector: 'bookshelf-component',
    templateUrl: 'bookshelf_component.html',
    styleUrls: const <String>['bookshelf_component.css'],
    directives: const [BookshelfTopComponent],
    providers: const[ViewModelService])
class BookshelfComponent {

  ViewModelService viewModelService;

  BookshelfComponent(this.viewModelService);

  TopProps get top => viewModelService.viewModel.top;

  MyBookLogsProps get myBookLogs => viewModelService.viewModel.myBookLogs;

  BookLogsProps get bookLogs => viewModelService.viewModel.bookLogs;

  MyStocksProps get myStocks => viewModelService.viewModel.myStocks;

  StocksProps get stocks => viewModelService.viewModel.stocks;

}
