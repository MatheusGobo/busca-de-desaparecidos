import 'dart:typed_data';

import 'package:busca_de_desaparecidos/app_theme.dart';
import 'package:busca_de_desaparecidos/models/models.dart';
import 'package:busca_de_desaparecidos/ui/components/components.dart';
import 'package:busca_de_desaparecidos/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widget_to_image/widget_to_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_save/image_save.dart';

class DetailsPage extends StatefulWidget {
  final Person person;

  const DetailsPage({required this.person, Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ByteData? _byteData;
  GlobalKey key1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              await _callRepaintBoundaryToImage();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepaintBoundary(
              key: key1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: SizedBox(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Container(
                        color: widget.person.dateFound == null
                            ? Colors.red
                            : Colors.green,
                        child: Center(
                          child: Text(
                            widget.person.dateFound == null
                                ? 'Desaparecido a ${DateTime.now().difference(widget.person.dateDisappear).inDays} dias'
                                : 'Encontrado',
                            style: GoogleFonts.oxanium(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Photo(
                        linkImage: widget.person.urlPhoto ??
                            'images/blank_profile.png',
                        boxfit: BoxFit.fitWidth,
                        width: MediaQuery.of(context).size.width * 0.9,
                        rounded: false,
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      color: Colors.black54,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              widget.person.name,
                              style: GoogleFonts.oxanium(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  TextView(
                                    title: 'Desapareceu: ',
                                    content:
                                        'No dia ${DateFormat('dd/MM/yyyy').format(widget.person.dateDisappear)}',
                                    padding: EdgeInsets.only(left: 8),
                                    textColor: Colors.white,
                                    titleSize: 16,
                                    contentSize: 14,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      TextView(
                                        title: 'Sexo: ',
                                        content: '${widget.person.sex}',
                                        padding: EdgeInsets.only(left: 8),
                                        textColor: Colors.white,
                                        titleSize: 16,
                                        contentSize: 14,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      TextView(
                                        title: 'Idade: ',
                                        content: '${widget.person.age} anos',
                                        padding: EdgeInsets.only(left: 8),
                                        textColor: Colors.white,
                                        titleSize: 16,
                                        contentSize: 14,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  TextView(
                                    title: 'Local do Desaparecimento: ',
                                    content:
                                        '"${widget.person.placeDisappear}"',
                                    padding: EdgeInsets.only(left: 8),
                                    textColor: Colors.white,
                                    titleSize: 16,
                                    contentSize: 14,
                                  ),
                                  Visibility(
                                    visible:
                                        widget.person.infoOccurrence != null,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        TextView(
                                          title: 'Informações: ',
                                          content:
                                              '"${widget.person.infoOccurrence}"',
                                          padding: EdgeInsets.only(left: 8),
                                          textColor: Colors.white,
                                          titleSize: 16,
                                          contentSize: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.person.infoClothing != null,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        TextView(
                                          title: 'Vestimenta: ',
                                          content:
                                              '"${widget.person.infoClothing}"',
                                          padding: EdgeInsets.only(left: 8),
                                          textColor: Colors.white,
                                          titleSize: 16,
                                          contentSize: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black87,
                        primary: ThemeClass.secondColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(22),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SharePage(person: widget.person),
                          ),
                        );
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Text(
                          'Enviar Informações',
                          style: GoogleFonts.oxanium(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _callRepaintBoundaryToImage() async {
    Uint8List _data;
    var dir =
        (await getExternalStorageDirectory())!.path + '/Pictures/image.jpg';
    ByteData byteData = await WidgetToImage.repaintBoundaryToImage(this.key1);
    final buffer = byteData.buffer;
    _data = await buffer.asUint8List(
        byteData.offsetInBytes, byteData.lengthInBytes);

    await ImageSave.saveImageToSandbox(_data, "image.jpg");

    Share.shareFiles([dir], mimeTypes: ['image/*']);
  }
}
