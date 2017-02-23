import 'package:bookshelf_client/model/booklogs.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/props/props.dart';
import 'package:bookshelf_client/types/view_model.dart';
import 'package:test/test.dart';

ViewModel getViewModel() {
  var bookLogs = new BookLogs()
    ..pageMonth = new DateTime.now()
    ..selectMonth = new DateTime.now();
  var model = new Model()
    ..bookLogs = bookLogs
    ..now = new DateTime.now();
  return mapModelToViewModel(model);
}

void main() {
  test("nullでなければnullでない", () {
    var viewModel = getViewModel();
    expect(viewModel.bookLogs, isNotNull);
  });
}
