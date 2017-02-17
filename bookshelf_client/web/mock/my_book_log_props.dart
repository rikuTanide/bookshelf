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
          myBookLogs: new MyBookLogsProps(
              header,
              2017,
              1,
              years,
              months,
              true,
              []));
    }

    var header = headerLinkParamsMock.getHeaderLinkParams();
    var years = getYearSelectStates();
    var months = getMonthEnables();
    var bookLogs = getBookLog();
    return new ViewModel(
        myBookLogs: new MyBookLogsProps(
            header,
            2017,
            1,
            years,
            months,
            false,
            bookLogs));
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
    return [
      new MonthEnabled(2017, 1, false, false),
      new MonthEnabled(2017, 2, false, false),
      new MonthEnabled(2017, 3, false, false),
      new MonthEnabled(2017, 4, false, false),
      new MonthEnabled(2017, 5, false, false),
      new MonthEnabled(2017, 6, false, false),
      new MonthEnabled(2017, 7, false, false),
      new MonthEnabled(2017, 8, false, false),
      new MonthEnabled(2017, 9, false, false),
      new MonthEnabled(2017, 10, false, false),
      new MonthEnabled(2017, 11, true, true),
      new MonthEnabled(2017, 12, false, true)
    ];
  }

  List<BookLog> getBookLog() {
    return [];
  }

}