import 'dart:async';
import 'package:angular2_components/angular2_components.dart';
import 'package:bookshell_client/calendar_year_component/calendar_year_component.dart';
import 'package:bookshell_client/edit_book_component/edit_book_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'edit-book-list',
    templateUrl: 'edit_book_list_component.html',
    styleUrls: const <String>['edit_book_list_component.css'],
    directives: const[
      materialDirectives,
      EditBookComponent,
      CalendarYearComponent,
      ROUTER_DIRECTIVES,
    ],
    providers: const[ROUTER_PROVIDERS])
class EditBookListComponent {

  PersistenceService store;
  AuthService auth;
  String trackingID;
  Book addBook = new Book()
    ..title = ''
    ..author = ''
    ..datetime = new DateTime.now();

  Book addStack = new Book()
    ..title = ''
    ..author = ''
    ..datetime = new DateTime.now();

  RouteParams routeParams;

  @Input()
  int year;
  @Input()
  int month;

  String userID = "";

  EditBookListComponent(this.store, this.auth, this.routeParams){
    auth.getTrackingID.listen((id) => trackingID = id);
  }

  List<Book> get books {
    return store
        .books
        .where((b) => b.datetime.year == year)
        .where((b) => b.datetime.month == month).toList();
  }

  List<Book> get stacks {
    return store.stacks;
  }

  DateTime getDateTime() {
    return new DateTime(year, month, 1);
  }

  void onBookAdd(Book book) {
    book.datetime = getDateTime();
    store.addBook(book);
    addBook = new Book()
      ..title = ''
      ..author = ''
      ..datetime = book.datetime;
  }

  void onBookEdit(Book book) {
    book.datetime = getDateTime();
    store.setBook(book);
  }

  void setUserID(int code) {
    if (code == 13) {
      if (store.isEnableUserName(auth.userID)) {
        print(true);
        auth.setUserID();
      }
      print(false);
    }
  }

  void onStackAdd(Book book) {
    store.addStack(book);
    addStack = new Book()
      ..title = ''
      ..author = ''
      ..datetime = new DateTime.now();
  }

  void onStackEdit(Book book) {
    store.setStack(book);
  }

  void setTrackingID() {
    print(trackingID);
    auth.setTrackingID(trackingID);
  }

}