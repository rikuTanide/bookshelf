import 'header_link_params.dart';
import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/booklogs.dart';
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/view_model.dart';

@Injectable()
class BookLogPropsMock {

  final HeaderLinkParamsMock headerLinkParamsMock;

  BookLogPropsMock(this.headerLinkParamsMock);


  ViewModel getBookLogProp(bool isLoading) {
    if (isLoading) {
      var headerLinkParams = headerLinkParamsMock.getHeaderLinkParams();
      var years = getYearSelectStates();
      var months = getMonthEnables();
      return new ViewModel(bookLogs: new BookLogsProps(
          headerLinkParams,
          2017,
          2,
          years,
          months,
          true,
          "user2",
          []));
    }
    var headerLinkParams = headerLinkParamsMock.getHeaderLinkParams();
    var years = getYearSelectStates();
    var months = getMonthEnables();
    return new ViewModel(bookLogs: new BookLogsProps(
        headerLinkParams,
        2017,
        2,
        years,
        months,
        false,
        "user2",
        getBookLogList()));
  }

  List<BookLog> getBookLogList() {
    var attrs = new BookAttrs("タイトル１", "著者１", "img.png");
    return [
      new BookLog("1", attrs, false, "", false, false),
      new BookLog("1", attrs, true, "https://www.example.com", false, false),
      new BookLog("2", attrs, false, "", true, false),
      new BookLog("3", attrs, false, "", false, true),
      new BookLog("3", attrs, false, "", true, true),

    ];
  }

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

}

class MonthEnabled {
  final int year;
  final int month;
  final bool active;
  final bool enabled;

  MonthEnabled(this.year,
      this.month,
      this.active,
      this.enabled);
}