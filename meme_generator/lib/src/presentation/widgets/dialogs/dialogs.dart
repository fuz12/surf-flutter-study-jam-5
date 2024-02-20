import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'meme_dialog.dart';
import 'network_image_dialog.dart';
import 'text_editing_dialog.dart';

abstract class Dialogs {
  static Future<void> showNetworkImagePickerDialog(
      BuildContext context, void Function(Uint8List) onLoad,) async {
    await showDialog<dynamic>(
        context: context, builder: (_) => NetworkImagePickerDialog(onLoad),);
  }

  static Future<void> showTextEditing(BuildContext context, void Function(String) onSave, String text) async {
    await showDialog<dynamic>(context: context, builder: (_) => TextEditingDialog(onSave, text));
  }

  static Future<void> showMeme(BuildContext context, Uint8List bytes) async {
    await showDialog<dynamic>(context: context, builder: (_) => MemeDialog(bytes: bytes));
  }
}
