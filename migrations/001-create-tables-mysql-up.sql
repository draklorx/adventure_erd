-- Up
CREATE TABLE IF NOT EXISTS adventure (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  spoiler_free_description TEXT NOT NULL,
  spoiler_description TEXT NOT NULL,
  level INT NOT NULL,
  minimum_player_count INT NOT NULL,
  maximum_player_count INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS monster (
  id INT AUTO_INCREMENT PRIMARY KEY,
  monster_index varchar(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS ability (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS location (
  id INT AUTO_INCREMENT PRIMARY KEY,
  adventure_id INT NOT NULL,
  name VARCHAR(128) NOT NULL,
  description TEXT NOT NULL,
  map_url TEXT NOT NULL,
  map_width INT NOT NULL,
  map_height INT NOT NULL,
  sort_order INT NOT NULL,
  CONSTRAINT fk_location_adventure FOREIGN KEY (adventure_id) REFERENCES adventure(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS encounter (
  id INT AUTO_INCREMENT PRIMARY KEY,
  location_id INT NOT NULL,
  name VARCHAR(128) NOT NULL,
  read_aloud_text TEXT NOT NULL,
  summary TEXT NOT NULL,
  map_marker_x INT NOT NULL,
  map_marker_y INT NOT NULL,
  map_marker_symbol VARCHAR(4) NOT NULL,
  sort_order INT NOT NULL,
  CONSTRAINT fk_encounter_location FOREIGN KEY (location_id) REFERENCES location(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS encounter_monster (
  monster_id INT NOT NULL,
  encounter_id INT NOT NULL,
  number INT NOT NULL,
  custom_name VARCHAR(64) NULL,
  sort_order INT NOT NULL,
  PRIMARY KEY (monster_id, encounter_id),
  CONSTRAINT fk_encounter_monster_monster FOREIGN KEY (monster_id) REFERENCES monster(id) ON DELETE CASCADE,
  CONSTRAINT fk_encounter_monster_encounter FOREIGN KEY (encounter_id) REFERENCES encounter(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS point_of_interest (
  id INT AUTO_INCREMENT PRIMARY KEY,
  encounter_id INT NOT NULL,
  name VARCHAR(128) NOT NULL,
  description TEXT NOT NULL,
  sort_order INT NOT NULL,
  CONSTRAINT fk_poi_encounter FOREIGN KEY (encounter_id) REFERENCES encounter(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS point_of_interest_ability_check (
  id INT AUTO_INCREMENT PRIMARY KEY,
  point_of_interest_id INT NOT NULL,
  ability_id INT NOT NULL,
  difficulty INT NOT NULL,
  description TEXT NOT NULL,
  sort_order INT NOT NULL,
  CONSTRAINT fk_poi_ablity_check_ability FOREIGN KEY (ability_id) REFERENCES ability(id) ON DELETE CASCADE,
  CONSTRAINT fk_poi_ability_check_point_of_interest FOREIGN KEY (point_of_interest_id) REFERENCES point_of_interest(id) ON DELETE CASCADE
);
