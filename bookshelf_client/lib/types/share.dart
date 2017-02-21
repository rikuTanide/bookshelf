library bookshelf_client.types.share;

class HeaderLinkParams {
  final String username;
  final int current_year, current_month;

  HeaderLinkParams(this.username, this.current_year, this.current_month);
}

class YearSelectState {
  final int year;
  final bool selected;

  YearSelectState(this.year, this.selected);
}

class MonthEnabled {
  final int year;
  final int month;
  final bool active;

  MonthEnabled(this.year,
      this.month,
      this.active);
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
