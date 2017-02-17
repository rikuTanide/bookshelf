import 'header_link_params.dart';
import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/my_booklogs.dart';
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/view_model.dart';

@Injectable()
class MyBookLogPropsMock {

  HeaderLinkParamsMock headerLinkParamsMock;

  ViewModel getMyBookLogProps(bool isLoading) {
    if (isLoading) {
      var header = headerLinkParamsMock.getHeaderLinkParams();
      var years = getYearSelectStates();
      var months = getMonthEnables();
      return new ViewModel(
          myBookLogs: new MyBookLogsProps(header, years, months, true, []));
    }

    var header = headerLinkParamsMock.getHeaderLinkParams();
    var years = getYearSelectStates();
    var months = getMonthEnables();
    var bookLogs = getBookLog();
    return new ViewModel(
        myBookLogs: new MyBookLogsProps(header, years, months, true, []));
  }

  MyBookLogPropsMock(this.headerLinkParamsMock);

  List<YearSelectState> getYearSelectStates() {
    return [
      new YearSelectState(2015, false),
      new YearSelectState(2016, false),
      new YearSelectState(2017, true),
    ];
  }

  List<MonthEnabled> getMonthEnables() {
    return [];
  }

  List<BookLog> getBookLog() {
    return [];
  }

}