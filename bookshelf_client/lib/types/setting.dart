library bookshelf_client.types.setting;

import 'package:bookshelf_client/types/share.dart';

class Setting {
  final HeaderLinkParams headerLinkParams;

  final String username;
  final bool isLoading;
  final bool enabled;
  final bool isSaving;

  Setting(this.headerLinkParams, this.username, this.isLoading, this.enabled,
      this.isSaving);
}