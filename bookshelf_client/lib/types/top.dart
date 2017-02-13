library bookshelf_client.types.top;

class TopProps {
  final String username;
  final int latestYear, latestMonth;
  final List<BookLogger> bookLoggers;

  TopProps(this.username, this.latestYear, this.latestMonth, this.bookLoggers);

}

class BookLogger {
  final String name;

  final int latestYear, latestMonth;

  BookLogger(this.name, this.latestYear, this.latestMonth);
}