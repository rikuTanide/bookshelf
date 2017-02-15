import 'package:angular2/core.dart';
import 'package:bookshelf_client/services/view_model_service.dart';
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/top.dart';
import 'package:bookshelf_client/types/view_model.dart';

@Injectable()
class ViewModelServiceMock implements ViewModelService {

  @override
  ViewModel get viewModel => top(false);

  ViewModel top(bool isLoading) {
    if (isLoading) {
      return new ViewModel(
          new TopProps(
              getHeaderLinkParams(),
              [],
              true
          ), null, null, null, null
      );
    } else {
      return new ViewModel(
          new TopProps(
              getHeaderLinkParams(),
              [
                new BookLogger("logger1", 2017, 1),
                new BookLogger("logger2", 2016, 12),
                new BookLogger("logger3", 2016, 11),
                new BookLogger("logger4", 2016, 10),
              ],
              false),
          null, null, null, null
      );
    }
  }

  HeaderLinkParams getHeaderLinkParams() {
    return new HeaderLinkParams("user1", 2017, 1);
  }

}