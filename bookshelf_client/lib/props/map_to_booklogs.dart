import 'package:bookshelf_client/model/model.dart' as model;
import 'package:bookshelf_client/model/my_booklogs.dart' as m;
import 'package:bookshelf_client/types/my_booklogs.dart' as v;
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/view_model.dart';

ViewModel mapToMyBookLogs(model.Model model) =>
    new ViewModel(myBookLogs: new v.MyBookLogsProps(
        _getHeaderLinkParams(model),
        model.myBookLog.year,
        model.myBookLog.month,
        _getYearSelectStates(model.myBookLog.year),
        _getMonthEnabled(model.myBookLog.year, model.myBookLog.month),
        model.myBookLog.bookLogs != null,
        _getBookLogs(model.myBookLog.year,
            model.myBookLog.month,
            model.myBookLog.bookLogs,
            model.myBookLog.titleSuggestions,
            model.myBookLog.authorSuggestions,
            model.myBookLog.editing)));


HeaderLinkParams _getHeaderLinkParams(model.Model model) =>
    new HeaderLinkParams(model.username, model.now.year, model.now.month);

List<YearSelectState> _getYearSelectStates(int year) =>
    [2014, 2015, 2016, 2017]
        .map((y) => new YearSelectState(y, year == y))
        .toList();

List<MonthEnabled> _getMonthEnabled(int year, int month) =>
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        .map((m) => new MonthEnabled(year, month, m == month))
        .toList();

List<v.BookLog> _getBookLogs(int year,
    int month,
    List<m.BookLog> bookLog,
    m.TitleSuggestions titleSuggestions,
    m.AuthorSuggestions authorSuggestions,
    m.Editing editing) =>
    bookLog.map((b) => new v.BookLog(
        b.id,
        _getBookAttrs(editing, b),
        _getTitleSuggestions(titleSuggestions),
        _getAuthorSuggestions(authorSuggestions),
        b.review != null,
        _editReviewState(b.review, editing),
        _bookLogState(editing)));

BookAttrs _getBookAttrs(m.Editing e, m.BookLog b) =>
    new BookAttrs(e?.title ?? b.title,
        e?.author ?? b.author,
        e?.image ?? b.image);

TitleSuggestions _getTitleSuggestions(m.TitleSuggestions titleSuggestions) =>
    new TitleSuggestions(titleSuggestions != null,
        titleSuggestions?.titleSuggestionsResult ?? true,
        titleSuggestions?.titleSuggestionsResult?.titleSuggestions ?? []);

AuthorSuggestions _getAuthorSuggestions(
    m.AuthorSuggestions authorSuggestions) => new AuthorSuggestions(
    authorSuggestions != null,
    authorSuggestions?.authorSuggestionsResults ?? true,
    authorSuggestions?.authorSuggestionsResults?.authorSuggestions?.map((
        a) => new AuthorSuggest(a.author, a.image)) ?? []);

v.EditReviewState _editReviewState(String review, m.Editing editing) =>
    new v.EditReviewState(review, _isEnableURL(review));

v.BookLogState _bookLogState(m.Editing e) => new v.BookLogState(
    e != null,
    (e?.isSaving || e?.isDeleting) ?? false,
    _getIsValid(e),
    e?.isSaving ?? false,
    e.isDeleting ?? false);

bool _getIsValid(m.Editing e) =>
    e == null ? true : (e.title != "" && e.author != "" && e.review != "") &&
        _isEnableURL(e.review);

bool _isEnableURL(String review) {
  try {
    var uri = Uri.parse(review);
    var scheme = uri.scheme;
    var host = uri.host;
    var path = uri.path;
    var query = uri.queryParameters;
    print([scheme, host, path, query]);
    return true;
  } catch (e) {
    return false;
  }
}