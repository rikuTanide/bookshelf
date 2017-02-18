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
    var bookLogs = getBookLogs();
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

  List<BookLog> getBookLogs() {
    return [
      getBookLog(1),
      getBookLog(2, hasReview: true),
      getBookLog(3, isEditing: true),
      getBookLog(4, isEditing: true, isTitleSuggestionViewing: true),
      getBookLog(5, isEditing: true,
          isTitleSuggestionViewing: true,
          isTitleSuggestionLoading: true),
      getBookLog(6, isEditing: true, isAuthorSuggestionViewing: true),
      getBookLog(7, isEditing: true,
          isAuthorSuggestionViewing: true,
          isAuthorSuggestionLoading: true),
      getBookLog(8, isEditing: true, isValidReviewURL: false),
      getBookLog(9,isEditing: true,isLocking: true),

    ];
  }

  BookLog getBookLog(int id,
      {bool hasReview: false,
      bool isEditing: false,
      bool isTitleSuggestionViewing: false,
      bool isTitleSuggestionLoading: false,
      bool isAuthorSuggestionViewing: false,
      bool isAuthorSuggestionLoading: false,
      bool isValidReviewURL: true,
      bool isLocking: false,
      bool isValid: false,
      bool isDeleting: false}) {

    if (isEditing) {

      if (isTitleSuggestionViewing) {
        if (isTitleSuggestionLoading) {
          var bookAttrs = new BookAttrs("タイトル$id", "著者$id", "img.png");
          var titleSuggestions = new TitleSuggestions(true, true, []);
          var authorSuggestions = new AuthorSuggestions(false, false, []);
          var editReviewState = new EditReviewState("", true);
          var bookLogState = new BookLogState(true, false, false, false);
          return new BookLog(
              "$id",
              bookAttrs,
              titleSuggestions,
              authorSuggestions,
              false,
              editReviewState,
              bookLogState);
        }
        var bookAttrs = new BookAttrs("タイトル$id", "著者$id", "img.png");
        var titleSuggestions = new TitleSuggestions(true, false, ["候補１", "候補２"]);
        var authorSuggestions = new AuthorSuggestions(false, false, []);
        var editReviewState = new EditReviewState("", true);
        var bookLogState = new BookLogState(true, false, false, false);
        return new BookLog(
            "$id",
            bookAttrs,
            titleSuggestions,
            authorSuggestions,
            false,
            editReviewState,
            bookLogState);
      }

      if (isAuthorSuggestionViewing) {
        if (isAuthorSuggestionLoading) {
          var bookAttrs = new BookAttrs("タイトル$id", "著者$id", "img.png");
          var titleSuggestions = new TitleSuggestions(false, false, []);
          var authorSuggestions = new AuthorSuggestions(true, true, []);
          var editReviewState = new EditReviewState("", true);
          var bookLogState = new BookLogState(true, false, false, false);
          return new BookLog(
              "$id",
              bookAttrs,
              titleSuggestions,
              authorSuggestions,
              false,
              editReviewState,
              bookLogState);
        }
        var bookAttrs = new BookAttrs("タイトル$id", "著者$id", "img.png");
        var titleSuggestions = new TitleSuggestions(false, false, []);
        var suggest1 = new AuthorSuggest("候補１", "img.png");
        var suggest2 = new AuthorSuggest("候補２", "img.png");
        var suggests = [suggest1, suggest2];
        var authorSuggestions = new AuthorSuggestions(true, false, suggests);
        var editReviewState = new EditReviewState("", true);
        var bookLogState = new BookLogState(true, false, false, false);
        return new BookLog(
            "$id",
            bookAttrs,
            titleSuggestions,
            authorSuggestions,
            false,
            editReviewState,
            bookLogState);
      }

      if (!isValidReviewURL) {
        var bookAttrs = new BookAttrs("タイトル$id", "著者$id", "img.png");
        var titleSuggestions = new TitleSuggestions(false, false, []);
        var authorSuggestions = new AuthorSuggestions(false, false, []);
        var editReviewState = new EditReviewState("https://aaa", false);
        var bookLogState = new BookLogState(true, false, false, false);
        return new BookLog(
            "$id",
            bookAttrs,
            titleSuggestions,
            authorSuggestions,
            false,
            editReviewState,
            bookLogState);
      }

      if(isLocking) {
        var bookAttrs = new BookAttrs("タイトル$id", "著者$id", "img.png");
        var titleSuggestions = new TitleSuggestions(false, false, []);
        var authorSuggestions = new AuthorSuggestions(false, false, []);
        var editReviewState = new EditReviewState("", true);
        var bookLogState = new BookLogState(true, true, false, false);
        return new BookLog(
            "$id",
            bookAttrs,
            titleSuggestions,
            authorSuggestions,
            false,
            editReviewState,
            bookLogState);
      }

      var bookAttrs = new BookAttrs("タイトル$id", "著者$id", "img.png");
      var titleSuggestions = new TitleSuggestions(false, false, []);
      var authorSuggestions = new AuthorSuggestions(false, false, []);
      var editReviewState = new EditReviewState("", true);
      var bookLogState = new BookLogState(true, false, false, false);
      return new BookLog(
          "$id",
          bookAttrs,
          titleSuggestions,
          authorSuggestions,
          false,
          editReviewState,
          bookLogState);
    }

    if (hasReview) {
      var bookAttrs = new BookAttrs("タイトル$id", "著者$id", "img.png");
      var titleSuggestions = new TitleSuggestions(false, false, []);
      var authorSuggestions = new AuthorSuggestions(false, false, []);
      var editReviewState = new EditReviewState(
          "https://www.example.com", true);
      var bookLogState = new BookLogState(false, false, false, false);
      return new BookLog(
          "$id",
          bookAttrs,
          titleSuggestions,
          authorSuggestions,
          true,
          editReviewState,
          bookLogState);
    }


    var bookAttrs = new BookAttrs("タイトル$id", "著者$id", "img.png");
    var titleSuggestions = new TitleSuggestions(false, false, []);
    var authorSuggestions = new AuthorSuggestions(false, false, []);
    var editReviewState = new EditReviewState("", true);
    var bookLogState = new BookLogState(false, false, false, false);
    return new BookLog(
        "$id",
        bookAttrs,
        titleSuggestions,
        authorSuggestions,
        false,
        editReviewState,
        bookLogState);
  }


}