import '../../../../core/constants.dart';


class BreakingNewsRequest {
  final String apiKey;
  final String sources;
  final int page;
  final int pageSize;

  BreakingNewsRequest({
    this.apiKey = Constants.apiKey,
    this.sources = 'bbc-news, abc-news',
    this.page = 1,
    this.pageSize = 20,
  });
}