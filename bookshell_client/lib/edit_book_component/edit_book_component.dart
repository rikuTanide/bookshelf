import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:bookshell_client/model.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'edit-book',
    templateUrl: 'edit_book_component.html',
    styleUrls: const <String>['edit_book_component.css'],
    directives: const[materialDirectives])
class EditBookComponent implements OnInit {

  Book _book;

  @Input()
  set book(Book book) => _book = book;

  Book get book => _book;

  set datetime(String str) {
    try {
      _book.datetime = DateTime.parse(str);
    } catch (e) {

    }
  }

  String get datetime => new DateFormat('yyyy-MM-dd').format(_book.datetime);

  EditBookComponent();

  @override
  void ngOnInit() {}

  void onEnter(int code) {
    print(code);
    print(code == 13);
  }

}
