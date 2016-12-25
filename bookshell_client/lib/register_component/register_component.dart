import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:bookshell_client/model.dart';

@Component(
    selector: 'register',
    templateUrl: 'register_component.html',
    styleUrls: const <String>['register_component.css'],
    directives: const[materialDirectives])
class RegisterComponent implements OnInit {

  ElementRef elementRef;
  AuthService authService;

  String mailAddr = "";
  String password = "";
  bool disabled = false;

  RegisterComponent(this.elementRef, this.authService);

  @override
  void ngOnInit() {
    var e = (elementRef.nativeElement as Element);
    (e.querySelectorAll("input")[1] as InputElement).type = "password";
  }

  void click() {
    print([mailAddr, password]);
    disabled = true;
    authService.doPasswordRegister(mailAddr, password);
  }

}
