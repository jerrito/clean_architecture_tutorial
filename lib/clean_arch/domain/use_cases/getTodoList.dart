import 'dart:convert';

import 'package:clean_tutorial/clean_arch/data/repositories/todoapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/http_error_handle.dart';
import '../../../core/show_snack.dart';
import '../entities/TodoModel.dart';

class GetTodoList{

  Future<List<TodoModel>?> getTodoList(
      BuildContext context)async{
    List<TodoModel> all=[];
    try{

    String url=Api.api;
    http.Response res=await http.get(
      Uri.parse(url)
    );
    httpErrorHandle(
        onSuccess:() {
          //print("Hello");
          all.addAll(
                TodoModel().toJsonList(res.body));
          showSnack(context, "Successful fetching");
          },
        context: context, response:res);

    }
    catch(e){
      print(e.toString());
        }

        return all;
  }
}