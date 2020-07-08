import 'package:flutter/material.dart';
import 'package:football_app/core/models/matches_model.dart';
import 'package:football_app/core/models/results_model.dart';
import 'package:football_app/core/stores/league_store.dart';
import 'package:football_app/core/stores/matches_store.dart';
import 'package:football_app/core/stores/results_store.dart';
import 'package:get/get.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

buildMatchesTap() {
  return StateBuilder<MatchesStore>(
    observe: () => RM.get<MatchesStore>(),
    observeMany: [() => RM.get<ResultsStore>(), () => RM.get<LeagueStore>()],
    builder: (c, rm) {
      print("rebuild");
      if (rm.state.isFirst) {
        print("future call");
        rm.setState((s) => s.getMatches(), onError: ((c, e) {
          Get.snackbar("error", e.toString());
        }));
      }
      if (rm.state.checkChange(IN.get<LeagueStore>().league)) {
        rm.setState((s) => s.getMatches(), onError: ((c, e) {
          Get.snackbar("error", e.toString());
        }));
      }

      return rm.whenConnectionState(onIdle: () {
        return Text("idle");
      }, onWaiting: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      }, onData: (data) {
        return ListView.builder(
            itemCount: data.matches.matches.length,
            itemBuilder: (c, i) {
              return _buildMatchListTile(data.matches.matches[i]);
            });
      }, onError: (r) {
        return Center(
          child: Text(r.toString()),
        );
      });
    },
  );
}

_buildMatchListTile(Matchx match) {
  return Container(
    color: Colors.grey,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 70,
          child: Text(match.home),
        ),
        Center(child: Text(match.time.toString())),
        SizedBox(
          width: 100,
          child: Text(match.away),
        ),
      ],
    ),
  );
}
