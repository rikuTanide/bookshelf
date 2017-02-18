import 'mock/book_log_props.dart';
import 'mock/header_link_params.dart';
import 'mock/my_book_log_props.dart';
import 'mock/top_props.dart';
import 'mock_view_model_service.dart';
import 'package:angular2/core.dart';
import 'package:bookshelf_client/bookshelf_component/bookshelf_component.dart';
import 'package:bookshelf_client/services/view_model_service.dart';
import 'package:angular2/platform/browser.dart';

void main() {
  var viewModelService = new Provider(
      ViewModelService, useClass: ViewModelServiceMock);
  bootstrap(BookshelfComponent,
      [
        viewModelService,
        TopPropsMock,
        MyBookLogPropsMock,
        HeaderLinkParamsMock,
        BookLogPropsMock
      ]);
}