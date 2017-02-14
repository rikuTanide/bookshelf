library bookshelf_client.types.share;

class HeaderLinkParams {
  final String username;
  final int latest_year, latest_month;

  HeaderLinkParams(this.username, this.latest_year, this.latest_month);
}

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

class TitleSuggestions {
  final bool isViewing;
  final bool isLoading;
  final List<String> suggestions;

  TitleSuggestions(this.isViewing, this.isLoading, this.suggestions);
}

class AuthorSuggestions {
  final bool isViewing;
  final bool isLoading;
  final List<AuthorSuggest> authorSuggests;

  AuthorSuggestions(this.isViewing, this.isLoading, this.authorSuggests);
}
class AuthorSuggest {
  final String author, image;

  AuthorSuggest(this.author, this.image);
}
