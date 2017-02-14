library bookshelf_client.types.top;

import 'package:bookshelf_client/types/share.dart';

class TopProps {
  final HeaderLinkParams headerLinkParams;
  final List<BookLogger> bookLoggers;

  TopProps(this.headerLinkParams, this.bookLoggers);

}

class BookLogger {
  final String name;

  final int latestYear, latestMonth;

  BookLogger(this.name, this.latestYear, this.latestMonth);
}