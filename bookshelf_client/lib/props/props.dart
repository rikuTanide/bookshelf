import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/props/map_to_booklogs.dart';
import 'package:bookshelf_client/types/view_model.dart';

ViewModel mapModelToViewModel(Model model) {
  if(model.myBookLog != null){
    return mapToMyBookLogs(model);
  }
}