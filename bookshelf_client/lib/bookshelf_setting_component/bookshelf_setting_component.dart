import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/setting.dart';

@Component(
    selector: 'bookshelf-setting',
    templateUrl: 'bookshelf_setting_component.html',
    styleUrls: const <String>['bookshelf_setting_component.css'])
class BookshelfSettingComponent {

  @Input()
  SettingProps settingsProps;

  String get username => settingsProps.headerLinkParams.username;

  int get current_year => settingsProps.headerLinkParams.current_year;

  int get current_month => settingsProps.headerLinkParams.current_month;

  String get edit_username => settingsProps.edit_username;

  bool get isLoading => settingsProps.isLoading;

  bool get disabled => settingsProps.disabled;

  bool get isSaving => settingsProps.isSaving;

  bool get hasError => settingsProps.hasError;


}
