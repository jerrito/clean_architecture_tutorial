
import 'package:clean_tutorial/clean_arch/domain/entities/articles.dart';

import '../../domain/repositories/database_repo.dart';
import '../data_sources/local/appDatabase.dart';

class DatabaseRepositoryImplementation implements DatabaseRepository{
 final AppDatabase _appDatabase;
 DatabaseRepositoryImplementation(this._appDatabase);

  @override
  Future<void> deleteArticle(Article article) {
    return _appDatabase.articleDao.deleteArticle(article);
  }

  @override
  Future<List<Article>> getArticles() {
   return _appDatabase.articleDao.getArticles();

  }

  @override
  Future<void> saveArticle(Article article) async{
    return _appDatabase.articleDao.insertArticle(article);

  }
  
}