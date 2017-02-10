import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:bookshell_client/author_auto_complete_component/author_auto_complete_component.dart';
import 'package:bookshell_client/book_auto_complete_component/book_auto_complete_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'edit-book',
    templateUrl: 'edit_book_component.html',
    styleUrls: const <String>['edit_book_component.css'],
    directives: const[
      materialDirectives, BookAutoCompleteComponent, AuthorAutoCompleteComponent
    ])
class EditBookComponent {

  Book _book;
  String autoCompleteKeyword = "";

  ElementRef elementRef;

  bool isOpenAutoComplete = false;
  bool isOpenAuthorComplete = false;

  @Input()
  set book(Book book) {
    _book = book;
  }

  Book get book => _book;

  @Output()
  EventEmitter<Book> onBook = new EventEmitter();

  @Output()
  EventEmitter<Book> onBlur = new EventEmitter();

  EditBookComponent(this.elementRef) {

  }

  bool onTitleEnter(int code) {
    if (code == 13) {
      Element e = elementRef.nativeElement;
      e.querySelectorAll('input')[1].focus();
      return false;
    }
    return true;
  }

  void onAuthorEnter(int code) {
    if (code == 13) {
      Element e = elementRef.nativeElement;
      e.querySelectorAll('input')[0].focus();
      onBook.add(_book);
    }
  }

  void onTitleBlur() {
    onBlur.add(book);
    new Timer(
        new Duration(milliseconds: 100), () => isOpenAutoComplete = false);
  }

  void onAuthorBlur() {
    onBlur.add(book);
    new Timer(
        new Duration(milliseconds: 100), () => isOpenAuthorComplete = false);
  }

  void onAutoCompleteSelect(String candidate) {
    _book
      ..title = candidate;
    Element e = elementRef.nativeElement;
    e.querySelectorAll('input')[0].focus();
  }

  void onAuthorAutoCompleteSelect(AuthorCompleteItem candidate) {
    _book
      ..author = candidate.author
      ..image = candidate.image
      ..asin = candidate.asin;
    Element e = elementRef.nativeElement;
    e.querySelectorAll('input')[1].focus();
  }

  void onReviewInput(int code) {

  }

  void onTitleFocus() {
    isOpenAutoComplete = true;
  }

  void onAuthorFocus() {
    isOpenAuthorComplete = true;
  }

}
