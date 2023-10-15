import 'dart:convert';
class TodoModel{

  int? userId;
  int? id;
 String? title;
 bool? completed;
 TodoModel({this.userId,this.id,this.completed,this.title});

 Map<String,dynamic> toMap(){
   return {
     "userId":userId,
     "title":title,
     "completed":completed,
     "id":id,
   };
 }

 factory TodoModel.fromMap(Map<dynamic,dynamic>? map){
   return TodoModel(
   completed:map?["completed"],
   title:map?["title"],
   userId:map?["userId"],
  id:map?["id"]
   );

  }
  String toJson(String source)=>
  TodoModel().toJson(json.decode(source));
 List<TodoModel>  toJsonList(String source)=>
      List<TodoModel>.from(json.decode(source).map((x)=>TodoModel.fromMap(x)));

  //         List<UserModel> userModelFromJson(String str) =>
  // List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));
  //
  // String userModelToJson(List<UserModel> data) =>
  // json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

}