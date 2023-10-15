
import '../../../core/data_state.dart';
import '../entities/request/breaking_news_req.dart';
import '../entities/response/breaking_news_res.dart';

abstract class ApiRepository {

  Future<DataState<BreakingNewsResponse>> getBreakingNewsArticles({

    required BreakingNewsRequest request
  });
}