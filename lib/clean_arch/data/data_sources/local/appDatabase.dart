import 'package:clean_tutorial/clean_arch/data/data_sources/local/dao/articles_dao.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import '../../../domain/entities/articles.dart';
import 'converters/source_type_conv.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'appDatabase.g.dart';

@TypeConverters([SourceTypeConverter])
@Database(version:1, entities:[Article])

abstract class AppDatabase extends FloorDatabase{
  ArticleDao get articleDao;
}