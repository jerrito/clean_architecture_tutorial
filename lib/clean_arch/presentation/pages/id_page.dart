import 'package:flutter/material.dart';

import '../../domain/use_cases/getTodo_byID.dart';

class IdPage extends StatefulWidget {
  const IdPage({super.key});

  @override
  State<IdPage> createState() => _IdPageState();
}

class _IdPageState extends State<IdPage> {
  final idController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          Center(
            child: SizedBox(
              width: 300,
              child: TextFormField(
                controller: idController,
                decoration: InputDecoration(


                    hintText: "Please enter id",
                    border: OutlineInputBorder(
                    ),

                ),
              ),
            ),
          ),
          SizedBox(height:20),
          SizedBox(
            width:300,
            child: OutlinedButton(onPressed: () {
      showModalBottomSheet(context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            builder: (context) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: FutureBuilder(
                      future: GetTodoById().
                      getById(context: context,
                          id: int.parse(idController.text)),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Center(child:Text("Nothing"));
                        }
                        return
                        Column(
                          children:[
                            SizedBox(height:50),
                            Text(snapshot.data!.title!,
                            style:TextStyle(
                              fontSize: 20
                            )),
                            Text(snapshot.data!.completed.toString()),
                            Text(snapshot.data!.userId.toString()),
                            Text(snapshot.data!.id.toString()),
                          ]
                        );
                            }),
                  );
                }
              );


            }, child: Text("Search id"),
            ),
          )
        ],
      ),
    );
  }
}
