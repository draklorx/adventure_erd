-- Up
create table if not exists Adventure (
  id integer primary key
, name varchar(128) not null
, spoiler_free_description text not null
, spoiler_description text not null
, level integer not null
, number_of_players integer not null
, created_at text not null default CURRENT_TIMESTAMP
, updated_at text null
);
create table if not exists Location (
  id integer primary key
, adventure_id integer not null references Adventure(id)
, name varchar(128) not null
, description text not null
, map_url text not null
, map_width integer not null
, map_height integer not null
, sort_order integer not null
, created_at text not null default CURRENT_TIMESTAMP
, updated_at text null
);
create table if not exists Encounter (
  id integer primary key
, location_id integer not null references Location(id)
, name varchar(128) not null
, read_aloud_text text not null
, summary text not null
, map_marker_x integer not null
, map_marker_y integer not null
, map_marker_symbol varchar(4) not null
, sort_order integer not null
, created_at text not null default CURRENT_TIMESTAMP
, updated_at text null
);
create table if not exists PointOfInterest (
  id integer primary key
, encounter_id integer not null references Encounter(id)
, name varchar(128) not null
, description text not null
, sort_order integer not null
, created_at text not null default CURRENT_TIMESTAMP
, updated_at text null
);
create table if not exists PointOfInterestAbilityCheck (
  ability_check_id integer primary key
, point_of_interest_id integer not null references PointOfInterest(id)
, ability varchar(64) not null
, difficulty integer not null
, description text not null
, sort_order integer not null
, created_at text not null default CURRENT_TIMESTAMP
, updated_at text null
);
create table if not exists PointOfInterestMonster (
  monster_id integer primary key
, point_of_interest_id integer primary key
, number integer not null
, custom_name varchar(64) null
, sort_order integer not null
, created_at text not null default CURRENT_TIMESTAMP
, updated_at text null
);

-- Down
drop table if exists PointOfInterestMonster;
drop table if exists PointOfInterestAbilityCheck;
drop table if exists PointOfInterest;
drop table if exists Encounter;
drop table if exists Location;
drop table if exists Adventure;
