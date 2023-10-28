#!/bin/bash

# Colors for output
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RESET="\033[0m"

# Function to display colored text
display_color_text() {
    local color="$1"
    local text="$2"
    echo -e "${color}${text}${RESET}"
}

# ==========================
# FILESYSTEM OPERATIONS
# ==========================
display_color_text $GREEN "Setting up project directories..."
mkdir -p number_guessing_game

# ==========================
# GIT OPERATIONS
# ==========================
if [[ ! -d number_guessing_game/.git ]]; then
    display_color_text $GREEN "Initializing git repository..."
    git -C number_guessing_game init > /dev/null 2>&1
fi

if [[ ! -e number_guessing_game/number_guess.sh ]]; then
    display_color_text $GREEN "Setting up main script..."
    git -C number_guessing_game checkout -b main
    git -C number_guessing_game branch -d master
    echo "#!/bin/bash" > number_guessing_game/number_guess.sh
    chmod +x number_guessing_game/number_guess.sh
    git -C number_guessing_game add . > /dev/null 2>&1
    git -C number_guessing_game commit -m "Initial commit" > /dev/null 2>&1
fi

# ==========================
# DATABASE OPERATIONS
# ==========================
display_color_text $GREEN "Setting up the database..."

BASE_QUERY="psql --username=freecodecamp -h localhost -t --no-align"

SET_DB_CONTEXT() {
    PSQL="$BASE_QUERY --dbname=$1 -c"
}

EXECUTE_QUERY() {
    local query="$1"
    display_color_text $YELLOW "\t$query"
    RESULT=$($PSQL "$query")
}

CREATE_TABLE() {
    local table_name="$1"
    local table_schema="$2"
    if ! $($PSQL "SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename = '$table_name';" | grep -q "$table_name"); then
        display_color_text $YELLOW "Creating table $table_name..."
        EXECUTE_QUERY "$table_schema"
    else
        display_color_text $RED "Table $table_name already exists."
    fi
}


PRETTIFY_TABLE_OUTPUT() {
    local raw_output="$1"
    local columns_output=$(echo "$raw_output" | grep "|" |            
    sed 's/|||/|/g' |                          
    sed 's/||/|/g' |                           
    sed 's/|$//g' |                            
    awk -F'|' '{print "- **"$1"**: _"$2"_ "}')  
    echo "$columns_output"
}

SET_DB_CONTEXT "postgres"
EXECUTE_QUERY "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'number_guess';"
EXECUTE_QUERY "DROP DATABASE IF EXISTS number_guess;"
EXECUTE_QUERY "CREATE DATABASE number_guess;"

SET_DB_CONTEXT "number_guess"
display_color_text $GREEN "Switched to number_guess database."

# Define tables and their schemas in an associative array
declare -A TABLES

TABLES["users"]="CREATE TABLE users (
    username VARCHAR(22) PRIMARY KEY,
    games_played INT DEFAULT 0,
    best_game INT
);"

TABLES["games"]="CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    username VARCHAR(22) REFERENCES users(username),
    number_of_guesses INT,
    secret_number INT
);"

# Define the order of table creation
TABLE_ORDER=("users" "games")

for table in "${TABLE_ORDER[@]}"; do
    CREATE_TABLE "$table" "${TABLES[$table]}"
done


# ==========================
# README GENERATION
# ==========================

USERS_TABLE=$(PRETTIFY_TABLE_OUTPUT "$($PSQL "\d users" 2>&1)")
GAMES_TABLE=$(PRETTIFY_TABLE_OUTPUT "$($PSQL "\d games" 2>&1)")

display_color_text $GREEN "Generating README.md..."
cat > number_guessing_game/README.md <<EOL
# Number Guessing Game

This project is a simple number guessing game where users try to guess a randomly generated number.

## Setup

1. Run the \`install.sh\` script to set up the project directory, initialize git, and set up the database.
2. Use the \`number_guess.sh\` script to play the game.

## Database

The game uses a PostgreSQL database named \`number_guess\` to track user stats and game details.

### Tables:

#### Users:

$USERS_TABLE

#### Games:

$GAMES_TABLE

EOL


display_color_text $GREEN "Installation complete!"

./develop.sh