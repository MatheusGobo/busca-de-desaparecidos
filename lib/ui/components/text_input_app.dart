import 'package:busca_de_desaparecidos/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputApp extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? mask;
  final bool readOnly;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final TextAlign? textAlign;

  const TextInputApp({
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.mask,
    required this.readOnly,
    this.padding,
    this.maxLines,
    this.textAlign,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: TextFormField(
        style: GoogleFonts.oxanium(),
        maxLines: maxLines ?? 1,
        scrollPhysics: ScrollPhysics(),
        textAlign: textAlign ?? TextAlign.start,
        controller: controller,
        validator: validator ?? null,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ThemeClass.primaryColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: ThemeClass.secondColor,
            ),
          ),
          labelText: labelText,
          labelStyle: GoogleFonts.oxanium(
            color: Colors.white60,
          ),
          hintText: hintText ?? labelText,
          alignLabelWithHint: true,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
        inputFormatters: mask,
        readOnly: readOnly,
      ),
    );
  }
}
