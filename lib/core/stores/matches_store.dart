import 'package:football_app/core/helpers/api_helper.dart';
import 'package:football_app/core/models/failure.dart';
import 'package:football_app/core/models/matches_model.dart';
import 'package:football_app/core/services/api_service.dart';
import 'package:football_app/core/stores/league_store.dart';
import 'package:get/get.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../models/results_model.dart';
import '../models/results_model.dart';

class MatchesStore {
  Matches matches;

  ApiService _apiService = Get.find<ApiService>();
  String _leagueName = "PL";
  bool isFirst = true;

  bool checkChange(String newLeague) {
    bool changed = false;
    if (newLeague != _leagueName) {
      changed = true;
      _leagueName = newLeague;
    }
    return changed;
  }

  Future<void> getMatches() async {
    isFirst = false;

    try {
      matches = await _apiService.getMatches(league: _leagueName);
      print(matches.matches.length);
    } catch (e) {
      throw Failure("network error");
    }
  }
}
