/* ---------- ADVENTURE ---------- */
INSERT INTO adventure
  (name, spoiler_free_description, spoiler_description, level, number_of_players)
VALUES
  ('The Verdant Veil',
   'An eerie mist coils through an ancient forest where travelers vanish beneath emerald boughs.',
   'The once-gentle Whispering Glade is rotting under the secret rule of the green hag “Granny Mirk.” \
Arachnid horrors, petrifying ponds, and phase-ripped webs threaten anyone who enters.  Adventurers must trace the corruption \
from the glade’s edges, survive its mutated guardians, descend into the hag’s root-choked hollow, and shatter the Heartseed \
Crystal that anchors her curse.',
   0, 0);
SET @adventure_id = LAST_INSERT_ID();


/* ---------- LOCATIONS ---------- */
INSERT INTO location
  (adventure_id, name, description, map_url, map_width, map_height, sort_order)
VALUES
  (@adventure_id, 'Whispering Glade',
   'Moss-draped trunks lean like gossiping elders beneath drifting silver mist.  Rope-thick webs span clearings, \
moonlit pools gleam with statues in mid-panic, and the once-singing heart-tree now hangs wrapped in silk and sorrow.',
   '', 1000, 1000, 1),
  (@adventure_id, 'Hag\'s Hollow',
   'A cavern lattice of tangled roots and glowing fungi beneath the forest floor.  Phase-ripped webs shiver in stale air, \
a cauldron belches caustic steam, and warped trophies of woodland beasts rot in amber resin around the hag’s cursed Heartseed.',
   '', 1000, 1000, 2);
SET @loc1_id = LAST_INSERT_ID() - 1;   -- Whispering Glade
SET @loc2_id = LAST_INSERT_ID();       -- Hag’s Hollow


/* ===================================================================== */
/* ========================  LOCATION 1 ENCOUNTERS  ===================== */
/* ===================================================================== */

/* ---------- Encounter 1A : Gossamer Bridge ---------- */
INSERT INTO encounter
  (location_id, name, read_aloud_text, summary,
   map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES
  (@loc1_id, 'Gossamer Bridge',
   'Sticky white cords form a sagging **Webbed Span** over a laughing brook.  Half-mummified beasts dangle as grim charms \
while a **Hidden Ettercap** plucks silken tripwires from a knot of branches.  At the span’s midpoint, a glass **Luring Lantern** \
pulses with ghost-green light, beckoning the unwary.',
   'A clogged spider-bridge blocks the path; clearing it (Athletics 15) exposes an Ettercap ambush and a faintly magical lure orb.',
   412, 678, 1, 'A');
SET @enc1a_id = LAST_INSERT_ID();

/* Points of Interest */
INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc1a_id, 'Webbed Span',
   'Layers of elastic silk bind the bridge.  Cutting or burning them without collapsing the span is tricky but possible.', 1);
SET @poi1_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi1_id, 'Strength (Athletics)', 15, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc1a_id, 'Hidden Ettercap',
   'The skittering spider-herd lurks above, ready to drop on separated prey.', 2);
SET @poi2_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_monster
  (point_of_interest_id, monster_id, number, custom_name, sort_order)
VALUES
  (@poi2_id, 'ettercap', 1, NULL, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc1a_id, 'Luring Lantern',
   'A fist-sized orb emits illusionary firefly lights.  Studying the runes reveals its fey craft and lets it be safely dimmed.', 3);
SET @poi3_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi3_id, 'Intelligence (Arcana)', 13, 1);



/* ---------- Encounter 1B : Moonlit Pond ---------- */
INSERT INTO encounter
  (location_id, name, read_aloud_text, summary,
   map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES
  (@loc1_id, 'Moonlit Pond',
   'Pale moonlight—despite the canopy—mirrors on a **Silvery Water** pool ringed by moss-covered statues.  A pair of \
**Basilisk Sentinels** bask upon a fallen log, their gaze sweeping the bank.  Near the shore, a toppled **Runestone Idol** \
hums with dormant warding magic.',
   'Investigating the pond risks basilisk petrification; perceptive heroes spot the danger, defeat the basilisks, and may reactivate a protective rune.',
   233, 512, 2, 'B');
SET @enc1b_id = LAST_INSERT_ID();

/* POIs */
INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc1b_id, 'Silvery Water',
   'Reflections show moving stars even on cloudy nights; ripples reveal stone fish—previous victims of petrification.', 1);
