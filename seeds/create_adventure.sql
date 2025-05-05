/*
The following lines is used to clear adventure, ability_id, and monster data. The FK constraits will delete the rest. 
Deleting < 10000 is a quick and dirty way to delete all data in the database without having to update SQLWorkbench safe deete rules.
*/
delete from adventure where id < 10000;
delete from ability where id < 10000;
delete from monster where id < 10000;
/* ────────────────────────  ADVENTURE  ──────────────────────── */

INSERT INTO ability
        (name)
VALUES  ('Strength (Athletics)');
SET @athletics_id := LAST_INSERT_ID();
INSERT INTO ability
        (name)
VALUE ('Intelligence (Investigation)');
SET @investigation_id := LAST_INSERT_ID();
INSERT INTO ability
        (name)
VALUES  ('Intelligence (Arcana)');
SET @arcana_id := LAST_INSERT_ID();
INSERT INTO ability
        (name)
VALUES  ('Wisdom (Nature)');
SET @nature_id := LAST_INSERT_ID();
INSERT INTO ability
        (name)
VALUES  ('Dexterity (Thieves’ Tools)');
SET @thieves_tools_id := LAST_INSERT_ID();

INSERT INTO monster
        (monster_index)
VALUES  ('gargoyle');
SET @gargoyle_id := LAST_INSERT_ID();
INSERT INTO monster
        (monster_index)
VALUES  ('basilisk');
SET @basilisk_id := LAST_INSERT_ID();
INSERT INTO monster
        (monster_index)
VALUES  ('awakened-tree');
SET @awakened_tree_id := LAST_INSERT_ID();

INSERT INTO adventure
        (name, spoiler_free_description, spoiler_description, level, minimum_player_count, maximum_player_count)
VALUES  ('Garden of Stone',
         'Rumours tell of an abandoned estate where statues move and flowers sparkle with crystal dust. Brave souls are needed to end the strange curse.',
         'Decades ago, an eccentric noble installed a magical prism in his greenhouse. The prism now petrifies the grounds, animates stonework, and twists plants into predators.              \
The heroes must push past the shattered courtyard, navigate a maze of glass and greenery, and finally shatter the Heartstone Prism in the central conservatory.  \
Three key locations tie the story together:  (1) the Courtyard, where the first signs of animation appear; (2) the Crystal Greenhouse, alive with hostile flora; and (3)               \
the Prism Chamber itself, guarded by basilisk spawn and living statuary.',
         3, 4, 6);
SET @adventure_id = LAST_INSERT_ID();

/* ────────────────────────  LOCATIONS  ──────────────────────── */
INSERT INTO location
        (adventure_id, name, description, map_url, map_width, map_height, sort_order)
VALUES  (@adventure_id,
         'Shattered Courtyard',
         'Crumbling walls ring a once‑graceful courtyard now overrun with ivy. Jagged marble fragments crunch underfoot, and wind whistles through broken archways. \
Statues lean at odd angles as if frozen mid‑flight; some genuinely are. The courtyard introduces the creeping curse and hints at hidden passages leading to the inner gardens.',
         '', 1000, 1000, 1);
SET @location1_id = LAST_INSERT_ID();

INSERT INTO location
        (adventure_id, name, description, map_url, map_width, map_height, sort_order)
VALUES  (@adventure_id,
         'Crystal Greenhouse',
         'A cathedral of glass and wrought iron whose panes cast kaleidoscopic rainbows across tangled vines. Heat, mist, and the scent of wet earth fill the air. \
Strange orchids glow from within, while deeper inside a prism pulses with sinister light, warping flora and fauna alike. This is the adventure’s climax and source of the petrifying magic.',
         '', 1000, 1000, 2);
SET @location2_id = LAST_INSERT_ID();

