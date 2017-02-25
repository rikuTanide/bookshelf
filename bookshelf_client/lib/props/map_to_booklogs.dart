import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/booklogs.dart' as m;
import 'package:bookshelf_client/types/booklogs.dart' as v;
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/view_model.dart';

ViewModel mapToBooklogsProps(Model model) =>
    new ViewModel(bookLogs: getBookLogs(model));

v.BookLogsProps getBookLogs(Model model) => model.bookLogs.booklogs == null
    ? new v.BookLogsProps(
        getHeaderLinkParams(model),
        model.bookLogs.pageMonth.year,
        model.bookLogs.pageMonth.month,
        [],
        [],
        true,
        model.bookLogs.username,
        [])
    : new v.BookLogsProps(
        getHeaderLinkParams(model),
        model.bookLogs.pageMonth.year,
        model.bookLogs.pageMonth.month,
        _getYearSelectStates(model.bookLogs.pageMonth.year),
        _getMonthEnabled(
            model.bookLogs.pageMonth.year,
            model.bookLogs.selectMonth.year,
            model.bookLogs.selectMonth.month,
            model.bookLogs.booklogs),
        false,
        model.bookLogs.username,
        _getBookLogs(model.bookLogs.booklogs, model.bookLogs.pageMonth,
            model.bookLogs.savingBookID));

HeaderLinkParams getHeaderLinkParams(Model model) =>
    new HeaderLinkParams(model.username, model.now.year, model.now.month);

/**
 * ページの年と選択されている年とボタンの年があり
 * 選択されている年=ボタンの年ならactive
 */
List<YearSelectState> _getYearSelectStates(int year) => [2014, 2015, 2016, 2017]
    .map((y) => new YearSelectState(y, year == y))
    .toList();

/**
 * ページの年月と選択されている年月とボタンの年月があり
 * ボタンの年=選択されいる年で
 * ページの年と選択されている年が等しく、かつ選択されている月とボタンの月が等しければactive
 * ブックログの中に年と月の等しい本があればenabled
 *
 */
List<v.MonthEnabled> _getMonthEnabled(int pageYear, int selectYear,
        int selectMonth, List<m.BookLog> bookLogs) =>
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        .map((m) => new v.MonthEnabled(
            selectYear,
            m,
            pageYear == selectYear && m == selectMonth,
            _isEnable(selectYear, m, bookLogs)))
        .toList();

bool _isEnable(int selectYear, int month, List<m.BookLog> bookLogs) => bookLogs
    .any((b) => b.dateTime.year == selectYear && b.dateTime.month == month);

List<v.BookLog> _getBookLogs(
        List<m.BookLog> bookLogs, DateTime pageMonth, String sid) =>
    bookLogs
        .where((b) =>
            b.dateTime.year == pageMonth.year &&
            b.dateTime.month == pageMonth.month)
        .map((b) => _getBookLog(b, sid))
        .toList();

v.BookLog _getBookLog(m.BookLog b, String sid) => new v.BookLog(
    b.id, _getBookAttr(b), b.review != "", b.review, b.isRead, sid == b.id);

BookAttrs _getBookAttr(m.BookLog b) =>
    new BookAttrs(b.title, b.author, b.image);
