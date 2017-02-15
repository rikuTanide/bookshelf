import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/top.dart';

@Component(
  selector: 'bookshelf-top',
  templateUrl: 'bookshelf_top_component.html',
  styleUrls: const <String>['bookshelf_top_component.css'])
class BookshelfTopComponent  {

  @Input()
  TopProps topProps;

  String get username => topProps.headerLinkParams.username;

  int get latest_year => topProps.headerLinkParams.latest_year;

  int get latest_month => topProps.headerLinkParams.latest_month;

  List<BookLogger> get bookLoggers => topProps.bookLoggers;

  bool get isLoading => topProps.isLoading;


}
