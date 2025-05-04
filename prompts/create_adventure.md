Referencing #file:5e-SRD-Monsters-Simplified.json and #file:001-create-tables-mysql.sql

You are an expert dungeon master and creative adventure writer who also happens to be good at organizing your adventures in a SQL database. When writing an adventure you should choose an overall theme, plot, and a challenge rating between 1 and 5. Any monsters placed in the adventure should be within 1 of this challenge rating. All locations, encounters, monsters, etc. should fit the theme of the adventure.

Reference the 001-create-tables-mysql.sql file to create a series of insert statements to create a new adventure. After generating each record you should store LAST_INSERT_ID() in a unique variable to be used as a reference for future inserts. You should specify the included fields in the details below when creating your insert statements. These columns should be listed before the VALUES keyword, and the individual values to fill those columns.

**adventure**
Create an adventure record. After creating the adventure store its id in @adventure_id. It should have the following:
- name: The name of the adventure
- spoiler_free_description: A preview of the adventure explaining things in broad terms without giving away what's actually going on. This should be short, evocative, and entice people to want to play the adventure.
- spoiler_description: A detailed description of the adventure that describes the overall plot in detail. It should provide an overall summary of the locations and encounters within the adventure.
- level: Set to 0 for now.
- number_of_players: Set to 0 for now

**location**
Create 2 to 3 location records. These locations should be tied together neratively to make an overarching story for the adventure. After creating each location you should store their id in @location1_id, @location2_id, and so on. They should have the following:
- adventure_id: The id of the adventure this is tied to. Reference @adventure_id
- name: The name of this location
- description: One to two paragraphs. An evocative description of the area in general. Its features, the sights, smells, and sounds. There should be an overall description of the encounters, events, and how the area fits into the plot of the adventure.
- map_url: Leave this blank for now.
- map_width: 1000
- map_height: 1000
- sort_order: The order in which this location should appear in the narrative. Start with 1 and count up.

**encounter**
Each location should have between 3 to 5 encounter records. These encounters should be tied together neratively. Each encounter should have some combination of characters to interact with, monsters to fight, or hidden things to explore and discover. After inserting each encounter you sould immediately create a variable named something like @encounter1_id, @encounter2_id, and so on. They should include the following:
- location_id: The unique id of the location this encounter belongs to referencing the variables set for location ids.
- name: The name of the encounter, should reflect its location
- read_aloud_text: This should be a paragraph or two of text. It should describe the area of the encounter in general terms from the perspective of the players. The description should be evocative detailing overall sights, sounds, and smells. The encounter text should include call outs to specific places, characters, monsters, or things within the encounter. These words represent points of interest in the encounter. The read_aloud_text can elude to hidden monsters, characters, or items, but it should not outright include them in the text.
- summary: This should be a brief paragraph of text detailing an overall description of the encounter for quick reference. It should include every point of interest and enough description to understand the details of the encounter and the points of interest within while keeping it short.
- map_marker_x: Choose a random number between 100 and 900.
- map_marker_y: Choose a random number between 100 and 900.
- sort_order: The order in which the encounters should appear within the location. Start with 1 and increase by 1 for each additional encounter in that particular location.
- map_marker_symbol: This should tie to the encounter's sort order. It should be a single letter and increase by one for each encounter in the location in alphabetical order, i.e., A, B, C, etc.

**point_of_interest**
Each encounter should have between 1 and 5 points of interest to explore further. Each point of interest represents a character to interact  with, a monster to fight, a detail to explore further, a hidden object to find, etc. After each record is inserted you should immediately create a new point_of_interest id variable called like @poi1_id, @poi2_id, etc. Each point_of_interest record should include:
- encounter_id: The unique id of the encounter that this point of interest is tied to. You should use the reference variables created after inserting each encounter.
- name: The name of this point of interest. This name should be the same as the bolded text in the read_aloud_text of the encounter.
- description: A paragraph of text describing in further detail what this point of interest is. Any fine details. It should elude to the monsters or ability checks tied to this point of interest.
-sort_order: The order in which this point of interest should appear within the encounter. Starts at 1, goes up by 1 for each additional point of interest.

IMPORTANT:
The following two tables, point_of_interest_ability_check and point_of_interest_monster, represent mechanical details of a point of interest. Each point of interest should include at least one of these but can include up to five of one, the other, or both. Their sort order is jointly represented so that if an point of interest includes a monster, and two ability checks, the sort order for the monster record would be 1, and the sort_order for the two ability checks to be listed after would be 2 and 3.

**point_of_interest_ability_check**
An ability check tied to a point_of_interest record. This represents a skill check for the player exploring this area to over come. Each record should include the following:
- point_of_interest_id: The unique id of the point of interest this encounter is tied to. Use the reference variable created as part of creating points ofinterest.
- ability: The ability and or skill that this check is tied to.
- difficulty: The difficulty should be between 5 and 25 where 5 is trivial, 10 is easy, 15 is medium, 20 is difficult, and 25 is nearly impossible. Difficulties less than 10 or above 20 should be very rare!
- description: This is the description of what should happen if the ability check succeeds.
- sort_order: The order in which this ability check appears within the point of interest.

**point_of_interest_monster**
A monster or a group of monsters within the point_of_interest. Each record should include the following:
- monster_id: This should be selected from on of the monster's index value in the attached 5e-SRD-Monsters-Simplified json file. When choosing monsters each monster should match the challenge rating and theme chosen when coming up with the initial adventure concept.
- number: How many of this monster are there. Typically between 1 and 3.
- custom_name: Optional. Does the monster have a proper name? Does the group of monsters have an adjective?
- sort_order: The order in which this monster appears within the point of interest.