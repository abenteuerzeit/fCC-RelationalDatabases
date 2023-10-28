#!/bin/bash

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RESET="\033[0m"

# Display colored text
display_color_text() {
    local color="$1"
    local text="$2"
    echo -e "${color}${text}${RESET}"
}

# Database interaction
BASE_QUERY="psql --username=freecodecamp -h localhost -t --no-align"
PSQL="$BASE_QUERY --dbname=number_guess -c"

# Git operations
git_commit() {
    local message="$1"
    git -C number_guessing_game add .
    git -C number_guessing_game commit -m "$message"
}

# Append parts of the game logic to the main script
append_initial_game_logic() {
    cat <<EOL >> number_guessing_game/number_guess.sh

# Randomly generate a secret number between 1 and 1000
SECRET_NUMBER=\$((1 + RANDOM % 1000))
echo \$SECRET_NUMBER > ../secret.txt

# Prompt for username
echo "Enter your username:"
read USERNAME

EOL

    git_commit "feat: Generate secret number and prompt for username"
}


append_user_handling() {
    cat <<EOL >> number_guessing_game/number_guess.sh

# Check if the user exists in the database
USER_EXISTS=\$($PSQL "SELECT username FROM users WHERE username='\$USERNAME';" | grep -o "\$USERNAME")

if [ "\$USER_EXISTS" == "\$USERNAME" ]; then
    GAMES_PLAYED=\$($PSQL "SELECT COUNT(*) FROM games WHERE username='\$USERNAME';" | tr -d '[:space:]')
    BEST_GAME=\$($PSQL "SELECT MIN(number_of_guesses) FROM games WHERE username='\$USERNAME';" | tr -d '[:space:]')
    
    # Check if BEST_GAME has a value
    if [ -z "\$BEST_GAME" ]; then
        echo "Welcome back, \$USERNAME! You have played \$GAMES_PLAYED games. Keep going to set your best game record!"
    else
        echo "Welcome back, \$USERNAME! You have played \$GAMES_PLAYED games, and your best game took \$BEST_GAME guesses."
    fi

else
    echo "Welcome, \$USERNAME! It looks like this is your first time here."
    CREATE_NEW_USER_RESULT=\$($PSQL "INSERT INTO users (username) VALUES ('\$USERNAME');")
fi

EOL

    git_commit "feat: Updated user greeting to count games from games table"
}


append_guessing_logic() {
    cat <<EOL >> number_guessing_game/number_guess.sh

echo "Guess the secret number between 1 and 1000:"
read GUESS
NUMBER_OF_GUESSES=1

while [[ ! "\$GUESS" =~ ^[0-9]+$ ]] || [ "\$GUESS" -ne "\$SECRET_NUMBER" ]; do
    if [[ "\$GUESS" =~ ^[0-9]+$ ]]; then
        if [ "\$GUESS" -lt "\$SECRET_NUMBER" ]; then
            echo "It's higher than that, guess again:"
        else
            echo "It's lower than that, guess again:"
        fi
    else
        echo "That is not an integer, guess again:"
    fi
    NUMBER_OF_GUESSES=\$((NUMBER_OF_GUESSES + 1))
    read GUESS
done

EOL

    git_commit "feat: Implement guessing mechanism"
}

append_endgame_logic() {
    cat <<EOL >> number_guessing_game/number_guess.sh

# Store the game result in the 'games' table and update the 'users' table
SAVE_GAME_RESULT=\$($PSQL "INSERT INTO games (username, number_of_guesses, secret_number) VALUES ('\$USERNAME', \$NUMBER_OF_GUESSES, \$SECRET_NUMBER);")
UPDATE_RESULT=\$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE username='\$USERNAME';")

echo "You guessed it in \$NUMBER_OF_GUESSES tries. The secret number was \$SECRET_NUMBER. Nice job!"

EOL

    git_commit "feat: Finalize game and store results"
}

# Main development process
main() {
    display_color_text $GREEN "Appending initial game logic..."
    append_initial_game_logic

    display_color_text $GREEN "Appending user handling logic..."
    append_user_handling

    display_color_text $GREEN "Appending guessing logic..."
    append_guessing_logic

    display_color_text $GREEN "Appending endgame logic..."
    append_endgame_logic

    display_color_text $GREEN "Development complete!"
}

main
