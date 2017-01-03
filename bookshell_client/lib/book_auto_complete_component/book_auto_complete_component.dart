import 'dart:async';
import 'package:angular2/core.dart';
import 'package:bookshell_client/model.dart';

@Component(
    selector: 'book-auto-complete',
    templateUrl: 'book_auto_complete_component.html',
    styleUrls: const <String>['book_auto_complete_component.css']
)
class BookAutoCompleteComponent {
  AutoComplete autoComplete;

  BookAutoCompleteComponent(this.autoComplete);

  @Output()
  EventEmitter<Candidate> onSelect = new EventEmitter();

  @Input()
  set keyword(String k) {
    if (focus) {
      setCandidates(k);
    }
  }

  Future setCandidates(String k) async {
    candidates = await autoComplete.autoComplete(k);
  }

  List<Candidate> candidates = [];

  @Input()
  bool focus = false;

  void onClick(Candidate candidate) {
    onSelect.add(candidate);
  }

}
