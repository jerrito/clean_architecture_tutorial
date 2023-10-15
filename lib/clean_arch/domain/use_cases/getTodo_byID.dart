import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/http_error_handle.dart';
import '../../../core/show_snack.dart';
import '../../data/repositories/todoapi.dart';
import '../entities/TodoModel.dart';

class GetTodoById{

  Future<TodoModel> getById({
  required BuildContext context,
   required int id
  })async{
    var data;

    try {
      String url = Api.api;

      http.Response response = await http.get(
          Uri.parse("$url/$id"));

      httpErrorHandle(
          context: context,
          response: response,
          onSuccess: () {
            data = TodoModel.fromMap(jsonDecode(
                response.body));
            print("Done");
            showSnack(context,
                "Success");
          });
    }catch(e){
      print(e.toString());
    }
    return data;

  }

}