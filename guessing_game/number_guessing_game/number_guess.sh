#!/bin/bash

# Randomly generate a secret number between 1 and 1000
SECRET_NUMBER=$((1 + RANDOM % 1000))
echo $SECRET_NUMBER > ../secret.txt

# Prompt for username
echo "Enter your username:"
read USERNAME


# Check if the user exists in the database
USER_EXISTS=$(psql --username=freecodecamp -h localhost -t --no-align --dbname=number_guess -c "SELECT username FROM users WHERE username='$USERNAME';" | grep -o "$USERNAME")

if [ "$USER_EXISTS" == "$USERNAME" ]; then
    GAMES_PLAYED=$(psql --username=freecodecamp -h localhost -t --no-align --dbname=number_guess -c "SELECT COUNT(*) FROM games WHERE username='$USERNAME';" | tr -d '[:space:]')
    BEST_GAME=$(psql --username=freecodecamp -h localhost -t --no-align --dbname=number_guess -c "SELECT MIN(number_of_guesses) FROM games WHERE username='$USERNAME';" | tr -d '[:space:]')
    
    # Check if BEST_GAME has a value
    if [ -z "$BEST_GAME" ]; then
        echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games. Keep going to set your best game record!"
    else
        echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    fi

else
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    CREATE_NEW_USER_RESULT=$(psql --username=freecodecamp -h localhost -t --no-align --dbname=number_guess -c "INSERT INTO users (username) VALUES ('$USERNAME');")
fi


echo "Guess the secret number between 1 and 1000:"
read GUESS
NUMBER_OF_GUESSES=1

while [[ ! "$GUESS" =~ ^[0-9]+$ ]] || [ "$GUESS" -ne "$SECRET_NUMBER" ]; do
    if [[ "$GUESS" =~ ^[0-9]+$ ]]; then
        if [ "$GUESS" -lt "$SECRET_NUMBER" ]; then
            echo "It's higher than that, guess again:"
        else
            echo "It's lower than that, guess again:"
        fi
    else
        echo "That is not an integer, guess again:"
    fi
    NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))
    read GUESS
done


# Store the game result in the 'games' table and update the 'users' table
SAVE_GAME_RESULT=$(psql --username=freecodecamp -h localhost -t --no-align --dbname=number_guess -c "INSERT INTO games (username, number_of_guesses, secret_number) VALUES ('$USERNAME', $NUMBER_OF_GUESSES, $SECRET_NUMBER);")
UPDATE_RESULT=$(psql --username=freecodecamp -h localhost -t --no-align --dbname=number_guess -c "UPDATE users SET games_played = games_played + 1 WHERE username='$USERNAME';")

echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

