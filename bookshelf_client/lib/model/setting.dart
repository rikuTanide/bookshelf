class Setting {
  String editUsername;
  bool isLoading;
  Request request;
  bool isSaving;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Setting &&
        this.editUsername == other.editUsername &&
        this.isLoading == other.isLoading &&
        this.request == other.request &&
        this.isSaving == other.isSaving;
  }

  @override
  int get hashCode {
    return editUsername.hashCode ^ isLoading.hashCode ^ request
        .hashCode ^ isSaving.hashCode;
  }
}


class Request {
  bool response;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Request &&
        this.response == other.response;
  }

  @override
  int get hashCode {
    return response.hashCode;
  }
}
