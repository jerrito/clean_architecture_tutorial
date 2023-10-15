import 'package:clean_tutorial/core/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void httpErrorHandle({
  required BuildContext context ,
    required http.Response response,
  required VoidCallback  onSuccess}){

  switch(response.statusCode){
    case 200:
      //print("200");
      onSuccess();
      break;
    case 400:
      //print("400");
      showSnack( context,
      response.body);
      break;
    case 500:
     // print("500");
      showSnack(context,
          response.body);
      break;
    default :
      print("default");
      showSnack(context,
      response.body);

  }



}


