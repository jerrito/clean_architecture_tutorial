import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:clean_tutorial/clean_arch/data/data_sources/local/appDatabase.dart';
import 'package:clean_tutorial/clean_arch/data/repositories/api_repository_imp.dart';
import 'package:clean_tutorial/clean_arch/domain/repositories/database_repo.dart';
import 'package:clean_tutorial/core/constants.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../clean_arch/data/data_sources/remote/news_api_service.dart';
import '../clean_arch/data/repositories/database_repo_imp.dart';
import '../clean_arch/domain/repositories/api_repo.dart';

final locator=GetIt.instance;

Future<void> initialiseDependencies() async{

  final database=await $FloorAppDatabase.databaseBuilder(
      Constants.databaseName).build();
  locator.registerSingleton<AppDatabase>(database);

  locator.registerSingleton<DatabaseRepository>(
      DatabaseRepositoryImplementation(locator<AppDatabase>()));

  final dio=Dio();
  dio.interceptors.add(AwesomeDioInterceptor());
  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<NewsApiService>(
    NewsApiService(locator<Dio>())
  );

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<NewsApiService>())
  );

}