/* ────────────────────────  ENCOUNTERS  (Location 1) ──────────────────────── */
/* Encounter 1A */
INSERT INTO encounter
        (location_id, name, read_aloud_text, summary, map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES  (@location1_id,
         'Overgrown Gate',
         'A rust‑bitten portcullis hangs half‑open beneath a collapsed arch. Moonlight glints on the tangled **Iron Gate**, while nettles mask a **Hidden Hatch** sunken into flagstones.',
         'The party first meets the estate. They can force the Iron Gate or discover a concealed hatch that bypasses the blockage.',
         234, 712, 1, 'A');
SET @encounter1_id = LAST_INSERT_ID();

/* Encounter 1B */
INSERT INTO encounter
        (location_id, name, read_aloud_text, summary, map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES  (@location1_id,
         'Broken Fountain Plaza',
         'Water no longer flows, yet a cracked bowl still dominates the square. Two winged shapes crouch atop the rim – the **Gargoyle Perch** – and a dark grate yawns at the base, leading to a **Mosaic Drain**.',
         'Animated gargoyles attack from the fountain; clever rogues can tamper with the drain that feeds water toward the greenhouse.',
         480, 515, 2, 'B');
SET @encounter2_id = LAST_INSERT_ID();

/* Encounter 1C */
INSERT INTO encounter
        (location_id, name, read_aloud_text, summary, map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES  (@location1_id,
         'Statue Walk',
         'Marble effigies line a cracked path. One, the **Cracked Statue**, seems freshly shattered; beside it lies a dusty **Petrified Backpack** still clasped by stone fingers.',
         'The cracked statue hides a lurking basilisk. Clues in the backpack reveal the prism’s existence and hint at an antidote.',
         760, 300, 3, 'C');
SET @encounter3_id = LAST_INSERT_ID();

/* ────────────────────────  ENCOUNTERS  (Location 2) ──────────────────────── */
/* Encounter 2A */
INSERT INTO encounter
        (location_id, name, read_aloud_text, summary, map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES  (@location2_id,
         'Steaming Orchid Rows',
         'Glass shards crunch as you enter rows of towering, mist‑wreathed stalks. A hulking **Awakened Tree** groans as roots crack tiles, and clusters of **Glowing Orchids** pulse with eerie light.',
         'An awakened tree blocks progress; harvesting luminous orchids can weaken the final prism.',
         210, 640, 1, 'A');
SET @encounter4_id = LAST_INSERT_ID();

/* Encounter 2B */
INSERT INTO encounter
        (location_id, name, read_aloud_text, summary, map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES  (@location2_id,
         'Reflecting Pool',
         'A rectangular basin mirrors the shattered ceiling in its still surface. The water shimmers – the **Silver Waters** – while a faint outline beneath hints at a **Submerged Lever**.',
         'Solving the pool’s mechanism drains water to expose a passage that loops back toward the courtyard for shortcuts.',
         520, 410, 2, 'B');
SET @encounter5_id = LAST_INSERT_ID();

/* Encounter 2C */
INSERT INTO encounter
        (location_id, name, read_aloud_text, summary, map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES  (@location2_id,
         'Heartstone Chamber',
         'In the domed heart of the greenhouse floats the faceted **Heartstone Prism**, bathing vines in kaleidoscopic light. Coiled nearby, eyes gleaming with the same hues, waits a **Guardian Basilisk**.',
         'Destroying the prism ends the curse, but first the basilisk – prism‑empowered – must be defeated.',
         820, 250, 3, 'C');
SET @encounter6_id = LAST_INSERT_ID();

/* ────────────────────────  POINTS OF INTEREST & MECHANICS  ──────────────────────── */
/* Encounter 1A POIs */
INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter1_id, 'Iron Gate',
         'A clotted mass of vines seals the bars. Brute force or cleaving the growth frees the gateway.', 1);
SET @poi1_id = LAST_INSERT_ID();

INSERT INTO point_of_interest_ability_check
        (point_of_interest_id, ability_id, difficulty, description, sort_order)
VALUES  (@poi1_id, @athletics_id, 15, 'With a heave, characters wrench the portcullis high enough to slip through.', 1);

INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter1_id, 'Hidden Hatch',
         'A half‑rotted wooden panel conceals a ladder into servants’ tunnels.', 2);
SET @poi2_id = LAST_INSERT_ID();

INSERT INTO point_of_interest_ability_check
        (point_of_interest_id, ability_id, difficulty, description, sort_order)
VALUES  (@poi2_id, @investigation_id, 13, 'Noticing a draft reveals the hatch outline; opening it grants an alternate route.', 1);

/* Encounter 1B POIs */
INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter2_id, 'Gargoyle Perch',
         'Stone sentinels spring to life, clawing at intruders from their lofty rim.', 1);
SET @poi3_id = LAST_INSERT_ID();

INSERT INTO encounter_monster
        (encounter_id, monster_id, number, custom_name, sort_order)
VALUES  (@encounter2_id, @gargoyle_id, 2, NULL, 1);

INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter2_id, 'Mosaic Drain',
         'Broken tiles hide a rusted grate leading to channels beneath the fountain.', 2);
SET @poi4_id = LAST_INSERT_ID();

INSERT INTO point_of_interest_ability_check
        (point_of_interest_id, ability_id, difficulty, description, sort_order)
VALUES  (@poi4_id, @thieves_tools_id, 14, 'Popping the grate uncovers a crawlspace toward the greenhouse.', 1);

/* Encounter 1C POIs */
INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter3_id, 'Cracked Statue',
         'A hollow statue hides a lurking predator, its marble shell ready to shatter further.', 1);
SET @poi5_id = LAST_INSERT_ID();

INSERT INTO encounter_monster
        (encounter_id, monster_id, number, custom_name, sort_order)
VALUES  (@encounter3_id, @basilisk_id, 1, NULL, 1);

INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter3_id, 'Petrified Backpack',
         'Stone‑locked leather holds journals describing an arcane prism amplifying basilisk gazes.', 2);
