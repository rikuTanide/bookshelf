import 'header_link_params.dart';
import 'package:angular2/core.dart';
import 'package:bookshelf_client/types/setting.dart';
import 'package:bookshelf_client/types/view_model.dart';

@Injectable()
class SettingPropsMock {
  final HeaderLinkParamsMock headerLinkParamsMock;

  SettingPropsMock(this.headerLinkParamsMock);

  ViewModel setting() => new ViewModel(
      setting: new SettingProps(
          headerLinkParamsMock.getHeaderLinkParams(),
          edit_username,
          isLoading,
          disabled,
          isSaving,
          hasError));

  String get edit_username => "username...";

  bool get isLoading => false;

  bool get disabled => true;

  bool get isSaving => true;

  bool get hasError => false;


}