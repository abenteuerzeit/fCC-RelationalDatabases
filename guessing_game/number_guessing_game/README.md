# Number Guessing Game

This project is a simple number guessing game where users try to guess a randomly generated number.

## Setup

1. Run the `install.sh` script to set up the project directory, initialize git, and set up the database.
2. Use the `number_guess.sh` script to play the game.

## Database

The game uses a PostgreSQL database named `number_guess` to track user stats and game details.

### Tables:

#### Users:

- **username**: _character varying(22)_ 
- **games_played**: _integer_ 
- **best_game**: _integer_ 

#### Games:

- **game_id**: _integer_ 
- **username**: _character varying(22)_ 
- **number_of_guesses**: _integer_ 
- **secret_number**: _integer_ 

