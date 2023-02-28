import 'package:busca_de_desaparecidos/constants.dart';
import 'package:busca_de_desaparecidos/models/models.dart';
import 'package:busca_de_desaparecidos/ui/components/components.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PersonRemote {
  /**
   * Realiza a busca na API, Get (v1/pessoas/aberto/filtro)
   **/
  Future<List<Person>> get({required String url}) async {
    var response = await http.get(Uri.parse(url));
    var data = json.decode(utf8.decode(response.bodyBytes))['content']
    as List<dynamic>;
    return data.map((e) => Person.fromMap(e)).toList();
  }

  /**
   * Monta a URL para buscar na API as informações
   * **/
  String buildURL({required int page,
    required String minAge,
    required String maxAge,
    required String name,
    required String sex}) {
    String filters = linkApi + 'filtro?pagina=$page&porPagina=15';

    if (minAge.isNotEmpty) {
      filters = '$filters&faixaIdadeInicial=$minAge';
    }
    if (maxAge.isNotEmpty) {
      filters = '$filters&faixaIdadeFinal=$maxAge';
    }
    if (name.isNotEmpty) {
      filters = '$filters&nome=$name';
    }
    if (sex.isNotEmpty) {
      filters = '$filters&sexo=$sex';
    }

    return filters;
  }

  Future<int> sentInformations({required int occurrenceId, required String information, required DateTime date, String? fileDescription, PlatformFile? file}) async {
    var request = http.MultipartRequest('POST', Uri.parse(linkApiSentInformations));

    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['data'] = SelectDate().formatTextDate(date: date, typeFormat: 2);
    if (fileDescription!.isNotEmpty) {
      request.fields['descricao'] = fileDescription;
    }

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath("file", file.path!));
    }

    request.fields['informacao'] = information;
    request.fields['ocoId'] = occurrenceId.toString();

    var response = await request.send();

    return response.statusCode;
  }
}
