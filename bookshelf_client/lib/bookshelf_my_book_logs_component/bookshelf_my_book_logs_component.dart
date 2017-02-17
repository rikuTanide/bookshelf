import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/my_booklogs.dart';
import 'package:bookshelf_client/types/share.dart';

@Component(
  selector: 'bookshelf-my-book-logs',
  templateUrl: 'bookshelf_my_book_logs_component.html',
  styleUrls: const <String>['bookshelf_my_book_logs_component.css'])
class BookshelfMyBookLogsComponent  {

  @Input()
  MyBookLogsProps myBookLogsProps;

  String get username => myBookLogsProps.headerLinkParams.username;

  int get latest_year => myBookLogsProps.headerLinkParams.latest_year;

  int get latest_month => myBookLogsProps.headerLinkParams.latest_month;

  List<YearSelectState> get yearSelectStates => myBookLogsProps.yearSelectStates;

  List<MonthEnabled> get monthEnableds => myBookLogsProps.monthEnableds;

  bool get isLoading => myBookLogsProps.isLoading;

  List<BookLog> get bookLogs => myBookLogsProps.bookLogs;

}
