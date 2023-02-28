import 'package:busca_de_desaparecidos/models/models.dart';
import 'package:busca_de_desaparecidos/ui/components/components.dart';
import 'package:busca_de_desaparecidos/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardHome extends StatelessWidget {
  final List<Person> list;

  const CardHome({required this.list, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.only(top: 5, left: 5, right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.white54),
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Photo(
                      linkImage:
                          list[index].urlPhoto ?? 'images/blank_profile.png',
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.32,
                      boxfit: BoxFit.cover,
                      rounded: false,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextView(
                        title: 'Nome: ',
                        content: '\n${list[index].name}',
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        textColor: Colors.black,
                      ),
                      TextView(
                        title: 'Idade: ',
                        content: '\n${list[index].age}',
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        textColor: Colors.black,
                      ),
                      TextView(
                        title: 'Desaparecimento: ',
                        content:
                            '\n${DateFormat('dd/MM/yyyy').format(list[index].dateDisappear)}',
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        textColor: Colors.black,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(person: list[index]),
              ),
            );
          },
        );
      },
    );
  }
}
