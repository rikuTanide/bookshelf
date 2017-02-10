import 'dart:async';
import 'package:angular2/core.dart';
import 'package:bookshell_client/model.dart';

@Component(
    selector: 'author-auto-complete',
    templateUrl: 'author_auto_complete_component.html',
    styleUrls: const <String>['author_auto_complete_component.css'])
class AuthorAutoCompleteComponent {

  AuthorAutoComplete autoComplete;

  AuthorAutoCompleteComponent(this.autoComplete);

  @Output()
  EventEmitter<AuthorCompleteItem> onSelect = new EventEmitter();

  String _keyword = '';

  @Input()
  set keyword(String k) {
    if (k != "") {
      _keyword = k;
      setCandidates(k);
    }
  }

  Future setCandidates(String k) async {
    if (open) {
      List<Map> maps = await autoComplete.autoComplete(k);
      candidates = maps.map((m) => new AuthorCompleteItem(
          m['title'], m['author'], m['asin'], m['image'])).toList();
    }
  }

  List<AuthorCompleteItem> candidates = [];

  @Input()
  set open(bool b) {
    print(b);
    _open = b;
    setCandidates(_keyword);
  }

  bool _open = false;

  bool get open => _open;


  void onClick(AuthorCompleteItem candidate) {
    onSelect.add(candidate);
  }

}

class AuthorCompleteItem {
  String author, title, asin, image;

  AuthorCompleteItem(this.title, this.author, this.asin, this.image);
}