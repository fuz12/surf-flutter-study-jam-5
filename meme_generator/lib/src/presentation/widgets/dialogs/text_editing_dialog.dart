import 'package:flutter/material.dart';

import '../other/spacers.dart';

class TextEditingDialog extends StatefulWidget {
  const TextEditingDialog(this.onSave, this.text, {super.key});

  final void Function(String) onSave;
  final String text;

  @override
  State<TextEditingDialog> createState() => _TextEditingDialogState();
}

class _TextEditingDialogState extends State<TextEditingDialog> {
  late final textEditingController = TextEditingController(text: widget.text);

  void onLoad(String url) {
    widget.onSave(textEditingController.text);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Введите желаемый текст'),
              TextField(
                controller: textEditingController,
              ),
              const VSpacer(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => onLoad(textEditingController.text),
                    child: const Text('Сохранить'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Отменить'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
