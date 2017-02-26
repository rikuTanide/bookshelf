import 'package:bookshelf_client/types/view_model.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/types/my_stocks.dart' as v;
import 'package:bookshelf_client/model/my_stocks.dart' as m;
import 'package:bookshelf_client/types/share.dart';
import 'dart:async';

ViewModel mapToMyStocksProps(Model model) =>
    new ViewModel(myStocks: _getMyStocksParams(model));

v.MyStocksProps _getMyStocksParams(Model model) => model.myStocks.stocks == null
    ? new v.MyStocksProps(_getHeaderLinkParams(model), [], true)
    : new v.MyStocksProps(
        _getHeaderLinkParams(model), _getStocks(model).toList(), false);

HeaderLinkParams _getHeaderLinkParams(Model model) =>
    new HeaderLinkParams(model.username, model.now.year, model.now.month);

Iterable<v.Stock> _getStocks(Model model) sync* {
  if (model.myStocks.editing?.isAdding ?? false) {
    yield new v.Stock(
        _getEditingBookAttr(model.myStocks.editing),
        _getTitleSuggestions(model.myStocks.titleSuggestions),
        _getAuthorSuggestions(model.myStocks.authorSuggestions),
        true,
        _getIsValid(model.myStocks.editing),
        model.myStocks.editing.isDeleting || model.myStocks.editing.isSaving,
        model.myStocks.editing.isSaving,
        model.myStocks.editing.isDeleting);
  }
  for (var s in model.myStocks.stocks) {
    yield _getStock(model, s);
  }
}

v.Stock _getStock(Model m, m.Stock s) =>
    m.myStocks.editing == null || m.myStocks.editing.logID != s.id
        ? new v.Stock(
            _getBookAttr(s),
            _getTitleSuggestions(m.myStocks.titleSuggestions),
            _getAuthorSuggestions(m.myStocks.authorSuggestions),
            false,
            false,
            false,
            false,
            false)
        : new v.Stock(
            _getEditingBookAttr(m.myStocks.editing),
            _getTitleSuggestions(m.myStocks.titleSuggestions),
            _getAuthorSuggestions(m.myStocks.authorSuggestions),
            true,
            _getIsValid(m.myStocks.editing),
            m.myStocks.editing.isDeleting || m.myStocks.editing.isSaving,
            m.myStocks.editing.isSaving,
            m.myStocks.editing.isDeleting);

BookAttrs _getBookAttr(m.Stock s) => new BookAttrs(s.title, s.author, s.image);

BookAttrs _getEditingBookAttr(m.Editing e) =>
    new BookAttrs(e.title, e.author, e.image);

TitleSuggestions _getTitleSuggestions(m.TitleSuggestions titleSuggestions) =>
    titleSuggestions == null
        ? new TitleSuggestions(false, false, [])
        : new TitleSuggestions(
            true,
            titleSuggestions.titleSuggestionsResult == null,
            titleSuggestions.titleSuggestionsResult ?? []);

AuthorSuggestions _getAuthorSuggestions(
        m.AuthorSuggestions authorSuggestions) =>
    authorSuggestions == null
        ? new AuthorSuggestions(false, false, [])
        : new AuthorSuggestions(
            true,
            authorSuggestions.authorSuggestionsResults == null,
            authorSuggestions.authorSuggestionsResults
                    ?.map((a) => new AuthorSuggest(a.author, a.image))
                    ?.toList() ??
                []);

bool _getIsValid(m.Editing e) => (e.title != "" && e.author != "");
