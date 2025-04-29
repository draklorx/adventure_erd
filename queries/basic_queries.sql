/* get all adventures */
select * from adventure;

/* get all locations for adventure 4 */
select * from location where adventure_id = 4 order by sort_order;

/* get all encounters for location 3 */
select * from encounter where location_id = 3 order by sort_order asc;

/* get all points of interest for encounter 2 */
select * from pointofinterest where encounter_id = 2 order by sort_order asc;

/* get ability checks and monsters for point of interest 4 */
select 'ability check' as type, ability_check_id as id, point_of_interest_id, sort_order from pointofinterestabilitycheck where point_of_interest_id = 4
union
select 'monster' as type, monster_id as id, point_of_interest_id, sort_order from pointofinterestmonster where point_of_interest_id = 4
order by sort_order;

/* get the wererat monsters for point of interest 4 */
select * from pointofinterestmonster where monster_id = 'wererat-hybrid' and point_of_interest_id = 4;

/* get the ability check 1 for point of interest 4 */
select * from pointofinterestabilitycheck where ability_check_id = 1 and point_of_interest_id = 4;

/* get the ability check 2 for point of interest 4 */
select * from pointofinterestabilitycheck where ability_check_id = 2 and point_of_interest_id = 4;

