
import '../../../../domain/entities/source.dart';
import 'package:floor/floor.dart';
class SourceTypeConverter extends TypeConverter<Source?,String >{

  @override
  Source? decode(String databaseValue ){
    final List<String> value =databaseValue.split(",");
    return Source(id:value.first ,name:value.last);
  }

  @override
  String encode(Source? value){
    final String result="${value?.id} ${value?.name}";
    return result;
  }
}