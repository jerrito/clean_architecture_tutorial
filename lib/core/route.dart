import 'package:clean_tutorial/clean_arch/domain/entities/response/breaking_news_res.dart';
import 'package:go_router/go_router.dart';
import '../clean_arch/presentation/pages/article_details.dart';
import '../clean_arch/presentation/pages/breaking_news_view.dart';
import '../clean_arch/presentation/pages/id_page.dart';
import '../clean_arch/presentation/pages/news_test.dart';
import '../clean_arch/presentation/pages/saved_articles.dart';
import '../main.dart';
final goRouter=GoRouter(

    routes:<RouteBase>[
      GoRoute(path: "/",
      builder: ( context, state)=>
        const MyHomePage(title: 'Flutter Demo Home Page'),
          routes:<RouteBase>[
            GoRoute(path: "idPage",
      builder: (context,state)=>
      const IdPage()),
            GoRoute(path: "articles",
            builder: (context,state)=>
            const BreakingNewsView()),
      GoRoute(path: "testArticle",
      builder: (context,state)=>
      const ArticleScreen()),
      GoRoute(path: "savedArticles",
      builder:(context,state)=>
      const SavedArticles())



          ] ),
    ] );