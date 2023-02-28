import 'package:flutter/material.dart';

class WidgetToImage22 extends StatefulWidget {
  final Function(GlobalKey key) builder;

  const WidgetToImage22({
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  _WidgetToImageState createState() => _WidgetToImageState();
}

class _WidgetToImageState extends State<WidgetToImage22> {
  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: widget.builder(globalKey),
    );
  }
}
