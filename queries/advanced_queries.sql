/* Get details for encounter 34*/
SET @adventure_id := 24;
select 
    "adventure_title" as section_type,
    a.name as header,
    "" as text,
    "01" as sort_order
from adventure a
where a.id = @adventure_id
union
select 
    "adventure_description" as section_type,
    "Description" as header,
    a.spoiler_free_description as text,
    "02" as sort_order
from adventure a
where a.id = @adventure_id
union
select 
    "adventure_details" as section_type,
    "Adventure Details (spoilers)" as header,
    a.spoiler_description as text,
    "03" as sort_order
from adventure a
where a.id = @adventure_id
union
select 
    "location" as section_type,
    l.name as header,
    l.description as text,
    concat(l.sort_order, "000") as sort_order
from adventure a
join location l on a.id = l.adventure_id
where a.id = @adventure_id
union
select 
    "encounter" as section_type,
    concat(e.map_marker_symbol, '. ', e.name) as header,
    e.read_aloud_text as text,
    concat(l.sort_order, e.sort_order, "00") as sort_order
from adventure a
join location l on l.adventure_id = a.id
join encounter e on e.location_id = l.id
where a.id = @adventure_id
union
select 
    "poi" as section_type,
    poi.name as header,
    poi.description as text,
    concat(l.sort_order, e.sort_order, poi.sort_order, "0") as sort_order
from adventure a
join location l on l.adventure_id = a.id
join encounter e on e.location_id = l.id
join point_of_interest poi on poi.encounter_id = e.id
where a.id = @adventure_id
union
select 
    "poi_monster" as section_type,
    if(monster.custom_name, concat(monster.custom_name, " (", monster.monster_id, ")"), monster.monster_id) as header,
    concat (monster.monster_id, " x", monster.number) as text,
    concat(l.sort_order, e.sort_order, poi.sort_order, monster.sort_order) as sort_order
from adventure a
join location l on l.adventure_id = a.id
join encounter e on e.location_id = l.id
join point_of_interest poi on poi.encounter_id = e.id
join point_of_interest_monster monster on monster.point_of_interest_id = poi.id
where a.id = @adventure_id
union
select 
    "poi_ability" as section_type,
    concat(ability_check.ability, " DC", ability_check.difficulty) as header,
    ability_check.description as text,
    concat(l.sort_order, e.sort_order, poi.sort_order, ability_check.sort_order) as sort_order
from adventure a
join location l on l.adventure_id = a.id
join encounter e on e.location_id = l.id
join point_of_interest poi on poi.encounter_id = e.id
join point_of_interest_ability_check ability_check on ability_check.point_of_interest_id = poi.id
where a.id = @adventure_id
order by sort_order asc;