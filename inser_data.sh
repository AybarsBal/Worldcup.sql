#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games RESTART IDENTITY CASCADE")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNERGOAL OPPOGOAL
do
  if [[ $WINNER != "winner" ]]
  then
    # get wınner id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # if not found
    if [[ -z $WINNER_ID ]]
    then
      # insert team
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi

      # get new team_id
      
    fi
  fi

###

    if [[ $OPPONENT != "opponent" ]]
  then
    # get wınner id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # if not found
    if [[ -z $OPPONENT_ID ]]
    then
      # insert team
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi

      # get new team_id
      
    fi
    fi
  

  ##

  if [[ $YEAR != "year" && $ROUND != "winner" && $WINNER != "winner" && $OPPONENT != "opponent" && $WINNER_GOALS != "winner_goals" && $OPPONENT_GOALS != "opponent_goals" ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    INSERT_RESULT=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES('$YEAR', '$ROUND', '$WINNERGOAL', '$OPPOGOAL', '$WINNER_ID', '$OPPONENT_ID')")
    
    if [[ $INSERT_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into games
      fi

  fi

done
