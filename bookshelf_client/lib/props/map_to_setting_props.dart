import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/setting.dart' as m;
import 'package:bookshelf_client/types/setting.dart' as v;
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/view_model.dart';

ViewModel mapToSettingProps(Model model) =>
    new ViewModel(setting: new v.SettingProps(_getHeaderLinkParams(model),
        model.setting.editUsername,
        model.setting.isLoading,
        _getDisabled(model),
        model.setting.isSaving,
        model.setting.request?.response == null ? false : !model.setting.request
            .response
    ));

bool _getDisabled(Model model) => model.setting.isSaving == true ? true :  model.setting.request == null ? false : _getRequestDisabled(model);

bool _getRequestDisabled(Model model) => model.setting.request.response == null ? true : _getResponseDisabled(model);

bool _getResponseDisabled(Model model) => !model.setting.request.response;

HeaderLinkParams _getHeaderLinkParams(Model model) =>
    new HeaderLinkParams(model.username, model.now.year, model.now.month);
