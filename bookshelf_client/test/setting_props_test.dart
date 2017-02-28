import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/setting.dart' as m;
import 'package:bookshelf_client/types/setting.dart' as v;
import 'package:bookshelf_client/props/props.dart';
import 'package:bookshelf_client/types/view_model.dart';
import 'package:test/test.dart';

ViewModel getViewModel(m.Setting setting) {
  var model = new Model()
    ..now = new DateTime.now()
    ..setting = setting;
  return mapModelToViewModel(model);
}

void main() {
  test("nullでなければnullでない", () {
    var viewModel = getViewModel(new m.Setting());
    expect(viewModel, isNotNull);
  });
  test("edit_usernameが反映されている", () {
    var setting = new m.Setting()
      ..editUsername = "user1...";
    var viewModel = getViewModel(setting);
    expect(viewModel.setting.edit_username, "user1...");
  });
  test("isLoading", () {
    var setting = new m.Setting()
      ..isLoading = true;
    var viewModel = getViewModel(setting);
    expect(viewModel.setting.isLoading, isTrue);
  });
  test("requestがnull", () {
    var setting = new m.Setting()
      ..isLoading = false
      ..isSaving = false
      ..request = null;
    var viewModel = getViewModel(setting);
    expect(viewModel.setting.isSaving, isFalse);
    expect(viewModel.setting.disabled, isFalse);
    expect(viewModel.setting.hasError, isFalse);
  });
  test("requestのresponseがnull", () {
    var setting = new m.Setting()
      ..isLoading = false
      ..isSaving = false
      ..request = new m.Request();
    var viewModel = getViewModel(setting);
    expect(viewModel.setting.isSaving, isFalse);
    expect(viewModel.setting.disabled, isTrue);
    expect(viewModel.setting.hasError, isFalse);
  });
  test("requestのresponseがtrue", () {
    var setting = new m.Setting()
      ..isLoading = false
      ..isSaving = false
      ..request = (new m.Request()..response = true);
    var viewModel = getViewModel(setting);
    expect(viewModel.setting.isSaving, isFalse);
    expect(viewModel.setting.disabled, isFalse);
    expect(viewModel.setting.hasError, isFalse);
  });
  test("requestのresponseがfalse", () {
    var setting = new m.Setting()
      ..isLoading = false
      ..isSaving = false
      ..request = (new m.Request()..response = false);
    var viewModel = getViewModel(setting);
    expect(viewModel.setting.isSaving, isFalse);
    expect(viewModel.setting.disabled, isTrue);
    expect(viewModel.setting.hasError, isTrue);
  });
  test("isSavingがtrue", () {
    var setting = new m.Setting()
      ..isLoading = false
      ..isSaving = true;
    var viewModel = getViewModel(setting);
    expect(viewModel.setting.isSaving, isTrue);
    expect(viewModel.setting.disabled, isTrue);
    expect(viewModel.setting.hasError, isFalse);
  });
}