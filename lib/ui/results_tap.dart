import 'package:flutter/material.dart';
import 'package:football_app/core/models/results_model.dart';
import 'package:football_app/core/stores/league_store.dart';
import 'package:football_app/core/stores/results_store.dart';
import 'package:get/get.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

buildResultsTap() {
  return StateBuilder<ResultsStore>(
    observe: () => RM.get<ResultsStore>(),
    builder: (c, rm) {
      print("rebuild");
      if (rm.state.isFirst) {
        print("future call");
        rm.setState((s) => s.getResults(), onError: ((c, e) {
          Get.snackbar("error", e.toString());
        }));
      }
      if (rm.state.checkChange(IN.get<LeagueStore>().league)) {
        rm.setState((s) => s.getResults(), onError: ((c, e) {
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
            itemCount: data.results.results.length,
            itemBuilder: (c, i) {
              return _buildResutsListTile(data.results.results[i]);
            });
      }, onError: (r) {
        return Center(
          child: Text(r.toString()),
        );
      });
    },
  );
}

_buildResutsListTile(Result res) {
  return Container(
    color: Colors.grey,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 70,
          child: Text(res.home),
        ),
        Row(
          children: <Widget>[
            CircleAvatar(
              child: Center(child: Text(res.homeScore.toString())),
            ),
            SizedBox(
              width: 8,
            ),
            CircleAvatar(
              child: Center(child: Text(res.awayScore.toString())),
            ),
          ],
        ),
        SizedBox(
          width: 100,
          child: Text(res.away),
        ),
      ],
    ),
  );
}
