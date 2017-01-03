import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:bookshell_client/book_auto_complete_component/book_auto_complete_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'edit-book',
    templateUrl: 'edit_book_component.html',
    styleUrls: const <String>['edit_book_component.css'],
    directives: const[materialDirectives, BookAutoCompleteComponent])
class EditBookComponent implements OnInit {

  Book _book;

  ElementRef elementRef;

  bool titleFocus = false;

  @Input()
  set book(Book book) => _book = book;

  Book get book => _book;

  @Output()
  EventEmitter<Book> onBook = new EventEmitter();

  @Output()
  EventEmitter<Book> onBlur = new EventEmitter();

  set datetime(String str) {
    try {
      _book.datetime = DateTime.parse(str);
    } catch (e) {

    }
  }

  String get datetime => new DateFormat('yyyy-MM-dd').format(_book.datetime);

  EditBookComponent(this.elementRef) {

  }

  @override
  void ngOnInit() {}

  void onTitleEnter(int code) {
    if (code == 13) {
      Element e = elementRef.nativeElement;
      e.querySelectorAll('input')[1].focus();
    }
  }

  void onAuthorEnter(int code) {
    if (code == 13) {
      Element e = elementRef.nativeElement;
      e.querySelectorAll('input')[2].focus();
    }
  }

  void onDateTimeEnter(int code) {
    if (code == 13) {
      onBook.add(_book);
    }
  }

  void onTitleBlur() {
    onBlur.add(book);
    new Timer(new Duration(milliseconds: 100),()=>titleFocus = false);
  }

  void onFocus() {
    titleFocus = true;
  }

  void onAutoCompleteSelect(Candidate candidate) {
    print(candidate);
    _book
      ..title = candidate.title
      ..author = candidate.author;
  }

}
