 ## Elemental Affinity
 
 - The player starts with 4 Mana crystals.
 - After a crystal is used up, it slowly regens mana.
 - If the crystal was used for a spell of primary alignment to the player, it regens quicker.

 - Player right clicks to cycle current alignment. 
 - Player can have 4 alignments total 
 - Player can choose one to be his primary aligment:
   - damage from that alignment 1.5x
   - mana regen 2x 
 - Player can instead choose no alignment:
   - mana regen from all alignements 1.25x
 - Primary Alignment Restrictions:
   - choosing necrotic locks life magic from being one of 4 alignments
   - choosing life locks necrotic magic from being one of 4 alignments

## Spell Descriptions

### Archetype (or generic spell description)
#### Basic Attack:
 - left click attack
 - costs 0 mana to use
 - shoots from caster towards mouse position at time of click
 - can be classed as very light, light, normal, heavy, very heavy
 - class affects travel time and damage dealt
#### Wall spell:
 - casted with (key)
 - costs 1 crystal to use
 - typically creates a wall
#### Side spell:
 - casted with (key)
 - costs 2 crystals to use
 - casted from the caster horizontally to the side with the mouse
 - some can be sustained and require holding down (key) to sustain
#### Platform spell:
 - casted with (key)
 - costs 3 crystals to use
 - casted on platform below mouse
 - permanent?

### Water  

| Property | Value |
| -- | -- |
| Icon | water droplet
| Enscription | 水 [water]
| Color | `#2196F3 rgb(3,169,244)`

#### Basic Attack: water droplet
 - congeled mass of water
 - heavy
#### Wall spell: gyser
 - gyser erupts from the ground
 - pushes ent/obj upward if they are there when it erupts
 - pushes ent/obj away if they get too close 
#### Side spell: water jet
 - stream of water erupts from caster to target side (left/right)
 - pushes ent/obj away if hit
 - sustaining costs 4% mana per sec
#### Platform spell: whirlpool
 - whirpool appears on target platform
 - pulls ent/obj towards its center

### Ice

| Property | Value |
| -- | -- |
| Icon | ice crystal
| Enscription |  寒気 [chill, cold, freeze]
| Color | `#00BCD4 rgb(0,188,212)`

#### Basic Attack: ice crystal
 - small crystal of ice
 - normal
#### Wall spell: ice pillar
 - frozen pillar of ice forms
 - if ent/obj in way, fozen
#### Side spell: "freeze ray"
 - cloud of ice magic from caster towards target
 - travels a set distance before disappating
 - if ent/obj hit, frozen
#### Platform spell: ice patch
 - ice patch appears on target platform
 - obj/ent slide accross
 - small chance to freeze obj/ent on top

### Fire 

| Property | Value |
| -- | -- |
| Icon | fire
| Enscription | 炎 [flame]
| Color | `#FF5722 rgb(255,87,34)`

#### Basic Attack: fireball
 - fireball
 - light
#### Wall spell: fire pillar
 - column of fire erupts from ground
 - deals high damage to obj/ent in it
#### Side spell: fire turret
 - a turrent appears and spews fire horizontally away from caster for a time
#### Platform spell: path of coals
 - hot coals appear on target platform
 - obj/ent take compounding damage longer on top 

### Ground  

| Property | Value |
| -- | -- |
| Icon | mountain
| Enscription | 土 [soil, earth]
| Color | `#795548 rgb(121,85,72)`

#### Basic Attack: rock
 - a rock
 - heavy
#### Wall spell: rock pillar
 - pillar of rock erupts from ground
 - knocks back obj/ent and stuns them
#### Side spell: mud splat
 - splatter rocks, mud and sand in the direction caster is looking
 - chance to stun obj/ent
 - chance to root obj/ent
#### Platform spell: quicksand
 - creates a plot of quicksand on target platform
 - obj/ent sink and become entombed permanently

### Air 

| Property | Value |
| -- | -- |
| Icon | cloud
| Enscription |  風 [wind, breeze, gale]
| Color | `#9E9E9E rgb(158,158,158)`

