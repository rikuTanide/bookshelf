import 'mock/book_log_props.dart';
import 'mock/my_book_log_props.dart';
import 'mock/top_props.dart';
import 'package:angular2/core.dart';
import 'package:bookshelf_client/services/view_model_service.dart';
import 'package:bookshelf_client/types/view_model.dart';

@Injectable()
class ViewModelServiceMock implements ViewModelService {

  final TopPropsMock topPropsMock;
  final MyBookLogPropsMock myBookLogPropsMock;
  final BookLogPropsMock bookLogPropsMock;

  @override
  ViewModel get viewModel => bookLogPropsMock.getBookLogProp(false);


  ViewModelServiceMock(this.topPropsMock, this.myBookLogPropsMock,this.bookLogPropsMock);


}