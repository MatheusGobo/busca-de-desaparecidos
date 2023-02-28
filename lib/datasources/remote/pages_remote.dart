import 'package:busca_de_desaparecidos/constants.dart';
import 'package:busca_de_desaparecidos/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PagesRemote {
  /**
   * Realiza a busca na API, Get (v1/pessoas/aberto/filtro)
   **/
  Future<int> getTotalPages({required String url}) async {
    //String url = linkApi+'filtro?pagina=0&porPagina=15';
    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body)['totalPages'] as dynamic;
    return data;
  }

}