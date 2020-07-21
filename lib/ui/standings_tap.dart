import 'package:flutter/material.dart';
import 'package:football_app/core/models/results_model.dart';
import 'package:football_app/core/models/team_model.dart';
import 'package:football_app/core/stores/league_store.dart';
import 'package:football_app/core/stores/results_store.dart';
import 'package:football_app/core/stores/standings_store.dart';
import 'package:get/get.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

buildStandingTap() {
  return StateBuilder<StandingStore>(
    observe: () => RM.get<StandingStore>(),
    observeMany: [() => RM.get<StandingStore>(), () => RM.get<LeagueStore>()],
    builder: (c, rm) {
      print("rebuild");
      if (rm.state.isFirst) {
        print("future call");
        rm.setState((s) => s.getStanding(), onError: ((c, e) {
          Get.snackbar("error", e.toString());
        }));
      }
      if (rm.state.checkChange(IN.get<LeagueStore>().league)) {
        rm.setState((s) => s.getStanding(), onError: ((c, e) {
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
            itemCount: data.standing.table.length,
            itemBuilder: (c, i) {
              return _buildStandingListTile(data.standing.table[i]);
            });
      }, onError: (r) {
        return Center(
          child: Text(r.toString()),
        );
      });
    },
  );
}

_buildStandingListTile(Team team) {
  return Container(
    color: Colors.grey,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 70,
          child: Text(team.name),
        ),
        CircleAvatar(
          backgroundColor: Colors.yellow,
          child: Center(
            child: Text(team.points.toString()),
          ),
        )
      ],
    ),
  );
}
