import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyAdRBqnBi328WI14F99E-mQoVvczQi11TI";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api{

  Future<List<Video>> pesquisar(String pesquisa) async{

    http.Response response = await http.get(

      URL_BASE + "search"
          "?part=snippet"
          "&type=video"
          "&maxResults=20"
          "&order=date"
          "&key=$CHAVE_YOUTUBE_API"
          "&channelId=$ID_CANAL"
          "&q=$pesquisa"
    );

    if (response.statusCode == 200 ){
      
     Map<String, dynamic> dadosJson = json.decode(response.body);

     List<Video> videos = dadosJson["items"].map<Video>(
         (map){
           
           return Video.fromJson(map );
          // return Video.converterJson(map );
         }
     ).toList();

     return videos;

     /*
     for (var video in videos){
       print("Resultado: " + video.titulo);
     }
     */


     /*
     //percorrer resultado Json para armazenar no objeto tipo video

      for ( var video in dadosJson["items"]){
        print("Resultado: "+ video.toString());

      }
      */





    // print("Resultado: " + dadosJson["items"][0]["id"]["videoId"].toString()); //recuperar itens de dentro de cada chave
    // print("Resultado: " + dadosJson["items"][2]["snippet"]["title"].toString());


      
    }else{
      
    }

  }

}