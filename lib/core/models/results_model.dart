
class Results{

  List<Result> results=[];

  Results.fromList(List badResultsList){
    results.clear();
    for(Map item in badResultsList){
      Result result=Result();
      result.home=item["homeTeam"]["name"];
      result.away=item["awayTeam"]["name"];
      result.homeScore=item["score"]["fullTime"]["homeTeam"];
      result.awayScore=item["score"]["fullTime"]["awayTeam"];

      results.add(result);
    }
  }
}


class Result {
  String home;
  String away;
  int homeScore;
  int awayScore;
}