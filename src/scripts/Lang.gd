extends Node

var element_names = {
    Global.Elements.AIR: "Air",
    Global.Elements.ARCANE: "Arcane",
    Global.Elements.ELECTRIC: "Electric",
    Global.Elements.FIRE: "Fire",
    Global.Elements.GROUND: "Ground",
    Global.Elements.ICE: "Ice",
    Global.Elements.LIFE: "Life",
    Global.Elements.NECROTIC: "Necrotic",
    Global.Elements.WATER: "Water"
    }
    
var spell_types = {
    
    Global.SpellTypes.AREA : "Platform Spell",
    Global.SpellTypes.BASIC : "Basic Spell",
    Global.SpellTypes.WALL : "Wall Spell",
    Global.SpellTypes.SIDE: "Side Spell",
   }

var spell_descriptions = {
    Global.Elements.ARCANE: {
        Global.SpellTypes.AREA: {
            "title": "", 
            "desc": "", 
        }, 
        Global.SpellTypes.BASIC : {
            "title": "", 
            "desc": "", 
        },
        Global.SpellTypes.WALL : {
            "title": "", 
            "desc": "", 
        }, 
        Global.SpellTypes.SIDE: {
            "title": "", 
            "desc": "", 
        }, 
    }, 
    Global.Elements.AIR: {
        Global.SpellTypes.AREA: {
            "title": "updraft", 
            "desc": "The target area now has a strong updraft. Enemies in the area are buffeted upward and are slowed. If you enter the area you get a slight speed boost.", 
        }, 
        Global.SpellTypes.BASIC : {
            "title": "breezeblade", 
            "desc": "A harsh breeze is compressed and shot towards your target", 
        },
        Global.SpellTypes.WALL : {
            "title": "tornado", 
            "desc": "A tornado forms at your target which pulls enemies towards itself and keeps them inside. The more things inside the tornado, the more damage it causes", 
        }, 
        Global.SpellTypes.SIDE: {
            "title": "wind", 
            "desc": "Wind blows from your hands, pushing enemies away while dealing damage. By holding down [CAST] you can sustain this spell while draining 1% of the next mana gem's charge per second." 
        }, 
    }, 
    Global.Elements.ELECTRIC: {
        Global.SpellTypes.AREA: {
            "title": "charged earth", 
            "desc": "The target area becomes charged with strong static electricity. Enemies passing through it take intermittent shock damage and have a high chance to become stunned. ", 
        }, 
        Global.SpellTypes.BASIC : {
            "title": "lightning bolt", 
            "desc": "Shoots a bolt of lightning at your target", 
        },
        Global.SpellTypes.WALL : {
            "title": "lightning storm", 
            "desc": "A lightning cloud appears above the target which constantly sends down lightning bolts until it disappates. In addition to damaging enemies, these bolts will stun them.", 
        }, 
        Global.SpellTypes.SIDE: {
            "title": "lightning ball", 
            "desc": "", 
        }, 
    }, 
    Global.Elements.FIRE: {
        Global.SpellTypes.AREA: {
            "title": "path of coals", 
            "desc": "White-hot coals are scattered over the area. They ignite enemies which pass over them and deal bonus damage to enemies on fire.", 
        }, 
        Global.SpellTypes.BASIC : {
            "title": "fireball", 
            "desc": "Hurls a small fireball at your target.", 
        },
        Global.SpellTypes.WALL : {
            "title": "pillar of fire", 
            "desc": "A column of fire erupts from the ground, dealing massive damage to enemies caught above it when it erupts.", 
        }, 
        Global.SpellTypes.SIDE: {
            "title": "fire vent", 
            "desc": "A vent emerges next to you and spews fire away from you, igniting enemies.", 
        }, 
    }, 
    Global.Elements.GROUND: {
        Global.SpellTypes.AREA: {
            "title": "quicksand", 
            "desc": "The ground at the target area becomes quicksand. Enemies are slowed and if they sink, become entombed permanently.", 
        }, 
        Global.SpellTypes.BASIC : {
            "title": "rock", 
            "desc": "Hurls a hard rock at your target.", 
        },
        Global.SpellTypes.WALL : {
            "title": "pillar of stone", 
            "desc": "A dense stone column erupts from the ground, knocking back and stunning enemies in its way as it emerges.", 
        }, 
        Global.SpellTypes.SIDE: {
            "title": "mudstorm", 
            "desc": "Sends a dense cloud of rocks, mud and sand away from you. Has a chance to stun or root enemies in place.", 
        }, 
    }, 
    Global.Elements.ICE: {
        Global.SpellTypes.AREA: {
            "title": "ice patch", 
            "desc": "Creates a patch of ice, which has a chance to freeze enemies that are present when it is made. While it exists, enemies which walk on top of it slide instead of walk.", 
        }, 
        Global.SpellTypes.BASIC : {
            "title": "ice crystal", 
            "desc": "Shoots a small ice crystal towards your target.", 
        },
        Global.SpellTypes.WALL : {
            "title": "ice pillar", 
            "desc": "Forms a pillar of ice at the target position. If the pillar forms over an enemy, the enemy is frozen inside.", 
        }, 
        Global.SpellTypes.SIDE: {
            "title": "freeze ray", 
            "desc": "Shoots a cloud of ice magic away from you which disappates after a short time. Any ememies hit by it are frozen.", 
        }, 
    }, 
    Global.Elements.LIFE: {
        Global.SpellTypes.AREA: {
            "title": "", 
            "desc": "", 
        },   
        Global.SpellTypes.BASIC : {
            "title": "", 
            "desc": "", 
        },
        Global.SpellTypes.WALL : {
            "title": "", 
            "desc": "", 
        }, 
        Global.SpellTypes.SIDE: {
            "title": "", 
            "desc": "", 
        }, 
    }, 
    Global.Elements.NECROTIC: {
        Global.SpellTypes.AREA: {
            "title": "", 
            "desc": "", 
        },  
        Global.SpellTypes.BASIC : {
            "title": "", 
            "desc": "", 
        },
        Global.SpellTypes.WALL : {
            "title": "", 
            "desc": "", 
        }, 
        Global.SpellTypes.SIDE: {
            "title": "", 
            "desc": "", 
        }, 
    }, 
    Global.Elements.WATER: {
        Global.SpellTypes.AREA: {
            "title": "whirlpool", 
            "desc": "Creates a whirlpool which slowly pulls enemies towards its center.", 
        }, 
        Global.SpellTypes.BASIC : {
            "title": "water droplet", 
            "desc": "A congeled mass of water shot to your target.", 
        },
        Global.SpellTypes.WALL : {
            "title": "gyser", 
            "desc": "A gysers erupts from the ground, pushing enemes upward and to either side as it erupts. If enemies get to close, they are pushed back.", 
        }, 
        Global.SpellTypes.SIDE: {
            "title": "water jet", 
            "desc": "A stream of water erupts from your hands to push enemeis away. By holding down [CAST] you can sustain this spell while draining 4% of the next mana gem's charge per second.", 
        }, 
    }, 
}
