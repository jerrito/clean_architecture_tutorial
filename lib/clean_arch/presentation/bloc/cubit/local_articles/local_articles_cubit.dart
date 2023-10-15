import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/articles.dart';
import '../../../../domain/repositories/database_repo.dart';

part 'local_articles_state.dart';

class LocalArticlesCubit extends Cubit<LocalArticlesState> {
  final DatabaseRepository _databaseRepository;
  LocalArticlesCubit(this._databaseRepository) :
        super(const LocalArticlesLoading());

  Future<void> getAllSavedArticles() async{
    emit(await getAllSaveArticles());
  }


  Future<void> removeSaveArticle({required Article article})async {
    await _databaseRepository.deleteArticle(article);
    emit(await getAllSaveArticles());
  }

  Future<void>  saveArticle({required Article article}) async{
    await _databaseRepository.saveArticle(article);
    emit(await getAllSaveArticles());
  }

  Future<LocalArticlesState>  getAllSaveArticles()async{

    final articles=await _databaseRepository.getArticles();
    return LocalArticleSuccess(articles: articles);
  }
}
