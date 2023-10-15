
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:oktoast/oktoast.dart';

import '../../../res/i_font_res.dart';
import '../../domain/entities/articles.dart';
import '../bloc/cubit/local_articles/local_articles_cubit.dart';

class ArticleDetail extends HookWidget{
  final Article article;
  const ArticleDetail({Key? key, required this.article})
      :super(key: key);


  @override
  Widget build(BuildContext context) {
    final localArticleCubit=
    BlocProvider.of<LocalArticlesCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(
            Ionicons.chevron_back,color:Colors.black
          ),
        ),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children:[
            _buildArticleTitleAndDate(),
            _buildImage(),
            _buildArticleDescription()

          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          localArticleCubit.saveArticle(article: article);
          showToast("Article Saved");
        },
        child:const Icon(
          Ionicons.bookmark, color:Colors.white
        )
      ),

    );

  }

  Widget _buildArticleTitleAndDate(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(article.title ?? "",
          style:const TextStyle(
            fontFamily: FontRes.BUTLER_REGULAR,
            fontWeight: FontWeight.w900,
            fontSize:20
          )),
          const SizedBox(height:14),
          Row(
            children:[
              const Icon(Ionicons.time_outline,size: 16,),
              const SizedBox(height: 4),
              Text(article.publishedAt ?? "",
              style:const TextStyle(fontSize: 12))
            ]
          ),
        ],
      ) ,);
  }

  Widget _buildImage(){
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: EdgeInsets.only(top:14),
      child: Image.network(
        article.urlToImage ?? '',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        errorBuilder: (_,__,___){
          return const Center(
          child:Text("404\nNot Found"));
      },
      ),
    );
  }
  Widget _buildArticleDescription(){
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 14,vertical: 18),
    child: Text('${article.description}\n\n'
        '${article.content}',style: const TextStyle(
      fontSize: 14
    ),),);
  }
}