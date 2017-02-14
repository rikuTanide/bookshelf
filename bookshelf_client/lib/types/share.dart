library bookshelf_client.types.share;

class YearSelectState {
  final int year;
  final bool selected;

  YearSelectState(this.year, this.selected);
}

class MonthEnabled {
  final int month;
  final bool enabled;

  MonthEnabled(this.month, this.enabled);
}

class BookAttrs {
  final String title, author, image;

  BookAttrs(this.title, this.author, this.image);
}