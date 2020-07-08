import './player_model.dart';
class Scorers {

List<Player> scorers =[];

Scorers.fromList(List badScorers){

scorers.clear();
for (Map item in badScorers) {
  Player plr =Player();

plr.name=item["player"]["name"];
plr.team=item["team"]["name"];
plr.numGoals=item["numberOfGoals"];
scorers.add(plr);

}

}
@override
  String toString() {
    String toReturn="";

     for (Player plr in scorers) {
       toReturn=toReturn+plr.toString();
     }

    return toReturn;
  }

}