#### Basic Attack: air gust
 - a cloud
 - very light
#### Wall spell: tornado
 - tornado forms at target
 - obj/ent are pulled towards and kept inside
 - deals more damage more obj/ent inside
#### Side spell: sustained wind
 - gust of wind from caster towards target
 - sustain for 1% mana per second
#### Platform spell: updraft
 - creates an area with a strong updraft on a platform
 - obj/ent buffeted upward and move slowly through it
 - player gets jump boost if in it

### Electric  

| Property | Value |
| -- | -- |
| Icon | lightning
| Enscription | 稲妻 [lightning]
| Color | `#FFEB3B rgb(255,235,59)`


#### Basic Attack: lightning bolt
 - a short lightning bolt
 - light
#### Wall spell: lightning storm
 - a slim lightning storm forms on target
 - constant stream of lightning bolts from cloud to ground until end
 - obj/ent are stunned on getting hit by lightning (in addition to dmg)
#### Side spell: lightning ball
 - a ball of lightning leaves the caster towards the target
 - shoots of lightning bolts towards obj/ent
 - these lightning bolts jump 1 - 3 obj/ent if they can
 - ball of lightning contains 4 total lightning bolts 
 - once all bolts have hit a target, ball disappears
#### Platform spell: charged turf / static electricity (small zap dmg to those on top)
 - creates an area of strong static electricity on target platform
 - obj/ent passing through have high chance to get stunned
 - obj/ent passing through take intermittent shock dmg

## Life 

| Property | Value |
| -- | -- |
| Icon | leaf
| Enscription |  生命 [life, existence]
| Color | `#4CAF50 rgb(76,175,80)`

#### Basic Attack: leaf
 - a leaf
 - normal
#### Wall spell: overgrowth (grow plant wall)
 - a wall of vines and leaves grows at target
 - entombs obj/ent in way when growing
#### Side spell: "vine whip"
 - shoots vine from caster
 - can hold (key) to use ala hookshot (horizontally)
#### Platform spell: snares
 - 10 snares appear on target platform
 - snares root obj/ent 
 - if obj/ent dies/disappears from activated snare, it re-arms

## Necrotic 

| Property | Value |
| -- | -- |
| Icon | skull & crossbones
| Enscription | 荒廃 [devastation, ruin, dilapidation, decay]
| Color | `#212121 rgb(33,33,33)`

#### Basic Attack: dark sphere
 - a small black ball
 - very heavy (x-was normal-x)
#### Wall spell: summon undead (leaves gravestone)
 - chance to summon one of X undead
 - summoned undead help the player for Y sec
 - leaves a gravestone which lasts for Y ? sec
 - if obj/ent in place where summoned, pushed to side
#### Side spell: homing sphere
 - a medium black ball
 - homes towards enemies
 - does splash damage on hit
#### Platform spell: dead zone (take "piercing" dmg while in zone)
 - creates an area with a necrotic aura
 - obj/ent take damage that ignores magic resistence (not necrotic resistence)
 - obj/ent take damage that ignores armor
 - obj/ent that die in zone chance to turn into undead

### Arcane

| Property | Value |
| ----- | ----- |
| Icon | magic orb |
| Enscription | 魔法 [magic, sorcery] |
| Color | `#673AB7 rgb(103,58,183)` |

#### Basic Attack: "magic" ball
 - small magic ball
 - normal
#### Wall spell: magic wall ala "reflect"
 - an arcane wall appears at target
 - negates magic that passes through it
 - slows enemies walking through it
#### Side spell: magically stable mini black hole
 - an expanding spinning disk [1] - [1.5] - [2] - [2.5] - [3]
 - obj/ent take damage when hit by disk
 - obj/ent take extra damage the closer to the center
#### Platform spell: charm
 - creates an area with a charming aura
 - ent in area when created are instantly charmed
 - ent entering area take 3 sec to become charmed
 - a charmed ent fights for the player
