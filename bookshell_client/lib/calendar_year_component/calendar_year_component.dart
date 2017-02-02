import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'calendar-year',
    templateUrl: 'calendar_year_component.html',
    styleUrls: const <String>['calendar_year_component.css'],
    directives: const [ROUTER_DIRECTIVES],
    providers: const[ROUTER_PROVIDERS])
class CalendarYearComponent {
  @Input()
  int year;
  List<int> years = [2014, 2015, 2016, 2017];
  List<int> months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  Router _router;
  RouteParams routeParams;

  CalendarYearComponent(this._router, this.routeParams);

  void setLocation(int month) {
    routeParams.params['year'] = year.toString();
    routeParams.params['month'] = month.toString();
    _router.navigate(['Routing', {'year':year, 'month':month}]);
  }

}
