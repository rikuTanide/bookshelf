import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/share.dart';

@Injectable()
class HeaderLinkParamsMock {

  getHeaderLinkParams() {
    return new HeaderLinkParams("user1", 2017, 1);
  }
}