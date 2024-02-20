import 'package:flutter/material.dart';

import '../other/spacers.dart';

class NetworkImagePickerDialog extends StatefulWidget {
  const NetworkImagePickerDialog(this.onLoad, this.url, {super.key});

  final void Function(String) onLoad;
  final String url;

  @override
  State<NetworkImagePickerDialog> createState() => _NetworkImagePickerDialogState();
}

class _NetworkImagePickerDialogState extends State<NetworkImagePickerDialog> {
  late final textEditingController = TextEditingController(text: widget.url);

  void onLoad(String url) {
    widget.onLoad(textEditingController.text);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Введите url картинки и нажмите загрузить'),
              TextField(
                controller: textEditingController,
              ),
              const VSpacer(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => onLoad(textEditingController.text),
                    child: const Text('Загрузить'),
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
