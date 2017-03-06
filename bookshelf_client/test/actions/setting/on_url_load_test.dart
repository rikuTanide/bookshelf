import '../model_service_mock.dart';
import 'package:bookshelf_client/actions/url-load/action-url-load.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/setting.dart' as m;
import 'package:test/test.dart';

void main() {
  test("urlで表示してresponseがあったらそれを表示", () async {
    var now = new DateTime(2017, 1, 1);
    var model = new Model("user1", "", now);
    var modelService = new ModelServiceMock()
      ..model = model;

    var urlLoadAction = new URLLoadAction(
        modelService, null, null, null, null, null);
    var params = new URLParams(setting: new Setting());
    await urlLoadAction.onLoad(params);

    expect(modelService.modelHistory, equals([
      model,
      new Model.pageUpdate(modelService.model, setting: new m.Setting()
        ..editUsername = "user1"
        ..isLoading = false
        ..isSaving = false),
    ]));
  });
}