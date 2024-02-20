import 'package:flutter/material.dart';

class VSpacer extends StatelessWidget {
  const VSpacer(this.height, {super.key}) : sliver = false;
  const VSpacer.sliver(this.height, {super.key}) : sliver = true;

  final double height;
  final bool sliver;

  @override
  Widget build(BuildContext context) {
    Widget body = SizedBox(height: height);

    if (sliver) body = SliverToBoxAdapter(child: body);

    return body;
  }
}

class HSpacer extends StatelessWidget {
  const HSpacer(this.width, {super.key}) : sliver = false;
  const HSpacer.sliver(this.width, {super.key}) : sliver = true;

  final double width;
  final bool sliver;

  @override
  Widget build(BuildContext context) {
    Widget body  = SizedBox(width: width, height: 0);

    if (sliver) body = SliverToBoxAdapter(child: body);

    return body;
  }
}
