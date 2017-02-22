import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/props/map_to_my_booklogs.dart';
import 'package:bookshelf_client/props/map_to_top_props.dart';
import 'package:bookshelf_client/types/view_model.dart';

ViewModel mapModelToViewModel(Model model) {
  if(model.top != null){
    return mapToTopProps(model);
  }else if(model.myBookLog != null){
    return mapToMyBookLogs(model);
  }
}