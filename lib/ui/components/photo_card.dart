import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Photo extends StatelessWidget {
  final String linkImage;
  final BoxFit boxfit;
  final double? height;
  final double? width;
  final bool rounded;

  const Photo(
      {required this.linkImage,
      required this.boxfit,
      this.height,
      this.width,
      required this.rounded,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return rounded ? ClipOval(child: _getImagem()) : _getImagem();
  }

  Widget _getImagem() {
    if (linkImage.contains('http:') || linkImage.contains('https:')) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: linkImage,
        height: height,
        width: width,
        fit: boxfit,
      );
    } else {
      return Image.asset(linkImage, height: height, width: width, fit: boxfit);
    }
  }
}
