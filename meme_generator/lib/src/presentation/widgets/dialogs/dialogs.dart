import 'package:flutter/material.dart';

import 'network_image_dialog.dart';
import 'text_editing_dialog.dart';

abstract class Dialogs {
  static Future<void> showNetworkImagePickerDialog(
      BuildContext context, void Function(String) onLoad, String url,) async {
    await showDialog<dynamic>(
        context: context, builder: (_) => NetworkImagePickerDialog(onLoad, url),);
  }

  static Future<void> showTextEditing(BuildContext context, void Function(String) onSave, String text) async {
    await showDialog<dynamic>(context: context, builder: (_) => TextEditingDialog(onSave, text));
  }
}
