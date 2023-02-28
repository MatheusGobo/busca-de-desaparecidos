import 'dart:convert';

class Person {
  int      id;
  String    name;
  int       age;
  String    sex;
  bool      alive;
  String?   urlPhoto;
  DateTime  dateDisappear;
  DateTime? dateFound;
  bool      foundAlive;
  String    placeDisappear;
  String?   infoOccurrence;
  String?   infoClothing;
  String?   poster;
  int       occurrenceId;

  Person({required this.id, required this.name, required this.age, required this.sex, required this.alive, this.urlPhoto,
          required this.dateDisappear, this.dateFound, required this.foundAlive, required this.placeDisappear,
          this.infoOccurrence, this.infoClothing, this.poster, required this.occurrenceId});

  factory Person.fromMap(Map<String, dynamic> map) {
    /*print('fromJson id: '+map['id'].toString() +
    ', name: '+map['nome'] +
       ', age: '+map['idade'].toString()+
        ', sex: '+map['sexo']+
        ', urlPhoto: '+map['urlFoto']);*/
/*
    print(/*'id: '+map['id'].toString() +
          '\n name: '+map['nome']+
          '\n age: '+map['idade'].toString()+
          '\n sex: '+map['sexo']+
          '\n alive: '+map['vivo'].toString()+
          '\n urlPhoto: '+ map['urlFoto'].toString()+
          ' dateDisappear: '+map['ultimaOcorrencia']['dtDesaparecimento']+
          ' dateFound: '+map['ultimaOcorrencia']['dataLocalizacao'].toString()+
          ' foundAlive: '+map['ultimaOcorrencia']['encontradoVivo'].toString()+*/
          ' placeDisappear: '+utf8.decode(map['ultimaOcorrencia']['localDesaparecimentoConcat'] as List<int>)/*+
          ' infoOccurrence: '+map['ultimaOcorrencia']['ocorrenciaEntrevDesapDTO'].toString()+//['informacao'].toString()
          ' infoClothing: '+map['ultimaOcorrencia']['ocorrenciaEntrevDesapDTO'].toString()+//['vestimentasDesaparecido']+
          ' poster: '+map['ultimaOcorrencia']['listaCartaz'].toString()+
          ' occurrenceId: '+map['ultimaOcorrencia']['ocoId'].toString()+
          '\n teste: ' + map['ultimaOcorrencia'].toString()*/
          );*/
    /*
    * Aqui é pego o  valor do JSON retornado pela API
    * */
    return Person(
      id:             int.parse(map['id'].toString()),
      name:           map['nome'],
      age:            int.parse(map['idade'].toString()),
      sex:            map['sexo'],
      alive:          map['vivo'] as bool,
      urlPhoto:       map['urlFoto'] == null ? null : map['urlFoto'],
      dateDisappear:  DateTime.parse(map['ultimaOcorrencia']['dtDesaparecimento']),
      dateFound:      map['ultimaOcorrencia']['dataLocalizacao'] == null ? null : DateTime.tryParse(map['ultimaOcorrencia']['dataLocalizacao']),
      foundAlive:     map['ultimaOcorrencia']['encontradoVivo'] as bool,
      placeDisappear: map['ultimaOcorrencia']['localDesaparecimentoConcat'],
      infoOccurrence: map['ultimaOcorrencia']['ocorrenciaEntrevDesapDTO']== null? null : map['ultimaOcorrencia']['ocorrenciaEntrevDesapDTO']['informacao'] == null ? null : map['ultimaOcorrencia']['ocorrenciaEntrevDesapDTO']['informacao'],
      infoClothing:   map['ultimaOcorrencia']['ocorrenciaEntrevDesapDTO'] == null ? null : map['ultimaOcorrencia']['ocorrenciaEntrevDesapDTO']['vestimentasDesaparecido'] == null ? null : map['ultimaOcorrencia']['ocorrenciaEntrevDesapDTO']['vestimentasDesaparecido'],
      poster:         map['ultimaOcorrencia']['listaCartaz'] == null ? null : map['ultimaOcorrencia']['listaCartaz'],
      occurrenceId:   int.parse(map['ultimaOcorrencia']['ocoId'].toString()),
    );
  }
}