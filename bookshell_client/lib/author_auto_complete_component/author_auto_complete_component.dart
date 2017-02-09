import 'dart:async';
import 'package:angular2/core.dart';
import 'package:bookshell_client/model.dart';

@Component(
  selector: 'author-auto-complete',
  templateUrl: 'author_auto_complete_component.html',
  styleUrls: const <String>['author_auto_complete_component.css'])
class AuthorAutoCompleteComponent  {

  AuthorAutoComplete autoComplete;

  AuthorAutoCompleteComponent(this.autoComplete);

  @Output()
  EventEmitter<String> onSelect = new EventEmitter();

  String _keyword = '';

  @Input()
  set keyword(String k) {
    if (k != "") {
      _keyword = k;
      setCandidates(k);
    }
  }

  Future setCandidates(String k) async {
    if(open){
      candidates = await autoComplete.autoComplete(k);
    }
  }

  List<String> candidates = [];

  @Input()
  set open(bool b){
    print(b);
    _open = b;
    setCandidates(_keyword);
  }

  bool _open = false;

  bool get open => _open;





  void onClick(String candidate) {
    onSelect.add(candidate);
  }

}
