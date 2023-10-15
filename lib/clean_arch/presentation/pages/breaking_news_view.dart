import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../domain/entities/articles.dart';
import '../bloc/cubit/remote_articles_cubit.dart';
import '../widgets/article_widget.dart';
import 'package:clean_tutorial/core/scroll.dart';

import 'article_details.dart';

class BreakingNewsView extends HookWidget{
  const BreakingNewsView({super.key});


  @override
 Widget build(BuildContext context){

    final remoteArticleCubit=
    BlocProvider.of<RemoteArticlesCubit>(context);
    final scrollController=useScrollController();
    useEffect(() {
      scrollController.onScrollEndsListener((){
        remoteArticleCubit.getBreakingNewsArticles();
      });
      return scrollController.dispose;
    }, const []);
   return  Scaffold(
     appBar: AppBar(
       title: const Text("Daily News",
       style:TextStyle(
         color: Colors.black
       )),


     ),
     body: BlocBuilder<RemoteArticlesCubit,RemoteArticlesState>(
       builder: (_ ,state){
         switch(state.runtimeType){
           case RemoteArticlesLoading:
             print(state.articles.length);
             return const Center(
               child: CupertinoActivityIndicator(),
             );
           case RemoteArticlesFailed:
             return const Center(child: Icon(Ionicons.refresh));
           case RemoteArticlesSuccess:
             return _buildArticles(
                 scrollController,
                 state.noMoreData,
                 state.articles);
           default :
             return const SizedBox();
         }
       },
     ),
   );
 }
 Widget _buildArticles(
     ScrollController controller,
     bool noMoreData,
     List<Article> articles
     ){
    return (
    CustomScrollView(
      controller: controller,
      slivers: [
        SliverList(
           delegate: SliverChildBuilderDelegate(
               (context,index)=>ArticleWidget(
                 article:articles[index],
        onArticlePressed: (article)=>
        Navigator.push(context, PageRouteBuilder(
            pageBuilder: (_,__,___) {
              return ArticleDetail(article: article,);
            }))),
             childCount: articles.length
           ),
        ),
        if(!noMoreData)
          const SliverToBoxAdapter(
            child:Padding(
                padding: EdgeInsets.only(top:14,bottom: 32),
            child: CupertinoActivityIndicator(),)
          )

      ],
    )
    );
 }
}