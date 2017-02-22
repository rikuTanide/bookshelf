library bookshelf_client.types.setting;

import 'package:bookshelf_client/types/share.dart';

class SettingProps {
  final HeaderLinkParams headerLinkParams;

  final String username;
  final bool isLoading;
  final bool enabled;
  final bool isSaving;

  SettingProps(this.headerLinkParams, this.username, this.isLoading, this.enabled,
      this.isSaving);
}