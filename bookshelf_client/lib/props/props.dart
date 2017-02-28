import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/props/map_to_booklogs.dart';
import 'package:bookshelf_client/props/map_to_my_booklogs.dart';
import 'package:bookshelf_client/props/map_to_setting_props.dart';
import 'package:bookshelf_client/props/map_to_top_props.dart';
import 'package:bookshelf_client/types/view_model.dart';
import 'package:bookshelf_client/props/map_to_my_stocks_props.dart';
import 'package:bookshelf_client/props/map_to_stocks_props.dart';

ViewModel mapModelToViewModel(Model model) {
  if (model.top != null) {
    return mapToTopProps(model);
  } else if (model.myBookLog != null) {
    return mapToMyBookLogs(model);
  } else if (model.bookLogs != null) {
    return mapToBooklogsProps(model);
  } else if (model.myStocks != null) {
    return mapToMyStocksProps(model);
  } else if (model.stocks != null) {
    return mapToStocksProps(model);
  } else if (model.setting != null) {
    return mapToSettingProps(model);
  }
}