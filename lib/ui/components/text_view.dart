import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String title;
  final String content;
  final Color textColor;
  final double? titleSize;
  final double? contentSize;

  const TextView({
    this.padding,
    required this.title,
    required this.content,
    required this.textColor,
    this.titleSize,
    this.contentSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: RichText(
        text: TextSpan(
            text: '',
            style: GoogleFonts.oxanium(
              color: textColor,
            ),
            //DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: title,
                style: GoogleFonts.oxanium(
                  fontSize: titleSize ?? 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              TextSpan(
                text: content,
                style: GoogleFonts.oxanium(
                  fontSize: contentSize ?? 14,
                  color: textColor,
                ),
              )
            ]),
      ),
    );
  }
}
