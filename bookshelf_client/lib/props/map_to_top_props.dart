import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/top.dart';
import 'package:bookshelf_client/types/view_model.dart';

ViewModel mapToTopProps(Model model) =>
    new ViewModel(top: new TopProps(
        _getHeaderLinkParams(model),
        _getBookLoggers(model),
        model.top.bookLoggers == null));


HeaderLinkParams _getHeaderLinkParams(Model model) =>
    new HeaderLinkParams(model.username, model.now.year, model.now.month);

List<BookLogger> _getBookLoggers(Model model) =>
    model.top?.bookLoggers?.map((b) => new BookLogger(
        b.username, b.year, b.month))?.toList() ?? [];