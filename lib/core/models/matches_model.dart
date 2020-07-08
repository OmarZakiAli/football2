
class Matches{

  List<Matchx> matches=[];

  Matches.fromList(List badMatchesList){
    matches.clear();
    for(Map item in badMatchesList){
   Matchx matchx=Matchx();
   matchx.time=getFormattedTime(item["utcDate"]);
   matchx.home=item["homeTeam"]["name"];
   matchx.away=item["awayTeam"]["name"];
  

   matches.add(matchx);
    }
  }
}

String getFormattedTime(item) {
  DateTime timeX = DateTime.parse(item);
  String toReturn="${timeX.hour.toString()}:${timeX.minute.toString()}";
  return toReturn;
}


class Matchx{
  String time;
  String home;
  String away;
}