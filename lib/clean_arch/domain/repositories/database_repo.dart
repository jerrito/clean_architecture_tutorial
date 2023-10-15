
import '../entities/articles.dart';

abstract class DatabaseRepository{

  Future<List<Article>>  getArticles();

  Future<void> saveArticle(Article article);

  Future<void> deleteArticle(Article article);

}