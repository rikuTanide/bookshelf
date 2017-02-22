import 'header_link_params.dart';
import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/top.dart';
import 'package:bookshelf_client/types/view_model.dart';

@Injectable()
class TopPropsMock {

  HeaderLinkParamsMock headerLinkParamsMock;

  ViewModel top(bool isLoading) {
    if (isLoading) {
      return new ViewModel(top: new TopProps(headerLinkParamsMock.getHeaderLinkParams(), [], true));
    } else {
      var header = headerLinkParamsMock.getHeaderLinkParams();
      var booklogs = [
        new BookLogger("logger1", 2017, 1),
        new BookLogger("logger2", 2016, 12),
        new BookLogger("logger3", 2016, 11),
        new BookLogger("logger4", 2016, 10),
      ];
      return new ViewModel(top: new TopProps(header, booklogs, false));
    }
  }

  TopPropsMock(this.headerLinkParamsMock);
}
