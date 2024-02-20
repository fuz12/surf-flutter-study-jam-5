import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/dialogs/dialogs.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({super.key});

  @override
  State<MemeGeneratorScreen> createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen>
    with SingleTickerProviderStateMixin {
  final _memeSheetKey = GlobalKey();

  late final TabController tabController =
      TabController(length: 1, vsync: this);

  Uint8List? _imageBytes;
  String _text = 'Здесь мог бы быть ваш мем';

  Future<void> _onShareTap() async {
    final boundary = _memeSheetKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary?;
    final image = await boundary?.toImage();
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final bytes = byteData?.buffer.asUint8List();

    if (bytes == null) return;

    if (mounted && kIsWeb) {
      await Dialogs.showMeme(context, bytes);
    } else {
      await Share.shareXFiles([XFile.fromData(bytes, mimeType: 'image/png')]);
    }
  }

  void _editImageUrl(Uint8List bytes) {
    setState(() {
      _imageBytes = bytes;
    });
  }

  void _editText(String text) {
    setState(() {
      _text = text;
    });
  }

  Future<void> _onShowEditingImageUrl() async {
    await Dialogs.showNetworkImagePickerDialog(context, _editImageUrl);
  }

  Future<void> _onShowEditingText() async {
    await Dialogs.showTextEditing(context, _editText, _text);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: !kIsWeb ? _ShareButton(
          onTap: _onShareTap,
        ) : const SizedBox(),
        backgroundColor: Colors.black,
        body: Center(
          child: ColoredBox(
            color: Colors.black,
            child: SizedBox(
              height: 500,
              width: 500,
              child: _MemeDecoration(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(),
                    _MemeSheet(
                      memeSheetKey: _memeSheetKey,
                      imageBytes: _imageBytes,
                      onImageTap: _onShowEditingImageUrl,
                      text: _text,
                      onTextTap: _onShowEditingText,
                    ),
                    const Spacer(),
                    // _BottomTabBar(
                    //   onAddImageByUrl: _onEditImageUrl,
                    //   controller: tabController,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _MemeSheet extends StatelessWidget {
  const _MemeSheet({
    required this.imageBytes,
    required this.onImageTap,
    required this.text,
    required this.onTextTap,
    required this.memeSheetKey,
  });

  final Uint8List? imageBytes;
  final VoidCallback onImageTap;
  final String text;
  final VoidCallback onTextTap;
  final Key memeSheetKey;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: RepaintBoundary(
          key: memeSheetKey,
          child: Column(
            children: [
              _MemeImage(
                bytes: imageBytes,
                onTap: onImageTap,
              ),
              _MemeText(
                text: text,
                onTap: onTextTap,
              ),
            ],
          ),
        ),
      );
}

class _MemeText extends StatelessWidget {
  const _MemeText({
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Text(
          text == '' ? '?' : text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Impact',
            fontSize: 40,
            color: Colors.white,
          ),
        ),
      );
}

class _MemeImage extends StatelessWidget {
  const _MemeImage({
    required this.bytes,
    required this.onTap,
  });

  final Uint8List? bytes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bytes = this.bytes;
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 200,
          height: 200,
          child: _MemeDecoration(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: bytes != null ? Image.memory(
                bytes,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Что-то пошло не так,\nулыбнись!',
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: 'Impact',
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ) : Image.asset('assets/empty_image.jpeg'),
            ),
          ),
        ),
      );
  }
}

class _MemeDecoration extends StatelessWidget {
  const _MemeDecoration({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: child,
      );
}

class _BottomTabBar extends StatelessWidget {
  const _BottomTabBar({
    required this.onAddImageByUrl,
    required this.controller,
  });

  final VoidCallback onAddImageByUrl;
  final TabController controller;

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        height: 80,
        width: double.infinity,
        child: TabBarView(
          controller: controller,
          children: [
            IconButton(
              onPressed: onAddImageByUrl,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      );
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onTap,
        icon: const Icon(
          Icons.share,
          color: Colors.white,
          size: 40,
        ),
      );
}
