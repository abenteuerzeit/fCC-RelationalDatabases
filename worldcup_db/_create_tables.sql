CREATE TABLE teams(
    team_id SERIAL PRIMARY KEY, 
    name VARCHAR(50) UNIQUE NOT NULL
    );

CREATE TABLE games(
    game_id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    ROUND VARCHAR(50) NOT NULL,
    winner_id INT NOT NULL,
    opponent_id INT NOT NULL,
    winner_goals INT NOT NULL,
    OPPONENT_goals INT NOT NULL
    );

ALTER TABLE games ADD FOREIGN KEY (winner_id) REFERENCES teams(team_id); 
ALTER TABLE games ADD FOREIGN KEY (opponent_id) REFERENCES teams(team_id);