/* -----------------------------------------------------------------
   ADVENTURE : Moonrise over Grayhollow  (Challenge Rating 3)
   Theme – A spreading lycanthropic curse threatens an isolated
           farming village; the heroes must end the moon-born plague.
------------------------------------------------------------------*/

/* main adventure ------------------------------------------------*/
INSERT INTO Adventure
        (name, theme, challenge_rating,
         spoiler_free_description,
         spoiler_description,
         number_of_players, level)
VALUES  ('Moonrise over Grayhollow',
         'Cursed Lycans',
         3,
         'Night after night, howls and screams echo across the valley as villagers vanish. The party must uncover the source of Grayhollow’s lycanthropic plague and stop it before the next full moon.',
         'The lycanthropy is spread by an ex-soldier, Sergeant Roul, whose unit unearthed a moon-stone altar on the moors. The curse now ripples through Grayhollow Village (Location 1) and the surrounding Hollow Moor (Location 2). Each encounter reveals clues: wererats skulk in the wells, raging wereboars torch barns, and Roul—now an alpha werewolf—rings the bell-tower to spread dread. The party must follow the infected into the moor, where cult fanatics shield the altar, wererats mine cursed silver, and the boar-king Garruk guards the cracked moon altar. Destroying the altar or slaying Garruk breaks the curse.',
         NULL, NULL);

SET @adventure_id := LAST_INSERT_ID();

/* ================================================================
   LOCATION 1 — GRAYHOLLOW VILLAGE
   ============================================================= */
INSERT INTO Location
        (adventure_id, name, description,
         map_width, map_height, map_url)
VALUES  (@adventure_id,
         'Grayhollow Village',
         'Cobblestone lanes, smouldering barns and frightened villagers ring a moon-washed square.',
         1000, 1000, '');

SET @loc_village := LAST_INSERT_ID();

/* ---------- Encounter A : Shattered Well --------------------- */
INSERT INTO Encounter
        (location_id, name, summary, read_aloud,
         sort_order, map_marker_symbol,
         map_marker_x, map_marker_y)
VALUES  (@loc_village,
         'Shattered Well',
         '',
         'Moonlight glints off BLOODIED COBBLESTONES around the village well; the BROKEN BUCKET ROPE sways as though recently severed, and a faint metallic glimmer hints at a HIDDEN SILVER LOCKET below.',
         1, 'A', 437, 812);

SET @enc_well := LAST_INSERT_ID();

/* points of interest */
INSERT INTO PointOfInterest
        (encounter_id, name, description, sort_order)
VALUES  (@enc_well,'Bloodied Cobblestones',
         'Sticky crimson traces and paw-prints form a chaotic spiral away from the well mouth.',1),
        (@enc_well,'Broken Bucket Rope',
         'Frayed hemp dangles, smelling of mildew and iron as water drips below.',2),
        (@enc_well,'Hidden Silver Locket',
         'A half-buried locket bearing the family crest of Mayor Ashford, proof of kidnapping.',3);

SET @poi1 := LAST_INSERT_ID()-2;   -- first PoI id
/* monsters (wererats) */
INSERT INTO PointOfInterestMonster
        (point_of_interest_id, sort_order,
         monster_id, number, custom_name)
VALUES  (@poi1,1,'wererat-hybrid',3,NULL);

/* ability checks */
INSERT INTO PointOfInterestAbilityCheck
        (point_of_interest_id, sort_order,
         ability, difficulty, description)
VALUES  (@poi1,2,'Wisdom (Perception)',12,
         'Notice a trail of muddy paw-prints leading toward the barn.'),
        (@poi1,3,'Strength (Athletics)',15,
         'Hoist the crumbling stone cap and descend safely.');

/* ---------- Encounter B : Burning Barn ----------------------- */
INSERT INTO Encounter
        (location_id,name,summary,read_aloud,
         sort_order,map_marker_symbol,map_marker_x,map_marker_y)
VALUES  (@loc_village,'Burning Barn','',
         'A roar of sparks and choking smoke billow from COLLAPSING HAYLOFT timbers. PANICKED LIVESTOCK bleat within as RAGING FLAMES lick sky-high, casting the scene in flickering orange.',
         2,'B',129,523);

