import 'package:flutter/material.dart' show MaterialPage, Page, ValueKey, Widget;

Page<void> asMaterialPage(Widget w, String name) => MaterialPage(
      name: name,
      key: ValueKey(name),
      child: w,
    );
