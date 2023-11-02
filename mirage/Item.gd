extends Control


const ICON_PATH = "res://Items/glove/glove.png"

const slot ={
	"R_HAND": "R_HAND",
	"L_HAND": "L_HAND",
	"HEAD": "HEAD",
}

enum type_fyre{

	PUSH,
	FIRE_BEEN,
	PULL,
	GRAB_PHYSICS,
	MUSK_SHOOT,

}


const ITEMS = {
	
 "glove" : {
		
		"icon" : "res://Items/glove/glove_icon.png",
		"slot" : slot.R_HAND,
		"name" : "glove",
		"type" : "weapon",
		"hold" : "res://Items/glove/spritesheet(14).png",
		"damage" : 21,
		"range" : 113,
		"type_fyre" : [type_fyre.FIRE_BEEN, type_fyre.GRAB_PHYSICS],
		"sound" : "res://sfx/character/item/gun/523205__matrixxx__retro-laser-gun-shot.wav",
		"value" : 1130

	},
 "head_cover" : {
		
		"icon" : "res://Items/head_cover/head_cover.png",
		"slot" : slot.HEAD,
		"name" : "head_cover",
		"type" : "armor",
		"armor" : 62,
		"hold" : "res://Items/head_cover/head_cover.png",
		"value" : 330

	},

	
 "musk" : {
		
		"icon" : "res://Items/musk/hold.png",
		"slot" : slot.R_HAND,
		"name" : "musk",
		"type" : "weapon",
		"hold" : "res://Items/musk/spritesheet (26).png",
		"damage" : 21,
		"range" : 113,
		"type_fyre" : [type_fyre.FIRE_BEEN,type_fyre.MUSK_SHOOT],
		"sound" : "res://sfx/character/item/gun/682464__supersouper__revolver-fire.wav",
		"value" : 330
	},


 "error" : {
		
		"icon" : "",
		"slot" :  slot.R_HAND,
		"name" : "error",
		"value" : 0

	},
	
	
	


 "vessel_water" : {
		"name" : "vessel_water",
		"icon" : "res://Items/vessel_water/vessel.png",
		"hold" : "res://Items/vessel_water/spritesheet(23).png",
		"range" : 43,
		"health": 55,
		"slot" :  slot.R_HAND,
		"type" : "usable_drink",
		"sound" : "res://sfx/character/other/371274__mafon2__water-click.wav",
		"value" : 35
	},
	
	"vessel" : {
		"name" : "vessel",
		"icon" : "res://Items/vassel/vessel.png",
		"hold" : "res://Items/vassel/spritesheet(22).png",
		"range" : 43,
		"slot" :  slot.R_HAND,
		"type" : "collect",
		"sound" : "res://sfx/character/other/371274__mafon2__water-click.wav",
		"value" : 20
	},

	"ring" : {
		"name" : "ring",
		"icon" : "res://Items/ring/Planet-Generator-3.png",
		"hold" : "res://Items/ring/Planet-Generator-3.png",
		"range" : 43,
		"slot" :  slot.R_HAND,
		"type" : "coin",
		"value" : 150
	},

	"coin" : {
		"name" : "coin",
		"icon" : "res://Items/coin/coin.png",
		"hold" : "res://Items/coin/coin.png",
		"range" : 43,
		"slot" :  slot.L_HAND,
		"type" : "coin",
		"value" : 1133,
	},
	"coin_silver" : {
		"name" : "coin_silver",
		"icon" : "res://Items/coin_silver/coin_silver.png",
		"hold" : "res://Items/coin_silver/coin_silver.png",
		"range" : 43,
		"slot" :  slot.L_HAND,
		"type" : "coin",
		"value" : 855,
	},
	"book" : {
		"name" : "book",
		"icon" : "res://Items/book/book.png",
		"hold" : "res://Items/book/book.png",
		"range" : 43,
		"slot" :  slot.R_HAND,
		"type" : "collect",
		"sound" : "res://sfx/UI/pickupCoin.wav",
		"value" : 40
	},


	"book_musk" : {
		"name" : "book_musk",
		"icon" : "res://Items/book_musk/book_musk.png",
		"hold" : "res://Items/book_musk/book_musk.png",
		"range" : 83,
		"slot" :  slot.R_HAND,
		"type" : "book",
		"build" : "musk",
		"required" : ["miner_iron"],
		"value" : 40,
	},

	"book_head_cover" : {
		"name" : "book_head_cover",
		"icon" : "res://Items/book_musk/book_musk.png",
		"hold" : "res://Items/book_musk/book_musk.png",
		"range" : 83,
		"slot" :  slot.R_HAND,
		"type" : "book",
		"build" : "head_cover",
		"required" : ["miner_iron"],
		"value" : 45,
	},

	"book_vessel" : {
		"name" : "book_vessel",
		"icon" : "res://Items/book_musk/book_musk.png",
		"hold" : "res://Items/book_musk/book_musk.png",
		"range" : 83,
		"slot" :  slot.R_HAND,
		"type" : "book",
		"build" : "vessel",
		"required" : ["mud"],
		"value" : 30,
	},
	
	"miner" : {
		"name" : "miner",
		"icon" : "res://Items/piket/pket.png",
		"hold" : "res://Items/piket/pket.png",
		"range" : 43,
		"slot" :  slot.R_HAND,
		"type" : "collect",
		"sound" : "res://sfx/UI/pickupCoin.wav",
		"value" : 20
	},
	"miner_iron" : {
		"name" : "miner_iron",
		"icon" : "res://Items/rock/rock.png",
		"hold" : "res://Items/rock/rock.png",
		"range" : 43,
		"slot" :  slot.R_HAND,
		"type" : "resource",
		"sound" : "res://sfx/UI/pickupCoin.wav",
		"value" : 30
	},
	"mud" : {
		"name" : "mud",
		"icon" : "res://Items/mud/mud.png",
		"hold" : "res://Items/mud/mud.png",
		"range" : 13,
		"slot" :  slot.R_HAND,
		"type" : "resource",
		"sound" : "res://sfx/UI/pickupCoin.wav",
		"value" : 10
	},
	"map" : {
		"name" : "map",
		"icon" : "res://Items/map/map.png",
		"hold" : "res://Items/map/map.png",
		"range" : 43,
		"slot" :  slot.L_HAND,
		"type" : "coin",
		"value" : 155,
	},

	"map_world" : {
		"name" : "map_world",
		"icon" : "res://Items/map_world/map_world.png",
		"hold" : "res://Items/map_world/map_world.png",
		"range" : 43,
		"slot" :  slot.L_HAND,
		"type" : "coin",
		"value" : 355,

	},

}
func get_item(item_id):
	if item_id in ITEMS:
		return ITEMS[item_id]

	else:
		return ITEMS.error
