import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:bookshell_client/edit_book_list_component/edit_book_list_component.dart';
import 'package:bookshell_client/login_component/login_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:bookshell_client/register_component/register_component.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:bookshell_client/routing_component/routing_component.dart';

const BASE = "/bookshelf/bookshell_client/web/";

@RouteConfig(const [
  const Route(path: '/:year/:month', name: 'Routing', component: RoutingComponent)
])
@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    styleUrls: const <String>['app_component.css'],
    directives: const [
      materialDirectives,
      EditBookListComponent,
      LoginComponent,
      RegisterComponent,
      ROUTER_DIRECTIVES
    ],
    providers: const [
      AuthService,
      PersistenceService,
      ROUTER_PROVIDERS
    ])
class AppComponent
    implements OnInit {

  PersistenceService store;

  AuthService auth;

  AppComponent(this.store, this.auth);


  @override
  void ngOnInit() {}

}
