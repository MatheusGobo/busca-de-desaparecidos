import 'package:busca_de_desaparecidos/app_theme.dart';
import 'package:busca_de_desaparecidos/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Filter extends StatelessWidget {
  final TextEditingController maxAgeController;
  final TextEditingController minAgeController;
  final TextEditingController nameController;
  final TextEditingController sexSelectController;
  final List data;
  const Filter({required this.maxAgeController, required this.minAgeController, required this.nameController, required this.sexSelectController, required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? _sexSelect;

    if (sexSelectController.text.isNotEmpty) {
      _sexSelect = sexSelectController.text;
    }

    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text('Filtros',
            style: GoogleFonts.oxanium(),
            textAlign: TextAlign.center),
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextInputApp(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10),
                      controller: minAgeController,
                      keyboardType:
                      const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: false),
                      labelText: 'Faixa de Idade Inicial',
                      readOnly: false,
                      mask: [
                        MaskTextInputFormatter(
                            mask: '###',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType
                                .lazy),
                      ],
                    ),
                    TextInputApp(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10),
                      controller: maxAgeController,
                      keyboardType:
                      const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: false),
                      labelText: 'Faixa de Idade Final',
                      readOnly: false,
                      mask: [
                        MaskTextInputFormatter(
                            mask: '###',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType
                                .lazy),
                      ],
                    ),
                    TextInputApp(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10),
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      labelText: 'Nome',
                      readOnly: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Sexo',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: ThemeClass.secondColor,
                            ),
                          ),
                          fillColor: Colors.white,
                        ),
                        child: SizedBox(
                          height: 25,
                          child: DropdownButton(
                            enableFeedback: true,
                            borderRadius:
                            BorderRadius.circular(18),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            focusColor:
                            ThemeClass.primaryColor,
                            dropdownColor:
                            ThemeClass.secondColor,
                            isExpanded: true,
                            hint: const Text('Sexo'),
                            underline: Container(),
                            items: data.map((sex) {
                              return DropdownMenuItem(
                                value: sex['sex'],
                                child: Text(
                                  sex['view'],
                                  style:
                                  GoogleFonts.oxanium(),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _sexSelect =
                                    value.toString();
                                sexSelectController.text = _sexSelect!;
                              });
                            },
                            value: _sexSelect,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    color: ThemeClass.thirdColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  child: Text(
                    "Filtrar",
                    style: GoogleFonts.oxanium(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
