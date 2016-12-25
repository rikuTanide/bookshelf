import 'package:angular2_components/angular2_components.dart';
import 'package:bookshell_client/edit_book_component/edit_book_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'edit-book-list-component',
    templateUrl: 'edit_book_list_component.html',
    styleUrls: const <String>['edit_book_list_component.css'],
    directives: const[materialDirectives, EditBookComponent])
class EditBookListComponent {

  RouteParams _routeParams;
  AuthService auth;
  PersistenceService store;
  Book addBook = new Book()
    ..title = ''
    ..author = ''
    ..datetime = new DateTime.now();
  List<Book> books = [];

  EditBookListComponent(this._routeParams, this.auth, this.store) {
    store.books.listen((b) => books = b);
  }

  void onBookAdd(Book book) {
    store.addBook(book);
    addBook = new Book()
      ..title = ''
      ..author = ''
      ..datetime = book.datetime;
  }

  void onBookEdit(Book book) {
    store.setBook(book);
  }

  void onBlur(book){
    store.setBook(book);
  }
}