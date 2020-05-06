import 'package:flutter/material.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inicio.dart';
import 'package:youtube/telas/Inscricao.dart';

import 'CustomSearchDelegate.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual =0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {



    List<Widget> telas =[
      Inicio(_resultado), //passar o valor pra tela de inicio
      EmAlta(),
      Inscricao(),
      Biblioteca()

    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1 //de 0 a 1, menor mais transparente
        ),//cor padrao pros icones
        backgroundColor: Colors.white,
        title: Image.asset(
            "images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: <Widget>[//botoes de ação
          IconButton( //icone de botao
            icon: Icon(Icons.search),
            onPressed: () async{
              String res = await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate()); //recupera a query que foi digitada e salva em res
              setState(() {
                _resultado = res; //pega o res da barra de pesquisa e salva ele em resultado
              });
            },
          ),

          /*
          IconButton( //icone de botao
            icon: Icon(Icons.videocam),
            onPressed: (){
              print("ação video cam");
            },
          ),
          IconButton( //icone de botao
            icon: Icon(Icons.account_circle),
            onPressed: (){
              print("ação usuario");
            },
          )
          */

        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual, //icone inicial clicado
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed, //ATE TRES ITENS VEM FIXED DPS VEM SHIFTING
        fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(
             // backgroundColor: Colors.orange,
              title: Text("Início"),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
             // backgroundColor: Colors.red,
              title: Text("Em alta"),
              icon: Icon(Icons.whatshot)
            ),
            BottomNavigationBarItem(
             // backgroundColor: Colors.blue,
              title: Text("Inscrições"),
              icon: Icon(Icons.subscriptions)
            ),
            BottomNavigationBarItem(
            //  backgroundColor: Colors.green,
              title: Text("Biblioteca"),
              icon: Icon(Icons.folder)
            ),

          ]
      ),
    );
  }
}
