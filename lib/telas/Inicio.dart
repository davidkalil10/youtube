import 'package:flutter/material.dart';
import 'package:youtube/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../Api.dart';

class Inicio extends StatefulWidget {

  String pesquisa;

  Inicio(this.pesquisa); //receber o valor da tela home

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _ListarVideos( String pesquisa){

    Api api = Api();
    return api.pesquisar(pesquisa); //passa o valor de pesquisa para o filtro da api
  }

  @override
  void initState() { //carregar dado que queira usar so 1 vez
    super.initState();
    print("chamado 1");
  }

  @override
  void didChangeDependencies() { //para construir a interface precisa de dependencias
    super.didChangeDependencies();
    print("chamado 2");
  }

  @override
  void didUpdateWidget(Inicio oldWidget) { //atualiza o widget
    print("chamado 2.1");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() { //descarte de itens que vc nao quer mais
    print("chamado 4");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("chamado 3");



    return FutureBuilder<List<Video>>(
      future: _ListarVideos(widget.pesquisa),//valor passado para o metodo da api realizar o filtro
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center (
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData){

              return ListView.separated(
                  itemBuilder: (context, index){

                    List<Video> videos = snapshot.data;
                    Video video = videos[index];

                    return GestureDetector(
                      onTap: (){
                        FlutterYoutube.playYoutubeVideoById(
                            apiKey: CHAVE_YOUTUBE_API,
                            videoId: video.id,
                          autoPlay: true,
                          fullScreen: true
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover, // preencher a imagem com todo o tamanho do container
                                    image: NetworkImage(video.imagem) // por no fundo do container uma imagem por url de texto
                                )
                            ),
                          ),
                          ListTile(
                            title: Text(video.titulo),
                            subtitle: Text(video.canal),
                          )
                        ],
                      ),
                    ) ;
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 2,
                    color: Colors.grey ,
                  ),
                  itemCount: snapshot.data.length
              );

            }else{
              return Center (
                child: Text("Nenhum dado a ser exibido"),
              );
            }
            break;
        }
      },

    );
  }
}
