import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:bookshell_client/edit_book_list_component/edit_book_list_component.dart';
import 'package:bookshell_client/register_component/register_component.dart';
import 'package:bookshell_client/year_select_component/year_select_component.dart';

@Component(
    selector: 'my-app',

    templateUrl: 'app_component.html',
    styleUrls: const <String>['app_component.css'],
    directives: const [ROUTER_DIRECTIVES],
    providers: const [
      ROUTER_PROVIDERS,
      const Provider(APP_BASE_HREF, useValue: "/bookshelf/bookshell_client/web/")
    ])
@RouteConfig(const [
  const Route(
      path: '/',
      name: 'YearSelect',
      component: YearSelectComponent,
      useAsDefault: true),
  const Route(
      path: '/edit/:year',
      name: 'EditBookList',
      component: EditBookListComponent),
  const Route(
      path: '/register',
      name: 'Register',
      component: RegisterComponent)
])
class AppComponent
    implements OnInit {

  AppComponent();

  @override
  void ngOnInit() {}

}
