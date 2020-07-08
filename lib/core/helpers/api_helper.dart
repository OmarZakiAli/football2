import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class ApiHelper {
  Dio dio = Dio();

  Future<Map<String, dynamic>> getData({String uri}) async {
    print(uri);
    dio.options.receiveTimeout = 5000;
    dio.options.headers = {"X-Auth-Token": "c0698c9b98804b26af3639e11088b038"};
    dio.options.connectTimeout = 5000;
    dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);

    Response response = await dio
        .get(uri,
            options: buildCacheOptions(
              Duration(
                days: 2,
              ),
              forceRefresh: true,
            ))
        .catchError((onError) {
          print("wtf");
      print(onError.toString());
      throw "network or server problem";
    });
    if (response.statusCode == 200) {
      print(response.data.toString());

      return response.data;
    } else {
      throw "network or server problem";
    }
  }
}
