import '../../../core/data_state.dart';
import '../../domain/entities/request/breaking_news_req.dart';
import '../../domain/entities/response/breaking_news_res.dart';
import '../../domain/repositories/api_repo.dart';
import '../base/base_api_repo.dart';
import '../data_sources/remote/news_api_service.dart';


class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final NewsApiService _newsApiService;

  ApiRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<BreakingNewsResponse>> getBreakingNewsArticles({
    required BreakingNewsRequest request,
  }) {
    return getStateOf<BreakingNewsResponse>(
      request: () => _newsApiService.getBreakingNewsArticles(
        apiKey: request.apiKey,
        sources: request.sources,
        page: request.page,
        pageSize: request.pageSize,
      ),
    );
  }
}