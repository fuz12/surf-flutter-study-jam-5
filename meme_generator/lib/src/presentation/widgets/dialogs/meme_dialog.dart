import 'dart:typed_data';

import 'package:flutter/material.dart';

class MemeDialog extends StatelessWidget {
  const MemeDialog({required this.bytes, super.key,
  });

  final Uint8List bytes;

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: Colors.black,
    child: Image.memory(bytes),
  );
}
