import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/booklogs.dart';
import 'package:bookshelf_client/types/share.dart';

@Component(
    selector: 'bookshelf-book-logs',
    templateUrl: 'bookshelf_book_logs_component.html',
    styleUrls: const <String>['bookshelf_book_logs_component.css'])
class BookshelfBookLogsComponent {
  @Input()
  BookLogsProps bookLogsProps;

  String get myUsername => bookLogsProps.headerLinkParams.username;

  int get latest_year => bookLogsProps.headerLinkParams.latest_year;

  int get latest_month => bookLogsProps.headerLinkParams.latest_month;

  List<YearSelectState> get yearSelectStates => bookLogsProps.yearSelectStates;

  List<MonthEnabled> get monthEnableds => bookLogsProps.monthEnableds;

  bool get isLoading => bookLogsProps.isLoading;

  String get username => bookLogsProps.username;

  List<BookLog> get bookLogs => bookLogsProps.booklogs;



}