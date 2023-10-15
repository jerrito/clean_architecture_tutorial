import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../domain/entities/articles.dart';
import '../bloc/cubit/local_articles/local_articles_cubit.dart';
import '../widgets/article_widget.dart';
import 'article_details.dart';
class SavedArticles extends HookWidget{
  const SavedArticles({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        leading: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child:  Icon(
            Ionicons.chevron_back,color:Colors.black
        ),
      ),
        title:Text("Saved Articles",
        style:TextStyle(color:Colors.black))
    ),
      body:BlocBuilder<LocalArticlesCubit,LocalArticlesState>(
        builder:(_,state){
         switch(state.runtimeType){
           case LocalArticlesLoading:
              return const Center(
          child:CupertinoActivityIndicator(

          )
          );
           case LocalArticleSuccess:
             return _buildArticleS(state.articles);

          default:
            return const SizedBox();
          }
        }
      )


    );
  }
  Widget _buildArticleS(List<Article> articles){
    if(articles.isEmpty) {
      return const Text("No Saved Articles");
    }
    return ListView.builder(
      itemCount: articles.length,
        itemBuilder: (context,index){
          return ArticleWidget(
            article: articles[index],
            isRemovable: true,
            onRemove:(articles) =>BlocProvider.of<LocalArticlesCubit>
              (context).removeSaveArticle(article: articles),
            onArticlePressed: (article)=>
            Navigator.push(context, PageRouteBuilder(
                pageBuilder: (_,__,___){
                  return ArticleDetail(article: article,);
                })),

          );
        });

  }
}