import 'dart:io';

import 'package:busca_de_desaparecidos/datasources/remote/remote.dart';
import 'package:busca_de_desaparecidos/models/models.dart';
import 'package:busca_de_desaparecidos/ui/components/components.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SharePage extends StatefulWidget {
  final Person person;

  const SharePage({required this.person, Key? key}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  DateTime _selectedDate = DateTime.now();
  final _ocorrenciaController = TextEditingController();
  final _infoController = TextEditingController();
  final _dateController = TextEditingController();
  final _fileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PlatformFile? _file;
  bool _showProgress = false;

  @override
  void initState() {
    super.initState();
    _ocorrenciaController.text = widget.person.occurrenceId.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Enviar Informações',
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextInputApp(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      controller: _dateController,
                      labelText: 'Data',
                      keyboardType: TextInputType.none,
                      mask: [
                        MaskTextInputFormatter(
                          mask: '##/##/####',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy,
                        ),
                      ],
                      readOnly: true,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Campo data é obrigatório.'
                            : null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month_outlined),
                    onPressed: () async {
                      await SelectDate()
                          .selectDate(
                              context: context, actualDate: _selectedDate)
                          .then(
                        (value) {
                          setState(() {
                            _selectedDate = value!;
                            _dateController.text = SelectDate().formatTextDate(
                              date: _selectedDate,
                              typeFormat: 1,
                            );
                          });
                        },
                      );
                    },
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                  ),
                ],
              ),
              TextInputApp(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                controller: _infoController,
                keyboardType: TextInputType.text,
                labelText: 'Informações',
                readOnly: false,
                maxLines: 10,
                validator: (value) {
                  return value!.isEmpty
                      ? 'Campo informações é obrigatório.'
                      : null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextInputApp(
                      padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 10),
                      controller: _fileController,
                      keyboardType: TextInputType.text,
                      labelText: 'Descrição do Anexo',
                      readOnly: false,
                    ),
                  ),
                  Center(
                    child: IconButton(
                      icon: const Icon(
                        IconData(0xf732,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage),
                      ),
                      onPressed: () async{
                        _file = await PickerFile().selectFile();

                        _fileController.text = '';
                        _fileController.text = _file!.name;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(8),
                        onPrimary: Colors.black87,
                        primary: HexColor('#029E02'),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(22),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _sendInformations();
                      },
                      child: Padding(
                        padding:EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Text(
                          'Enviar',
                          style: GoogleFonts.oxanium(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      )),
                ),
              ),
              Visibility(
                visible: _showProgress,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ));
  }

  void _sendInformations() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showProgress = true;
      });
      int responseCode = await PersonRemote().sentInformations(
          occurrenceId: widget.person.occurrenceId,
          information: _infoController.text,
          date: _selectedDate,
          file: _file,
          fileDescription: _fileController.text);

      setState(() {
        _showProgress = false;
      });

      if (responseCode >= 200 && responseCode <= 299) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: '',
          text: 'Informações enviadas com sucesso',
        );

        _file = null;
        _fileController.text = '';
        _selectedDate = DateTime.now();
        _dateController.text = '';
        _infoController.text = '';
      } else if (responseCode >= 400 && responseCode <= 599) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: '',
          text: 'Erro ao enviar as informações. Tente novamente mais tarde.',
        );
      }
    }
  }
}
