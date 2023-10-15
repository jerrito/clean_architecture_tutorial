import 'package:floor/floor.dart';

import '../../../../../core/constants.dart';
import '../../../../domain/entities/articles.dart';

@dao
abstract class ArticleDao{

  @Query("SELECT * FROM ${Constants.articleTableName}")
  Future<List<Article>> getArticles();

  @Insert(onConflict:OnConflictStrategy.replace)
  Future<void> insertArticle(Article article);

  @delete
  Future<void> deleteArticle(Article article);




}