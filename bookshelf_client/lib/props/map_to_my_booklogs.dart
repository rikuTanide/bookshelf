import 'package:bookshelf_client/model/model.dart' as model;
import 'package:bookshelf_client/model/my_booklogs.dart' as m;
import 'package:bookshelf_client/types/my_booklogs.dart' as v;
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/view_model.dart';

ViewModel mapToMyBookLogs(model.Model model) =>
    new ViewModel(myBookLogs: new v.MyBookLogsProps(
        _getHeaderLinkParams(model),
        model.myBookLog.pageMonth.year,
        model.myBookLog.pageMonth.month,
        _getYearSelectStates(model.myBookLog.selectMonth.year),
        _getMonthEnabled(model.myBookLog.pageMonth.year,
            model.myBookLog.selectMonth.year,
            model.myBookLog.selectMonth.month),
        model.myBookLog.bookLogs == null,
        _getBookLogs(model.myBookLog.bookLogs,
            model.myBookLog.titleSuggestions,
            model.myBookLog.authorSuggestions,
            model.myBookLog.editing).toList()));


HeaderLinkParams _getHeaderLinkParams(model.Model model) =>
    new HeaderLinkParams(model.username, model.now.year, model.now.month);

/**
 * ページの年と選択されている年とボタンの年があり
 * 選択されている年=ボタンの年ならactive
 */
List<YearSelectState> _getYearSelectStates(int year) =>
    [2014, 2015, 2016, 2017]
        .map((y) => new YearSelectState(y, year == y))
        .toList();

/**
 * ページの年月と選択されている年月とボタンの年月があり
 * ボタンの年=選択されいる年で
 * ページの年と選択されている年が等しく、かつ選択されている月とボタンの月が等しければactive
 *
 */
List<MonthEnabled> _getMonthEnabled(int pageYear, int selectYear,
    int selectMonth) =>
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        .map((m) => new MonthEnabled(
        selectYear, m, pageYear == selectYear && m == selectMonth))
        .toList();

Iterable<v.BookLog> _getBookLogs(List<m.BookLog> bookLog,
    m.TitleSuggestions titleSuggestions,
    m.AuthorSuggestions authorSuggestions,
    m.Editing editing) sync* {
  if (bookLog == null) {
    return;
  }
  for (var b in bookLog) {
    yield _getBookLog(b, editing, titleSuggestions, authorSuggestions);
  }
  if (editing != null && editing.isAdding) {
    yield _getBookLog(new m.BookLog()
      ..title = ""
      ..author = ""
      ..image = ""
      ..review = "", editing, titleSuggestions, authorSuggestions);
  }
}


v.BookLog _getBookLog(m.BookLog b, m.Editing editing,
    m.TitleSuggestions titleSuggestions,
    m.AuthorSuggestions authorSuggestions) => new v.BookLog(
    b.id,
    _getBookAttrs(editing, b),
    _getTitleSuggestions(titleSuggestions),
    _getAuthorSuggestions(authorSuggestions),
    b.review != null,
    _editReviewState(b, editing),
    _bookLogState(b, editing));

BookAttrs _getBookAttrs(m.Editing e, m.BookLog b) =>
    e == null || e.logID != b.id ?
    new BookAttrs(b.title, b.author, b.image) :
    new BookAttrs(e.title, e.author, e.image);

TitleSuggestions _getTitleSuggestions(m.TitleSuggestions titleSuggestions) =>
    titleSuggestions == null ? new TitleSuggestions(false, false, []) :
    new TitleSuggestions(true,
        titleSuggestions.titleSuggestionsResult == null,
        titleSuggestions.titleSuggestionsResult ?? []);

AuthorSuggestions _getAuthorSuggestions(
    m.AuthorSuggestions authorSuggestions) => authorSuggestions == null
    ? new AuthorSuggestions(false, false, [])
    : new AuthorSuggestions(
    true,
    authorSuggestions.authorSuggestionsResults == null,
    authorSuggestions.authorSuggestionsResults?.map((a) => new AuthorSuggest(
        a.author, a.image))?.toList() ?? []);

v.EditReviewState _editReviewState(m.BookLog b, m.Editing editing) =>
    editing == null || editing.logID != b.id ?
    new v.EditReviewState(b.review, _isEnableURL(b.review)) :
    new v.EditReviewState(editing.review, _isEnableURL(editing.review));

v.BookLogState _bookLogState(m.BookLog b, m.Editing e) =>
    e == null || e.logID != b.id ?
    new v.BookLogState(
        false, false, false, false, false) :
    new v
        .BookLogState(
        true,
        e.isSaving || e.isDeleting,
        _getIsValid(e),
        e.isSaving,
        e.isDeleting);

bool _getIsValid(m.Editing e) =>
    (e.title != "" && e.author != "") &&
        _isEnableURL(e.review);

bool _isEnableURL(String review) {
  if (review == "") {
    return true;
  }
  try {
    var uri = Uri.parse(review);
    var scheme = uri.scheme;
    var host = uri.host;
    var path = uri.path;
    var query = uri.queryParameters;
    return (scheme == "http" || scheme == "https") &&
        host.length > 0;
  } catch (e) {
    return false;
  }
}
