import 'package:football_app/core/helpers/api_helper.dart';
import 'package:football_app/core/models/failure.dart';
import 'package:football_app/core/services/api_service.dart';
import 'package:football_app/core/stores/league_store.dart';
import 'package:get/get.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../models/results_model.dart';
import '../models/results_model.dart';

class ResultsStore {
  Results results;
  bool isFirst=true;

  ApiService _apiService = Get.find<ApiService>();
  String _leagueName = "PL";

  bool checkChange(String newLeague) {
    bool changed = false;
    if (newLeague != _leagueName) {
      changed = true;
      _leagueName = newLeague;
    }
    return changed;
  }

  Future<void> getResults() async {
                isFirst=false;

    try {
      results = await _apiService.getResults(league: _leagueName);

      print(results.results.length);
    } catch (e) {
      throw Failure("network error");
    }
  }
}
