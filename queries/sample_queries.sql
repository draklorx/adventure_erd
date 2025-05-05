/* NOTE: Because I'm dynamically generating keys I first have to select some keys. */
/* Because of this I recommend selecting the following set statements and running it first prior to running the remainder of the queries */

set @adventure_id := (select id from adventure where name = 'Garden of Stone');
set @location1_id := (select l.id from location l where l.adventure_id = @adventure_id order by l.sort_order limit 1);
set @encounter1_id := (select e.id from encounter e where e.location_id = @location1_id order by e.sort_order limit 1);
set @poi1_id := (select id from point_of_interest poi where poi.encounter_id = @encounter1_id order by poi.sort_order limit 1);
set @basilisk_id := (select id from monster where monster_index = 'basilisk');
set @arcana_id := (select id from ability where name = 'Intelligence (Arcana)');
set @athletics_id := (select id from ability where name = 'Strength (Athletics)');
set @investigation_id := (select id from ability where name = 'Intelligence (Investigation)');
set @hidden_hatch_poi_id := (select point_of_interest_id from point_of_interest_ability_check where ability_id = @investigation_id);

/* Get the adventure based on the name id is randomly generated so pulling based on name instead */
select * from adventure where id = @adventure_id;

/* Get the first encounter from the adventure */
select e.*
from encounter e 
join location l on e.location_id = l.id 
join adventure a on l.adventure_id = a.id 
where a.id = @adventure_id and l.sort_order = 1 and e.sort_order = 1;

/*get encounters containing a basilisk*/
select e.* 
from encounter e
join encounter_monster em on em.encounter_id = e.id
where em.monster_id = @basilisk_id;

/*get number of points of interest containing an arcana check*/
select count(1) 
from encounter e
join point_of_interest poi on poi.encounter_id = e.id
join point_of_interest_ability_check abcheck on abcheck.point_of_interest_id = poi.id
where abcheck.ability_id = @arcana_id
group by abcheck.ability_id;

/*Create a new check for the iron gate point of interest*/
insert into point_of_interest_ability_check
        (point_of_interest_id, ability_id, difficulty, description, sort_order)
values  (@poi1_id, @athletics_id, 9, 'Climb over the gate.', 1);

select read_aloud_text from encounter where id = @encounter1_id;

/*Update the encounter to remove mention of nettles and hidden hatch*/
update encounter 
set read_aloud_text = "A rust-bitten portcullis stands firmly closed beneath a collapsed arch. Moonlight glints on a tangle of vines which grown up through the **Iron Gate**."
where id = @encounter1_id;

/*Delete the Hidden Hatch point of interest, NOTE cascading means it will also delete the associated ability checks*/
delete from point_of_interest where id = @hidden_hatch_poi_id;

/*Let's check the updated encounter*/
select name header, read_aloud_text content
from encounter
where id = @encounter1_id
union
select name header, description content
from point_of_interest
where encounter_id = @encounter1_id
union
select concat (ability.name, " ", abcheck.difficulty) header, abcheck.description content
from encounter e
join point_of_interest poi on poi.encounter_id = e.id
join point_of_interest_ability_check abcheck on abcheck.point_of_interest_id = poi.id
join ability on abcheck.ability_id = ability.id
where e.id = @encounter1_id;