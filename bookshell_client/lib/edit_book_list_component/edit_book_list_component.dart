import 'dart:async';
import 'package:angular2_components/angular2_components.dart';
import 'package:bookshell_client/edit_book_component/edit_book_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'edit-book-list',
    templateUrl: 'edit_book_list_component.html',
    styleUrls: const <String>['edit_book_list_component.css'],
    directives: const[materialDirectives, EditBookComponent])
class EditBookListComponent {

  PersistenceService store;
  AuthService auth;
  Book addBook = new Book()
    ..title = ''
    ..author = ''
    ..datetime = new DateTime.now();

  EditBookListComponent(this.store, this.auth);

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

}