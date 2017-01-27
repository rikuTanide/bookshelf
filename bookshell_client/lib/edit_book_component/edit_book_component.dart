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
  String autoCompleteKeyword = "";

  ElementRef elementRef;

  bool isOpenAutoComplete = false;

  @Input()
  set book(Book book) {
    _book = book;
  }

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

  bool onTitleEnter(int code, bool shift, bool ctrl) {
    print(code);
    print(shift);
    print(ctrl);
    if (code == 13) {
      Element e = elementRef.nativeElement;
      e.querySelectorAll('input')[1].focus();
      return false;
    } else if ((ctrl || shift) && (code == 32 || code == 0)) {
      isOpenAutoComplete = true;
      autoCompleteKeyword = book.title;
      return false;
    }
    return true;
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
      Element e = elementRef.nativeElement;
      e.querySelectorAll('input')[0].focus();
    }
  }

  void onTitleBlur() {
    onBlur.add(book);
    new Timer(
        new Duration(milliseconds: 1000), () => isOpenAutoComplete = false);
  }

  void onAutoCompleteSelect(Candidate candidate) {
    _book
      ..title = candidate.title
      ..author = candidate.author;
    Element e = elementRef.nativeElement;
    e.querySelectorAll('input')[0].focus();
  }

  void onReviewInput(int code) {

  }

}