SET @enc_barn := LAST_INSERT_ID();

INSERT INTO PointOfInterest
        (encounter_id,name,description,sort_order)
VALUES  (@enc_barn,'Collapsing Hayloft',
         'The upper loft groans; ember-filled rafters threaten to cave in.',1),
        (@enc_barn,'Panicked Livestock',
         'Cows and goats thrash against locked stalls, eyes wild.',2),
        (@enc_barn,'Raging Flames',
         'Heat-waves distort vision; the scent of burning pitch fills the lungs.',3);

SET @poi2 := LAST_INSERT_ID()-2;

/* monsters: wereboar-human (CR 4, humanoid) */
INSERT INTO PointOfInterestMonster
        (point_of_interest_id,sort_order,
         monster_id,number,custom_name)
VALUES  (@poi2,1,'wereboar-human',2,NULL);

INSERT INTO PointOfInterestAbilityCheck
        (point_of_interest_id,sort_order,ability,difficulty,description)
VALUES  (@poi2,2,'Dexterity (Acrobatics)',14,
         'Leap across a flaming beam to reach trapped animals and guide them out.'),
        (@poi2,3,'Wisdom (Animal Handling)',10,
         'Calm a frantic goat long enough to cut its tether.');

/* ---------- Encounter C : Midnight Bell-Tower --------------- */
INSERT INTO Encounter
        (location_id,name,summary,read_aloud,
         sort_order,map_marker_symbol,map_marker_x,map_marker_y)
VALUES  (@loc_village,'Midnight Bell-Tower','',
         'Bronze bells toll as the SPIRAL STAIRS creak upward. A CRACKED BELL ROPE swings violently, and high above in the MOONLIT BELFRY a lone figure howls against the silver glow.',
         3,'C',882,277);

SET @enc_bell := LAST_INSERT_ID();

INSERT INTO PointOfInterest
        (encounter_id,name,description,sort_order)
VALUES  (@enc_bell,'Spiral Stairs',
         'Dust-coated steps twist dizzyingly toward the belfry.',1),
        (@enc_bell,'Cracked Bell Rope',
         'Frayed strands slap stone rhythmically like a heartbeat.',2),
        (@enc_bell,'Moonlit Belfry',
         'Shattered shutters frame the full moon; claw-marks score the floor.',3);

SET @poi3 := LAST_INSERT_ID()-2;

/* monster: alpha werewolf (proper name) */
INSERT INTO PointOfInterestMonster
        (point_of_interest_id,sort_order,
         monster_id,number,custom_name)
VALUES  (@poi3,1,'werewolf-human',1,'Sergeant Roul');

INSERT INTO PointOfInterestAbilityCheck
        (point_of_interest_id,sort_order,ability,difficulty,description)
VALUES  (@poi3,2,'Charisma (Intimidation)',15,
         'Command the villagers below to flee, preventing casualties.');

/* ================================================================
   LOCATION 2 — HOLLOW MOOR
   ============================================================= */
INSERT INTO Location
        (adventure_id,name,description,
         map_width,map_height,map_url)
VALUES  (@adventure_id,
         'Hollow Moor',
         'A fog-laden expanse of peat bogs, ancient stone circles and abandoned silver mines.',
         1000,1000,'');

SET @loc_moor := LAST_INSERT_ID();

/* ---------- Encounter D : Foggy Standing Stones ------------- */
INSERT INTO Encounter
        (location_id,name,summary,read_aloud,
         sort_order,map_marker_symbol,map_marker_x,map_marker_y)
VALUES  (@loc_moor,'Standing Stones','',
         'Ghostly wisps coil between RUNED MENHIRS. DRIED BLOOD RITUAL RINGS crust the peat, and a HOODED FANATIC chants softly to the moon.',
         1,'D',311,648);

SET @enc_stones := LAST_INSERT_ID();

INSERT INTO PointOfInterest
        (encounter_id,name,description,sort_order)
VALUES  (@enc_stones,'Runed Menhirs',
         'Obsidian runes pulse with pale light whenever the moon emerges.',1),
        (@enc_stones,'Dried Blood Ritual Rings',
         'Coppery scent mixes with peat; dagger grooves mark each circle.',2),
        (@enc_stones,'Hooded Fanatic',
         'A silver-masked devotee offers prayers to a lunar sigil.',3);

