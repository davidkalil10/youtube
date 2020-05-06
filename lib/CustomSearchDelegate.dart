import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = "";
          }
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return
      IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            close(context, "");
          }
      );

  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query); //query é o que foi digitado
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //print("resultado: digitado " + query);

    return Container();

    /*
    List<String> lista = List();

    if (query.isNotEmpty){
      lista =[
        "Android", "Android navegação", "IOs", "jogos"
      ].where( //.where para checar o texto da query
          (textoApesquisar) => textoApesquisar.toLowerCase().startsWith(query.toLowerCase()) //converte a lista e a entrada para minusculo para comparar, mas apresenta os valores reais
      ).toList();

      return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index){

            return ListTile(
              onTap: (){
                close(context, lista[index]); //usuario fecha a tela
              },
              title: Text(lista[index]),
            );

          }
      );

    }else {

      return Center(
          child: Text("Nenhum resultado para a pesquisa"),
      );
    }
    */



  }



}