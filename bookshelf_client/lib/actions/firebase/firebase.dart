import 'dart:async';

import 'package:bookshelf_client/model/top.dart';

abstract class FirebaseFetchUserList {
  Future<List<BookLogger>> fetchUserList();
}