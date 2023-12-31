part of 'local_articles_cubit.dart';

abstract class LocalArticlesState extends Equatable {
  final List<Article> articles;
  const LocalArticlesState({this.articles=const []});

  @override
  List<Object> get props => [articles];
}

class LocalArticlesLoading extends LocalArticlesState{
 const LocalArticlesLoading();
}

class LocalArticleSuccess extends LocalArticlesState{
  const LocalArticleSuccess({super.articles});

}