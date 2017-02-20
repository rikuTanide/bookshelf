import 'header_link_params.dart';
import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/my_stocks.dart';
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/view_model.dart';

@Injectable()
class MyStocksPropsMock {

  final HeaderLinkParamsMock headerLinkParamsMock;

  MyStocksPropsMock(this.headerLinkParamsMock);

  ViewModel getMyStocksProps(bool isLoading) {
    var header = headerLinkParamsMock.getHeaderLinkParams();
    if (isLoading) {
      return new ViewModel(myStocks: new MyStocksProps(header, [], isLoading));
    }

    return new ViewModel(
        myStocks: new MyStocksProps(header, getMyStocks(), false));
  }

  List<Stock> getMyStocks() => [
    getMyStock(),
    getMyStock(isEditing: true),
    getMyStock(isEditing: true, isValid: false),
    getMyStock(isEditing: true, isSaving: true),
    getMyStock(isEditing: true, isDeleting: true),
    getMyStock(isEditing: true, isTitleSuggestionViewing: true),
    getMyStock(isEditing: true,
        isTitleSuggestionViewing: true,
        isTitleSuggestionLoading: true),
    getMyStock(isEditing: true, isAuthorSuggestionViewing: true),
    getMyStock(isEditing: true,
        isAuthorSuggestionViewing: true,
        isAuthorSuggestionLoading: true),

  ];

  Stock getMyStock({
  bool isEditing: false,
  bool isValid: true,
  bool isSaving: false,
  bool isDeleting: false,
  bool isTitleSuggestionViewing: false,
  bool isTitleSuggestionLoading: false,
  bool isAuthorSuggestionViewing: false,
  bool isAuthorSuggestionLoading: false}) {
    var attr = new BookAttrs("本１", "著者１", "img.png");

    if (isEditing) {
      if (isSaving) {
        var title = new TitleSuggestions(false, false, []);
        var author = new AuthorSuggestions(false, false, []);
        return new Stock(
            attr,
            title,
            author,
            true,
            true,
            true,
            true,
            false);
      }else if (isDeleting) {
        var title = new TitleSuggestions(false, false, []);
        var author = new AuthorSuggestions(false, false, []);
        return new Stock(
            attr,
            title,
            author,
            true,
            true,
            true,
            false,
            true);
      }else if(!isValid){
        var title = new TitleSuggestions(false, false, []);
        var author = new AuthorSuggestions(false, false, []);
        return new Stock(
            attr,
            title,
            author,
            true,
            false,
            false,
            false,
            false);
      } else if (isTitleSuggestionViewing) {
        if (isTitleSuggestionLoading) {
          var title = new TitleSuggestions(true, true, getTitleSuggestions());
          var author = new AuthorSuggestions(false, false, []);
          return new Stock(
              attr,
              title,
              author,
              true,
              true,
              false,
              false,
              false);
        } else {
          var title = new TitleSuggestions(true, false, getTitleSuggestions());
          var author = new AuthorSuggestions(false, false, []);
          return new Stock(
              attr,
              title,
              author,
              true,
              true,
              false,
              false,
              false);
        }
      } else if (isAuthorSuggestionViewing) {
        if (isAuthorSuggestionLoading) {
          var title = new TitleSuggestions(false, false, []);
          var author = new AuthorSuggestions(
              true,
              true,
              getAuthorSuggestions());
          return new Stock(
              attr,
              title,
              author,
              true,
              true,
              false,
              false,
              false);
        } else {
          var title = new TitleSuggestions(false, false, []);
          var author = new AuthorSuggestions(
              true, false, getAuthorSuggestions());
          return new Stock(
              attr,
              title,
              author,
              true,
              true,
              false,
              false,
              false);
        }
      } else {
        var title = new TitleSuggestions(false, false, []);
        var author = new AuthorSuggestions(
            false,
            false,
            getAuthorSuggestions());
        return new Stock(
            attr,
            title,
            author,
            true,
            true,
            false,
            false,
            false);
      }
    } else {
      var title = new TitleSuggestions(false, false, []);
      var author = new AuthorSuggestions(false, false, []);
      return new Stock(
          attr,
          title,
          author,
          false,
          true,
          false,
          false,
          false);
    }
  }

  List<AuthorSuggest> getAuthorSuggestions() => [
    new AuthorSuggest("著者１", "img.png"),
    new AuthorSuggest("著者２", "img.png"),
    new AuthorSuggest("著者３", "img.png"),
  ];

  List<String> getTitleSuggestions() => ["タイトル１", "タイトル２", "タイトル３"];

}
