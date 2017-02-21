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

  int get current_year => myBookLogsProps.headerLinkParams.current_year;

  int get current_month => myBookLogsProps.headerLinkParams.current_month;

  List<YearSelectState> get yearSelectStates => myBookLogsProps.yearSelectStates;

  List<MonthEnabled> get monthEnableds => myBookLogsProps.monthEnableds;

  bool get isLoading => myBookLogsProps.isLoading;

  List<BookLog> get bookLogs => myBookLogsProps.bookLogs;

}
