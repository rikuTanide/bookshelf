library bookshelf_client.types.setting;

import 'package:bookshelf_client/types/share.dart';

class SettingProps {
  final HeaderLinkParams headerLinkParams;

  final String edit_username;
  final bool isLoading;
  final bool disabled;
  final bool isSaving;
  final bool hasError;

  SettingProps(this.headerLinkParams, this.edit_username, this.isLoading,
      this.disabled,
      this.isSaving, this.hasError);
}