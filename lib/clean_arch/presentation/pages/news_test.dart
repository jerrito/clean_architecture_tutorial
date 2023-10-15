import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants.dart';
import '../../domain/entities/articles.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/response/breaking_news_res.dart';
class ArticleScreen extends StatefulWidget{
 const ArticleScreen({super.key});

  @override
State<ArticleScreen>  createState()=>_ArticleScreen();

}

class _ArticleScreen extends State<ArticleScreen>{

  Future<List> getArticle()async{
    List all;
    try{

      const url=Constants.baseUrl;
      const apiKey=Constants.apiKey;
      Map<String, String> headers = {'Content-Type': 'application/json'};
      http.Response res= await http.get(
          Uri.parse(
        "$url/top-headlines?country=us&category=business&apiKey=$apiKey"
      ),headers: headers
      );
      if(res.statusCode==200){
       //data = const Articles().toJsonList(res.body);
      var jsonRes=jsonDecode(res.body);
      //print(jsonRes);
      var data=jsonRes["articles"];
     //print(res.body);
     //print(jsonDecode(res.body));
     print(data);
      //all=Articles().toJsonList(data);
     //print(all);
        return data;
      }

    }catch(e){
      print(e.toString());
    }

    throw Exception("");

  }

  @override
  Widget build(BuildContext context ){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daily News",
          style: TextStyle(color:Colors.black),
        ),
      ),
      body: FutureBuilder(
        future:getArticle(),
          builder: (context, snapshot){
            if(snapshot.connectionState==
                ConnectionState.waiting){
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.length,
                itemBuilder:(context,index){
                //print(snapshot.data?.totalResults);
                print(snapshot.data?.length);
                  var data=snapshot.data?[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: Image.network(
                          data["urlToImage"]==null?
                          "":data["urlToImage"]
                      ).image ,
                    ),
                    title:Text(data["title"]==null?
                         "":data["title"]!),
                        subtitle: Column(
                      children:[
                        Text(data["content"]==null?
                        "":data["content"]! )
                      ]
                  ),
                  );
                });
          }),
    );
  }
}