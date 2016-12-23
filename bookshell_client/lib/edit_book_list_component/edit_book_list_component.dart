import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'edit-book-list-component',
    templateUrl: 'edit_book_list_component.html',
    styleUrls: const <String>['edit_book_list_component.css'])
class EditBookListComponent implements OnInit {

  RouteParams _routeParams;

  EditBookListComponent(this._routeParams);

  @override
  void ngOnInit() {
    print(this._routeParams.get('year'));
  }

}