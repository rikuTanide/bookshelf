library bookshelf_client.types.top;

import 'package:bookshelf_client/types/share.dart';

class TopProps {
  final HeaderLinkParams headerLinkParams;
  final List<BookLogger> bookLoggers;
  final bool isLoading;

  TopProps(this.headerLinkParams, this.bookLoggers, this.isLoading);

}

class BookLogger {
  final String name;

  final int latestYear, latestMonth;

  BookLogger(this.name, this.latestYear, this.latestMonth);
}