SET @poi4_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi4_id, 'Wisdom (Perception)', 12, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc1b_id, 'Basilisk Sentinels',
   'Territorial reptiles glare across the pond, turning intruders to stone for their mistress.', 2);
SET @poi5_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_monster
  (point_of_interest_id, monster_id, number, custom_name, sort_order)
VALUES
  (@poi5_id, 'basilisk', 2, NULL, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc1b_id, 'Runestone Idol',
   'A weathered menhir engraved with druidic sigils once shielded the glade; re-aligning shards could reignite its ward.', 3);
SET @poi6_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi6_id, 'Intelligence (Religion)', 14, 1);



/* ---------- Encounter 1C : Verdant Heart ---------- */
INSERT INTO encounter
  (location_id, name, read_aloud_text, summary,
   map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES
  (@loc1_id, 'Verdant Heart',
   'A colossal **Silk-Bound Oak** rises at the grove’s center, its crown muffled by web-shrouds.  Two **Phase Spider Hunters** \
slip between this world and the Feywild along glistening strands.  Runes of emerald fire spiral around an exposed **Fey Glyph** \
carved into the bark—its light sputtering under the hag’s curse.',
   'Clearing the webs (Athletics 16) exposes phase-spider guardians.  Solving the glyph’s magic may pulse life back into the oak or open a path below.',
   744, 295, 3, 'C');
SET @enc1c_id = LAST_INSERT_ID();

/* POIs */
INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc1c_id, 'Silk-Bound Oak',
   'The once-sacred tree is suffocating beneath cocoons.  Cutting them free could let the oak heal—and shower heroes in acidic spider eggs.', 1);
SET @poi7_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi7_id, 'Strength (Athletics)', 16, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc1c_id, 'Phase Spider Hunters',
   'The spiders blink in and out of existence, striking from ethereal silk-lines anchored to other planes.', 2);
SET @poi8_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_monster
  (point_of_interest_id, monster_id, number, custom_name, sort_order)
VALUES
  (@poi8_id, 'phase-spider', 2, NULL, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc1c_id, 'Fey Glyph',
   'Intricate sigils flare green when touched.  Deciphering them reveals a binding spell and a route into the underground hollow.', 3);
SET @poi9_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi9_id, 'Intelligence (Arcana)', 17, 1);



/* ===================================================================== */
/* ========================  LOCATION 2 ENCOUNTERS  ===================== */
/* ===================================================================== */

/* ---------- Encounter 2A : Root-Tangle Tunnel ---------- */
INSERT INTO encounter
  (location_id, name, read_aloud_text, summary,
   map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES
  (@loc2_id, 'Root-Tangle Tunnel',
   'Winding passages formed by knotted roots squeeze into claustrophobic corridors.  Hanging tendrils form a choking \
**Clinging Roots** curtain.  A lurking **Phase Spider Stalker** waits between worlds, while phosphorescent fungi swell into \
a **Pulsing Spore Cloud** with every footfall.',
   'Navigating the tunnel requires forcing past roots (Athletics 14), surviving a phase-spider strike, and braving choking spores (Con save 15).',
   321, 842, 1, 'A');
SET @enc2a_id = LAST_INSERT_ID();

/* POIs */
INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc2a_id, 'Clinging Roots',
   'Tough, wet roots knit together, tugging at weapons and clothes.', 1);
SET @poi10_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi10_id, 'Strength (Athletics)', 14, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc2a_id, 'Phase Spider Stalker',
   'This loner hunts anything entering the hollow, dragging prey to hidden egg sacs.', 2);
SET @poi11_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_monster
  (point_of_interest_id, monster_id, number, custom_name, sort_order)
