class Team{

String name;
int id;
int played;
int points;
int won;
int lost;
int draw;
int goalsScored;
int goalsRecieved;
int position;

@override
  String toString() {
    
    return " team name $name ,  points $points , played $played  ,  won  $won , lost $lost ";

  }

}