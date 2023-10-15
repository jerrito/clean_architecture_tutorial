import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'clean_arch/domain/repositories/api_repo.dart';
import 'clean_arch/domain/repositories/database_repo.dart';
import 'clean_arch/domain/use_cases/getTodoList.dart';
import 'clean_arch/presentation/bloc/cubit/local_articles/local_articles_cubit.dart';
import 'clean_arch/presentation/bloc/cubit/remote_articles_cubit.dart';
import 'clean_arch/presentation/pages/id_page.dart';
import 'core/route.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import './core/locator.dart';
import 'core/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => RemoteArticlesCubit(
          locator<ApiRepository>(),
        )..getBreakingNewsArticles(),),
        BlocProvider(
          create: (context) =>
            LocalArticlesCubit(
              locator<DatabaseRepository>()
            )..getAllSaveArticles()
          ,)
      ],
      child: OKToast(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
          title: 'Flutter Demo',
          theme: AppThemeData.light,

          //onGenerateRoute: (settings)=>on,
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: GetTodoList().getTodoList(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text(""));
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }

            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data![index];
                  return ListTile(
                    title: Text(data.title!),
                    subtitle: Text(data.userId.toString()),
                  );
                });
          }
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            heroTag: "idPage",
              onPressed: () {
                context.go("/idPage");
              },
              child: Icon(Icons.arrow_forward_ios_sharp)
          ),
          FloatingActionButton(
              heroTag: "Testarticles",
              onPressed: () {
                context.go("/testArticle");
              },
              child: Icon(Icons.newspaper)
          ),

          FloatingActionButton(
            heroTag: "articles",
              onPressed: () {
                context.go("/articles");

              },
              child: Icon(Icons.newspaper_outlined)
          ),
          FloatingActionButton(
              heroTag: "articlesSaved",
              onPressed: () {
                context.go("/savedArticles");
              },
              child: Icon(Icons.save)
          ),


        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