VALUES
  (@poi11_id, 'phase-spider', 1, NULL, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc2a_id, 'Pulsing Spore Cloud',
   'Fungal bulbs swell, then burst into violet motes that sting lungs and blur vision.', 3);
SET @poi12_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi12_id, 'Constitution (Con Save)', 15, 1);



/* ---------- Encounter 2B : Cauldron Chamber ---------- */
INSERT INTO encounter
  (location_id, name, read_aloud_text, summary,
   map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES
  (@loc2_id, 'Cauldron Chamber',
   'A cavern cathedral glows green from a gargantuan **Bubbling Cauldron** set amid runic channels.  \
The crooked matron **Granny Mirk** stirs her brew, cackling curses, while a shackled **Owlbear Prisoner** thrashes in an iron cage.',
   'Disrupting the cauldron (Arcana 16) weakens the hag.  Granny Mirk fights savagely; freeing the owlbear may earn a furious ally—or another threat.',
   579, 633, 2, 'B');
SET @enc2b_id = LAST_INSERT_ID();

/* POIs */
INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc2b_id, 'Bubbling Cauldron',
   'Seething green ichor spits sparks.  Glyph-lined rivulets feed it from the ley-lines of the forest.', 1);
SET @poi13_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi13_id, 'Intelligence (Arcana)', 16, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc2b_id, 'Granny Mirk',
   'The green hag wears a shawl of mummified sprites and wields illusions like knives.', 2);
SET @poi14_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_monster
  (point_of_interest_id, monster_id, number, custom_name, sort_order)
VALUES
  (@poi14_id, 'green-hag', 1, 'Granny Mirk', 1);
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi14_id, 'Charisma (Deception)', 14, 2);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc2b_id, 'Owlbear Prisoner',
   'A mangy owlbear, drugged and chained, thrashes in pain—its beak ringed with cruel thorns.', 3);
SET @poi15_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_monster
  (point_of_interest_id, monster_id, number, custom_name, sort_order)
VALUES
  (@poi15_id, 'owlbear', 1, NULL, 1);
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi15_id, 'Wisdom (Animal Handling)', 15, 2);



/* ---------- Encounter 2C : Crumbling Sanctum ---------- */
INSERT INTO encounter
  (location_id, name, read_aloud_text, summary,
   map_marker_x, map_marker_y, sort_order, map_marker_symbol)
VALUES
  (@loc2_id, 'Crumbling Sanctum',
   'A cathedral-like vault where cracked ley-lines converge on a skyward **Ley-Stone Pillar**.  \
An enslaved **Ettin Guardian** lumbers amid shattered idols, chained to obedience.  Atop the pillar, the pulsing **Heartseed Crystal** \
beats like a sick heart, feeding corruption up into the roots.',
   'Breaking the crystal ends the curse, but the ettin defends it ferociously.  Destroying or dispelling the pillar’s wards (Arcana 18) \
can sever the hag’s anchor permanently.',
   811, 402, 3, 'C');
SET @enc2c_id = LAST_INSERT_ID();

/* POIs */
INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc2c_id, 'Ley-Stone Pillar',
   'Cracked stone veined with emerald energy hums with unstable power; the rune lattice can be redirected or shattered.', 1);
SET @poi16_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi16_id, 'Intelligence (Arcana)', 18, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc2c_id, 'Ettin Guardian',
   'Two brutish heads argue over how best to squish intruders, even while swinging a tree-trunk club.', 2);
SET @poi17_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_monster
  (point_of_interest_id, monster_id, number, custom_name, sort_order)
VALUES
  (@poi17_id, 'ettin', 1, NULL, 1);

INSERT INTO point_of_interest (encounter_id, name, description, sort_order)
VALUES
  (@enc2c_id, 'Heartseed Crystal',
   'A fist-sized gem pulses with corrupt life-force; dislodging it or shattering it on sacred ground ends the veil.', 3);
SET @poi18_id = LAST_INSERT_ID();
INSERT INTO point_of_interest_ability_check
  (point_of_interest_id, ability, difficulty, sort_order)
VALUES
  (@poi18_id, 'Dexterity (Sleight of Hand)', 17, 1);
