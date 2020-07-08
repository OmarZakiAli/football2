import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../helpers/api_helper.dart';
import '../helpers/api_helper.dart';
import '../models/matches_model.dart';
import '../models/matches_model.dart';
import '../models/results_model.dart';
import '../models/results_model.dart';
import '../models/scorers_model.dart';
import '../models/scorers_model.dart';
import '../models/standing_model.dart';
import '../models/standing_model.dart';

class ApiService {
  Dio dio = Dio();
  ApiHelper _apiService = Get.find<ApiHelper>();

  Future<Standing> getStanding({String league = "PL"}) async {
    Map response;
    List table;

    await _apiService
        .getData(
      uri: "https://api.football-data.org/v2/competitions/$league/standings",
    )
        .then((value) {
      response = value;
      table = response["standings"][0]["table"];
    });

    return Standing.fromList(table);
  }

  Future<Scorers> getScorers({String league = "PL"}) async {
    Map response = await _apiService.getData(
      uri: "https://api.football-data.org/v2/competitions/$league/scorers",
    );

    List plrs = response["scorers"];

    return Scorers.fromList(plrs);
  }

  Future<Matches> getMatches({String league = "PL"}) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedNow = formatter.format(now);

    Map response = await _apiService.getData(
      uri:
          "https://api.football-data.org/v2/matches?competitions=$league&status=SCHEDULED&dateFrom=$formattedNow&dateTo=$formattedNow",
    );

    List matches = response["matches"];

    return Matches.fromList(matches);
  }

  Future<Results> getResults({String league = "PL"}) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    var before = now.subtract(Duration(days: 7));
    String formattedNow = formatter.format(now);
    String formattedBefore = formatter.format(before);
    Map response = await _apiService.getData(
      uri:
          "https://api.football-data.org/v2/matches?competitions=$league&status=FINISHED&dateFrom=$formattedBefore&dateTo=$formattedNow",
    );

    List results = response["matches"];
    return Results.fromList(results);
  }
}
