import 'package:flutter/material.dart';
import 'package:football_app/core/helpers/api_helper.dart';
import 'package:football_app/core/services/api_service.dart';
import 'package:football_app/core/stores/league_store.dart';
import 'package:football_app/core/stores/results_store.dart';
import 'package:football_app/ui/matches_tap.dart';
import 'package:football_app/ui/results_tap.dart';
import 'package:football_app/ui/scorers_tap.dart';
import 'package:football_app/ui/standings_tap.dart';
import 'package:get/get.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final leagueStore = RM.get<LeagueStore>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Football News"),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (con) {
                return [
                  listTileBuilder("English League", "PL"),
                  listTileBuilder("spanish League", "PD"),
                  listTileBuilder("itallian League", "SA"),
                  listTileBuilder("france League", "FL1"),
                  listTileBuilder("Bundes League", "BL1"),
                ];
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            TabBar(
                labelStyle: TextStyle(color: Colors.black),
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: "results",
                  ),
                  Tab(
                    text: "standings",
                  ),
                  Tab(
                    text: "scorers",
                  ),
                  Tab(
                    text: "schedule",
                  ),
                ]),
            Expanded(
              child: StateBuilder<LeagueStore>(
                observe: () => RM.get<LeagueStore>(),
                builder: (c, rm) {
                  return TabBarView(children: [
                    buildResultsTap(),
                    buildStandingTap(),
                    buildScoreresTap(),
                    buildMatchesTap()
                  ]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  PopupMenuItem listTileBuilder(String title, String code) {
    return PopupMenuItem(
        child: InkWell(
      child: Text(title),
      onTap: () {
        leagueStore.setState((s) => s.changeLeague(code));
      },
    ));
  }
}
