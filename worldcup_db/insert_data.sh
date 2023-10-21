#! /bin/bash

CSV_FILE="./games.csv"

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

RESET_DATA=$($PSQL "TRUNCATE TABLE games, teams")
echo "DEBUG: Tables 'games' and 'teams' truncated. Result: $RESET_DATA"


function GET_TEAM_ID() {
  local __name=$1
  # Escape single quotes for SQL
  local __escaped_name=$(echo "$__name" | sed "s/'/''/g")

  # Get team_id
  local __teamId=$(echo $($PSQL "SELECT team_id FROM teams WHERE name = '$__escaped_name' ") | tr -d '[:space:]')

  # Output
  echo -e "Retrieving team ID for '$__escaped_name' resulted in >> '$__teamId'" >&2

  # If not found
  if [[ -z $__teamId ]]
  then
    # Output
    echo -e "\t[NOT FOUND]\tTeam $__escaped_name not found. Inserting new team..." >&2
    
    # Insert team
    local __insertTeamResult=$($PSQL "INSERT INTO teams(name) VALUES('$__escaped_name');")
    
    # Retrieve the inserted team's ID
    __teamId=$(echo $($PSQL "SELECT team_id FROM teams WHERE name='$__escaped_name' ") | tr -d '[:space:]')

    # Output
    echo -e "\t[NEW ID]\tInserted team '$__escaped_name' with ID '$__teamId'" >&2
  fi
  echo $__teamId
}

while IFS=, read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
    # Skip the header line
    if [[ $YEAR == "year" ]]; then
        continue
    fi

    WINNER_ID=$(GET_TEAM_ID "$WINNER")
    OPPONENT_ID=$(GET_TEAM_ID "$OPPONENT")
    
    # Construct and log the SQL statement
    SQL_STATEMENT="INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)"

    echo -e "\t[EXECUTING]\t$SQL_STATEMENT"
    
    INSERT_GAME_RESULT=$($PSQL "$SQL_STATEMENT")
    
    # Check if insertion was successful
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]; then
        echo -e "\t[SUCCESS]\tSuccessfully inserted game result for $YEAR - $ROUND between $WINNER and $OPPONENT.\n"
    else
        echo -e "\t[ERROR]\tFailed to insert game result for $YEAR - $ROUND between $WINNER and $OPPONENT.\n"
    fi

done < "$CSV_FILE"


