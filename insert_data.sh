#! /bin/bash

CSV_FILE="./games.csv"

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Clear rows 
RESET_ROWS=$($PSQL "TRUNCATE TABLE games, teams")
echo $RESET_ROWS

cat $CSV_FILE | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    function GET_TEAM_ID() {
      local __name=$1
        #get team_id
        local __teamId=$($PSQL "SELECT team_id FROM teams WHERE name = '$__name' ")
        # if not found
        if [[ -z $__teamId ]]
        then
          # insert team
          local __insertTeamResult=$($PSQL "INSERT INTO teams(name) VALUES('$__name') ")
          __teamId=$($PSQL "SELECT team_id FROM teams WHERE name='$__name' ")
        fi
        echo $__teamId
    }

    INSERT_GAME_RESULT=$($PSQL "
      INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
      VALUES($YEAR, '$ROUND', $(GET_TEAM_ID $WINNER), $(GET_TEAM_ID $OPPONENT), $WINNER_GOALS, $OPPONENT_GOALS)")
  fi
done

echo "team_id|name"
echo -e "$($PSQL "SELECT * from teams")\n"

echo "game_id|year|round|winner_id|opponent_id|winner_goals|opponent_goals"
echo -e "$($PSQL "SELECT * from games")\n"