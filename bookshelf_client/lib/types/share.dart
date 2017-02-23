library bookshelf_client.types.share;

import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;

class HeaderLinkParams {
  final String username;
  final int current_year, current_month;

  HeaderLinkParams(this.username, this.current_year, this.current_month);
}

class YearSelectState {
  final int year;
  final bool selected;

  YearSelectState(this.year, this.selected);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is YearSelectState &&
        this.year == other.year &&
        this.selected == other.selected;
  }

  @override
  int get hashCode {
    return year.hashCode ^ selected.hashCode;
  }
}


class BookAttrs {
  final String title, author, image;

  BookAttrs(this.title, this.author, this.image);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BookAttrs &&
        this.title == other.title &&
        this.author == other.author &&
        this.image == other.image;
  }

  @override
  int get hashCode {
    return title.hashCode ^ author.hashCode ^ image.hashCode;
  }

  @override
  String toString() {
    return 'BookAttrs{title: $title, author: $author, image: $image}';
  }
}

class TitleSuggestions {
  final bool isViewing;
  final bool isLoading;
  final List<String> suggestions;

  TitleSuggestions(this.isViewing, this.isLoading, this.suggestions);

  @override
  String toString() {
    return 'TitleSuggestions{isViewing: $isViewing, isLoading: $isLoading, suggestions: $suggestions}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is TitleSuggestions &&
        this.isViewing == other.isViewing &&
        this.isLoading == other.isLoading &&
        eq(this.suggestions, other.suggestions);
  }

  @override
  int get hashCode {
    return isViewing.hashCode ^ isLoading.hashCode ^ suggestions.hashCode;
  }
}

class AuthorSuggestions {
  final bool isViewing;
  final bool isLoading;
  final List<AuthorSuggest> authorSuggests;

  AuthorSuggestions(this.isViewing, this.isLoading, this.authorSuggests);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AuthorSuggestions &&
        this.isViewing == other.isViewing &&
        this.isLoading == other.isLoading &&
        eq(this.authorSuggests, other.authorSuggests);
  }

  @override
  int get hashCode {
    return isViewing.hashCode ^ isLoading.hashCode ^ authorSuggests.hashCode;
  }

  @override
  String toString() {
    return 'AuthorSuggestions{isViewing: $isViewing, isLoading: $isLoading, authorSuggests: $authorSuggests}';
  }
}

class AuthorSuggest {
  final String author, image;

  AuthorSuggest(this.author, this.image);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AuthorSuggest &&
        this.author == other.author &&
        this.image == other.image;
  }

  @override
  int get hashCode {
    return author.hashCode ^ image.hashCode;
  }
}
