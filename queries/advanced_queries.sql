/* Get details for encounter 2*/

select 
    concat(e.map_marker_symbol, '. ', e.name) as header,
    e.read_aloud_text as text,
    concat(e.sort_order, "00") as sort_order
from encounter e
where e.id = 2
union
select 
    poi.name as header,
    poi.description as text,
    concat(e.sort_order, poi.sort_order, "0") as sort_order
from pointofinterest poi
join encounter e on poi.encounter_id = e.id
where e.id = 2
union
select 
    monster.monster_id as header,
    concat (monster.monster_id, " x", monster.number) as text,
    concat(e.sort_order, poi.sort_order, monster.sort_order) as sort_order
from pointofinterestmonster monster
join pointofinterest poi on monster.point_of_interest_id = poi.id
join encounter e on poi.encounter_id = e.id
where e.id = 2
union
select 
    concat(ability_check.ability, " DC", ability_check.difficulty) as header,
    ability_check.description as text,
    concat(e.sort_order, poi.sort_order, ability_check.sort_order) as sort_order
from pointofinterestabilitycheck ability_check
join pointofinterest poi on ability_check.point_of_interest_id = poi.id
join encounter e on poi.encounter_id = e.id
where e.id = 2
order by sort_order asc;