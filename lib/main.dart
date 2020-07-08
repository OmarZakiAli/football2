import 'package:flutter/material.dart';
import 'package:football_app/core/helpers/api_helper.dart';
import 'package:football_app/core/stores/matches_store.dart';
import 'package:football_app/core/stores/results_store.dart';
import 'package:football_app/core/stores/scorers_store.dart';
import 'package:football_app/core/stores/standings_store.dart';
import 'package:football_app/ui/home.dart';
import 'package:get/get.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'core/locator.dart';
import 'core/services/api_service.dart';
import 'core/stores/league_store.dart';

void main() {
  ServiceLocator.initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: Injector(
      inject: [
        Inject(() => LeagueStore(),isLazy: false),
        Inject(() => ResultsStore()),
        Inject(() => StandingStore()),
        Inject(() => ScorersStore()),
        Inject(() => MatchesStore()),
      ],
      builder: (c) {
        return HomeScreen();
      },
    ));
  }
}
