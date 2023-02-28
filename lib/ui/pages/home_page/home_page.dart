import 'dart:convert';

import 'package:busca_de_desaparecidos/datasources/remote/remote.dart';
import 'package:busca_de_desaparecidos/models/models.dart';
import 'package:busca_de_desaparecidos/ui/pages/home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _actualPage = 0;
  int? _totalPages;

  final formKey = GlobalKey<FormState>();
  final _maxAgeController = TextEditingController();
  final _minAgeController = TextEditingController();
  final _nameController = TextEditingController();
  final _sexSelectController = TextEditingController();
  final List _data = json.decode('[{"sex": "Todos", "view": "Todos"},{"sex": "MASCULINO", "view": "Masculino"},{"sex": "FEMININO", "view": "Feminino"}]');

  Future getTotalPages({required String url}) async {
    _totalPages = await PagesRemote().getTotalPages(url: url);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTotalPages(
      url: PersonRemote().buildURL(
          page: _actualPage,
          minAge: _minAgeController.text,
          maxAge: _maxAgeController.text,
          name: _nameController.text,
          sex: _sexSelectController.text),
    );
    _actualPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Desaparecidos',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => Filter(
                    maxAgeController: _maxAgeController,
                    minAgeController: _minAgeController,
                    nameController: _nameController,
                    sexSelectController: _sexSelectController,
                    data: _data),
              );
              if (_maxAgeController.text.isNotEmpty ||
                  _minAgeController.text.isNotEmpty ||
                  _nameController.text.isNotEmpty ||
                  _sexSelectController.text.isNotEmpty) {
                _actualPage = 0;

                getTotalPages(
                  url: PersonRemote().buildURL(
                      page: _actualPage,
                      minAge: _minAgeController.text,
                      maxAge: _maxAgeController.text,
                      name: _nameController.text,
                      sex: _sexSelectController.text),
                );
              }
            },
            icon: Icon(
              Icons.filter_alt_outlined,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: PersonRemote().get(
                url: PersonRemote().buildURL(
                    page: _actualPage,
                    minAge: _minAgeController.text,
                    maxAge: _maxAgeController.text,
                    name: _nameController.text,
                    sex: _sexSelectController.text),
              ),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return GestureDetector(
                        child: Text(
                          'Erro ao Acessar a API (${snapshot.error.toString()})',
                        ),
                        onTap: () {
                          setState(() {});
                        },
                      );
                    } else {
                      return CardHome(list: snapshot.data as List<Person>);
                    }
                }
              },
            ),
          ),
          Container(
            color: Colors.white10,
            height: 45,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: IconButton(
                    onPressed: () {
                      if (_actualPage > 0) {
                        setState(() {
                          _actualPage--;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: _totalPages != null,
                    child: Container(
                      child: Center(
                        child: Text(
                          '${_actualPage + 1}...$_totalPages',
                          style: GoogleFonts.oxanium(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 5,
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (_actualPage + 1 < _totalPages!) {
                        setState(() {
                          _actualPage++;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
