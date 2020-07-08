
import './team_model.dart';


class Standing{

  List<Team> table=[];

Standing.fromList(List badTable){

table.clear();
  for (Map item in badTable) {
    
   Team team=Team();
   team.id=item["team"]["id"];
   team.name=item["team"]["name"];
   team.points=item["points"];
   team.played=item["playedGames"];
   team.won=item["won"];
   team.lost=item["lost"];
   team.draw=item["draw"];
   team.goalsRecieved=item["goalsAgainst"];
   team.goalsScored=item["goalsFor"];
   team.position=item["position"];
   table.add(team);
  }


}


@override
  String toString() {
    
    String toReturn="";
    for (Team item in table) {
      toReturn=toReturn+item.toString();
      toReturn=toReturn+"\n";
    }
    
    return toReturn;
  }



}



