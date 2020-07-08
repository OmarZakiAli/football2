import 'package:football_app/core/helpers/api_helper.dart';
import 'package:football_app/core/services/api_service.dart';
import 'package:get/get.dart';

class ServiceLocator {
  static initServices() {
    Get.lazyPut<ApiHelper>(() => ApiHelper());

    Get.lazyPut<ApiService>(() => ApiService());
  }
}