SET @poi6_id = LAST_INSERT_ID();

INSERT INTO point_of_interest_ability_check
        (point_of_interest_id, ability_id, difficulty, description, sort_order)
VALUES  (@poi6_id, @arcana_id, 12, 'Deciphering notes gives clues to neutralising the prism.', 1);

/* Encounter 2A POIs */
INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter4_id, 'Awakened Tree',
         'Roots rip floor tiles while thorny limbs lash out.', 1);
SET @poi7_id = LAST_INSERT_ID();

INSERT INTO encounter_monster
        (encounter_id, monster_id, number, custom_name, sort_order)
VALUES  (@encounter4_id, @awakened_tree_id, 1, NULL, 1);

INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter4_id, 'Glowing Orchids',
         'Phosphorescent blooms emit faint anti‑petrification spores when carefully harvested.', 2);
SET @poi8_id = LAST_INSERT_ID();

INSERT INTO point_of_interest_ability_check
        (point_of_interest_id, ability_id, difficulty, description, sort_order)
VALUES  (@poi8_id, @nature_id, 13, 'Correct handling yields petals that grant advantage on next save vs. petrification.', 1);

/* Encounter 2B POIs */
INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter5_id, 'Silver Waters',
         'Magically infused water mirrors illusions; decoding symbols on its surface reveals hidden mechanisms.', 1);
SET @poi9_id = LAST_INSERT_ID();

INSERT INTO point_of_interest_ability_check
        (point_of_interest_id, ability_id, difficulty, description, sort_order)
VALUES  (@poi9_id, @arcana_id, 15, 'Interpreting runes shows how to drain the pool.', 1);

INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter5_id, 'Submerged Lever',
         'A corroded handle lies just beyond reach under freezing water.', 2);
SET @poi10_id = LAST_INSERT_ID();

INSERT INTO point_of_interest_ability_check
        (point_of_interest_id, ability_id, difficulty, description, sort_order)
VALUES  (@poi10_id, @athletics_id, 14, 'Hauling the lever down empties the pool and unlocks a shortcut tunnel.', 1);

/* Encounter 2C POIs */
INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter6_id, 'Heartstone Prism',
         'A multifaceted crystal rotating in mid‑air, humming with magical energy. Striking true fractures it; shattering ends the curse.', 1);
SET @poi11_id = LAST_INSERT_ID();

INSERT INTO point_of_interest_ability_check
        (point_of_interest_id, ability_id, difficulty, description, sort_order)
VALUES  (@poi11_id, @arcana_id, 17, 'Finding the right resonance lets heroes weaken the prism before it explodes.', 1);

INSERT INTO point_of_interest
        (encounter_id, name, description, sort_order)
VALUES  (@encounter6_id, 'Guardian Basilisk',
         'A prism‑infused basilisk whose scales refract rainbow light, doubling its lethal gaze.', 2);
SET @poi12_id = LAST_INSERT_ID();

INSERT INTO encounter_monster
        (encounter_id, monster_id, number, custom_name, sort_order)
VALUES  (@encounter6_id, @basilisk_id, 1, 'Prism Guardian', 1);
