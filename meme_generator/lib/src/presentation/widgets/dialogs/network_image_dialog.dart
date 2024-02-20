import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../other/spacers.dart';

enum ImagePickerType {
  network,
  gallery,
}

class NetworkImagePickerDialog extends StatefulWidget {
  const NetworkImagePickerDialog(this.onLoad, {super.key});

  final void Function(Uint8List) onLoad;

  @override
  State<NetworkImagePickerDialog> createState() =>
      _NetworkImagePickerDialogState();
}

class _NetworkImagePickerDialogState extends State<NetworkImagePickerDialog> {
  ImagePickerType _imagePickerType = ImagePickerType.network;

  late final _textEditingController = TextEditingController();

  Future<void> _onLoadFromUrl(String url) async {
    if (url == '') return;

    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      widget.onLoad(response.bodyBytes);
    } else {
      widget.onLoad(Uint8List.fromList([]));
    }

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _onLoadFromGallery() async {
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file == null) return;

    final bytes = await file.readAsBytes();
    widget.onLoad(bytes);

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SegmentedButton<ImagePickerType>(
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      _imagePickerType = newSelection.first;
                    });
                  },
                  segments: const [
                    ButtonSegment(
                      value: ImagePickerType.network,
                      label: FittedBox(child: Text('По ссылке')),
                    ),
                    ButtonSegment(
                      value: ImagePickerType.gallery,
                      label: FittedBox(child: Text('Из галереи')),
                    ),
                  ],
                  selected: <ImagePickerType>{_imagePickerType},
                ),
                const VSpacer(20),
                switch (_imagePickerType) {
                  ImagePickerType.network => _NetworkPicker(
                      textEditingController: _textEditingController,
                      onLoad: _onLoadFromUrl,
                    ),
                  _ => _GalleryPicker(
                      onLoad: _onLoadFromGallery,
                    ),
                },
              ],
            ),
          ),
        ),
  );
}

class _NetworkPicker extends StatelessWidget {
  const _NetworkPicker({
    required this.textEditingController,
    required this.onLoad,
  });

  final TextEditingController textEditingController;
  final void Function(String) onLoad;

  @override
  Widget build(BuildContext context) => Column(
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
      );
}

class _GalleryPicker extends StatelessWidget {
  const _GalleryPicker({
    required this.onLoad,
  });

  final void Function() onLoad;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Выберите картинку из галереи'),
          Center(
            child: IconButton(
              onPressed: onLoad,
              icon: const Icon(
                Icons.image,
                size: 100,
              ),
            ),
          ),
        ],
      );
}
