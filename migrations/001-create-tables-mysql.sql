-- Up
CREATE TABLE IF NOT EXISTS Adventure (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  spoiler_free_description TEXT NOT NULL,
  spoiler_description TEXT NOT NULL,
  level INT NOT NULL,
  number_of_players INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Location (
  id INT AUTO_INCREMENT PRIMARY KEY,
  adventure_id INT NOT NULL,
  name VARCHAR(128) NOT NULL,
  description TEXT NOT NULL,
  map_url TEXT NOT NULL,
  map_width INT NOT NULL,
  map_height INT NOT NULL,
  sort_order INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_location_adventure FOREIGN KEY (adventure_id) REFERENCES Adventure(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Encounter (
  id INT AUTO_INCREMENT PRIMARY KEY,
  location_id INT NOT NULL,
  name VARCHAR(128) NOT NULL,
  read_aloud_text TEXT NOT NULL,
  summary TEXT NOT NULL,
  map_marker_x INT NOT NULL,
  map_marker_y INT NOT NULL,
  map_marker_symbol VARCHAR(4) NOT NULL,
  sort_order INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_encounter_location FOREIGN KEY (location_id) REFERENCES Location(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PointOfInterest (
  id INT AUTO_INCREMENT PRIMARY KEY,
  encounter_id INT NOT NULL,
  name VARCHAR(128) NOT NULL,
  description TEXT NOT NULL,
  sort_order INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_poi_encounter FOREIGN KEY (encounter_id) REFERENCES Encounter(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PointOfInterestAbilityCheck (
  ability_check_id INT AUTO_INCREMENT PRIMARY KEY,
  point_of_interest_id INT NOT NULL,
  ability VARCHAR(64) NOT NULL,
  difficulty INT NOT NULL,
  description TEXT NOT NULL,
  sort_order INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_poi_ability_check FOREIGN KEY (point_of_interest_id) REFERENCES PointOfInterest(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PointOfInterestMonster (
  monster_id VARCHAR(64) NOT NULL,
  point_of_interest_id INT NOT NULL,
  number INT NOT NULL,
  custom_name VARCHAR(64) NULL,
  sort_order INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (monster_id, point_of_interest_id),
  CONSTRAINT fk_poi_monster FOREIGN KEY (point_of_interest_id) REFERENCES PointOfInterest(id) ON DELETE CASCADE
);

-- Down
DROP TABLE IF EXISTS PointOfInterestMonster;
DROP TABLE IF EXISTS PointOfInterestAbilityCheck;
DROP TABLE IF EXISTS PointOfInterest;
DROP TABLE IF EXISTS Encounter;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Adventure;