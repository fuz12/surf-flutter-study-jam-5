import 'package:flutter/material.dart';

import '../widgets/dialogs/dialogs.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({super.key});

  @override
  State<MemeGeneratorScreen> createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> with SingleTickerProviderStateMixin {
  late final TabController tabController = TabController(length: 1, vsync: this);

  String url = 'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';
  String text = 'Здесь мог бы быть ваш мем';

  // Future<void> _onLoadImageByUrl(String url) async {
  //   // final bytes = (await NetworkAssetBundle(Uri.parse(url))
  //   //         .load(url))
  //   //         .buffer
  //   //         .asUint8List();
  //   setState(() {
  //     this.url = url;
  //   });
  // }

  void _onEditImageUrl(String url) {
    setState(() {
      this.url = url;
    });
  }

  void _onEditText(String text) {
    setState(() {
      this.text = text;
    });
  }

  Future<void> _onShowEditingImageUrl() async {
    await Dialogs.showNetworkImagePickerDialog(context, _onEditImageUrl, url);
  }

  Future<void> _onShowEditingText() async {
    await Dialogs.showTextEditing(context, _onEditText, text);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: ColoredBox(
            color: Colors.black,
            child: _MemeDecoration(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  _MemeSheet(
                    url: url,
                    onImageTap: _onShowEditingImageUrl,
                    text: text,
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
      );
}

class _MemeSheet extends StatelessWidget {
  const _MemeSheet({
    required this.url,
    required this.onImageTap,
    required this.text,
    required this.onTextTap,
  });

  final String url;
  final VoidCallback onImageTap;
  final String text;
  final VoidCallback onTextTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Column(
          children: [
            _MemeImage(
              url: url,
              onTap: onImageTap,
            ),
            _MemeText(
              text: text,
              onTap: onTextTap,
            ),
          ],
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
    required this.url,
    required this.onTap,
  });

  final String url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: SizedBox(
          width: double.infinity,
          height: 200,
          child: _MemeDecoration(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.network(
                url,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Что-то пошло не так, улыбнитесь!',
                    style: TextStyle(
                      fontFamily: 'Impact',
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
  );
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
