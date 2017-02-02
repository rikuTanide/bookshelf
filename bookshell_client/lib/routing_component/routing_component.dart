import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:bookshell_client/login_component/login_component.dart';
import 'package:bookshell_client/edit_book_list_component/edit_book_list_component.dart';
import 'package:bookshell_client/model.dart';
import 'package:bookshell_client/register_component/register_component.dart';

@Component(
    selector: 'routing-component',
    templateUrl: 'routing_component.html',
    styleUrls: const <String>['routing_component.css'],
    directives: const[ROUTER_DIRECTIVES,
    materialDirectives,
    EditBookListComponent,
    LoginComponent,
    RegisterComponent,
    ],
    providers: const [
      AuthService,
      PersistenceService,
      ROUTER_PROVIDERS
    ])
class RoutingComponent {
  PersistenceService store;

  AuthService auth;
  RouteParams routeParams;

  RoutingComponent(this.store, this.auth,this.routeParams);

  int get year {
    return int.parse(routeParams.get('year'));
  }

  int get month {
    return int.parse(routeParams.get('month'));
  }



}
