import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:bookshell_client/model.dart';
import 'package:bookshell_client/register_component/register_component.dart';

@Component(
    selector: 'login',
    templateUrl: 'login_component.html',
    styleUrls: const <String>['login_component.css'],
    directives: const[materialDirectives, RegisterComponent],
    providers: const[ AuthService])
class LoginComponent implements OnInit {

  String mailAddr;
  String password;
  bool disabled = false;
  bool expended = true;

  AuthService auth;

  LoginComponent(this.auth);

  @override
  void ngOnInit() {}

}