SET @poi4 := LAST_INSERT_ID()-2;

/* monsters: Cult Fanatic (humanoid CR 2) */
INSERT INTO PointOfInterestMonster
        (point_of_interest_id,sort_order,
         monster_id,number,custom_name)
VALUES  (@poi4,1,'cult-fanatic',3,NULL);

INSERT INTO PointOfInterestAbilityCheck
        (point_of_interest_id,sort_order,ability,difficulty,description)
VALUES  (@poi4,2,'Intelligence (Arcana)',13,
         'Identify the ritual’s link to the moon-altar – disrupting the circle weakens future lycans.');

/* ---------- Encounter E : Silver Mine Entrance -------------- */
INSERT INTO Encounter
        (location_id,name,summary,read_aloud,
         sort_order,map_marker_symbol,map_marker_x,map_marker_y)
VALUES  (@loc_moor,'Silver Mine Entrance','',
         'Timber beams groan over a COLLAPSED TUNNEL. A GLIMMERING VEIN of raw silver catches torchlight, while distant skittering echoes through the ECHOING SHAFT.',
         2,'E',709,492);

SET @enc_mine := LAST_INSERT_ID();

INSERT INTO PointOfInterest
        (encounter_id,name,description,sort_order)
VALUES  (@enc_mine,'Collapsed Tunnel',
         'Fresh rubble blocks the main shaft; claw-marks score the beams.',1),
        (@enc_mine,'Glimmering Vein',
         'Raw silver—tainted black by blood—threads the wall.',2),
        (@enc_mine,'Echoing Shaft',
         'Wet air whistles; faint squeaks betray movement below.',3);

SET @poi5 := LAST_INSERT_ID()-2;

/* monsters: wererat-hybrid (humanoid CR 2) */
INSERT INTO PointOfInterestMonster
        (point_of_interest_id,sort_order,
         monster_id,number,custom_name)
VALUES  (@poi5,1,'wererat-hybrid',4,NULL);

INSERT INTO PointOfInterestAbilityCheck
        (point_of_interest_id,sort_order,ability,difficulty,description)
VALUES  (@poi5,2,'Strength (Athletics)',10,
         'Clear enough debris for Small creatures to squeeze through.'),
        (@poi5,3,'Dexterity (Sleight of Hand)',12,
         'Chip pure silver worth 25 gp without alerting the wererats.');

/* ---------- Encounter F : Cracked Moon Altar --------------- */
INSERT INTO Encounter
        (location_id,name,summary,read_aloud,
         sort_order,map_marker_symbol,map_marker_x,map_marker_y)
VALUES  (@loc_moor,'Cracked Moon Altar','',
         'A RUNE-CARVED SLAB splits under a beam of moonlight. RUSTED CHAINS litter the dais, and an OVERTURNED OFFERING BOWL spills crimson wax across the stone.',
         3,'F',946,183);

SET @enc_altar := LAST_INSERT_ID();

INSERT INTO PointOfInterest
        (encounter_id,name,description,sort_order)
VALUES  (@enc_altar,'Rune-Carved Slab',
         'Jagged fissures leak silver-blue radiance.',1),
        (@enc_altar,'Sacrificial Chains',
         'Iron shackles still warm to the touch despite the night air.',2),
        (@enc_altar,'Overturned Offering Bowl',
         'Congealed wax and bone fragments form a grisly mosaic.',3);

SET @poi6 := LAST_INSERT_ID()-2;

/* monster: Wereboar king (CR 4) */
INSERT INTO PointOfInterestMonster
        (point_of_interest_id,sort_order,
         monster_id,number,custom_name)
VALUES  (@poi6,1,'wereboar-human',1,'Boar-King Garruk');

INSERT INTO PointOfInterestAbilityCheck
        (point_of_interest_id,sort_order,ability,difficulty,description)
VALUES  (@poi6,2,'Intelligence (Investigation)',15,
         'Discover a hairline seam—driving a silver blade here will shatter the altar and end the curse.'),
        (@poi6,3,'Wisdom (Medicine)',10,
         'Harvest moon-touched herbs that grant advantage on future lycanthropy saves (one use).');
