extends Node

const GRID_SIZE = 2


var leve_level_selector = {

	"restart" : ["res://level/cave_1/cave.tscn", Vector2(0,0)],
	"shop_mirage" : ["res://level/shop_mirage/shop_mirage.tscn",  Vector2(0,0)],
	"leave_shop_mirage": ["res://level/sol/solar_system_demo.tscn", Vector2(0,0)],
	"dungeon" : ["res://level/sol/solar_system_demo.tscn", Vector2(0,0)],
	"fight" : ["res://level/sol/fight.tscn",Vector2(0,0)],
	"world" : ["res://level/world/menu.tscn",Vector2(0,0)],
	"dungeon_2" : ["res://level/courtee/solar_system_demo.tscn",  Vector2(0,3)],
	"dungeon_3" : ["res://level/runnee/solar_system_demo.tscn",  Vector2(0,-1)],
	"dungeon_ramdom" : ["res://level/ramdom_vilage/solar_system_demo.tscn",  Vector2(0 ,0)],
	"vallage_ramdom" : ["res://level/ramdom_village_fight/solar_system_demo_.tscn",  Vector2(0 ,0)],
	"shop_courtee" : ["res://level/shop_courtee/shop_courtee.tscn",  Vector2(0,3)],
	"leave_shop_courtee" : ["res://level/courtee/solar_system_demo.tscn", Vector2(0,3)],
	"forge" : ["res://level/forge/forge.tscn", Vector2(0,3)],
	"leave_shop_forge" : ["res://level/courtee/solar_system_demo.tscn", Vector2(0,3)],
	"forge_sol" : ["res://level/forge_sol/forge.tscn", Vector2(0,1)],
	"leave_shop_forge_sol" : ["res://level/sol/solar_system_demo.tscn", Vector2(0,3)],
	"dungeon_4" : ["res://level/mud_lands/solar_system_demo.tscn", Vector2(0,5)],
	"cave_2" : ["res://level/cave_2/cave.tscn",Vector2(0,0)],
	"dungeon_5" : ["res://level/mane/solar_system_demo_.tscn", Vector2(1,8)],

}

const npc_list = {
	"miss_su" : "res://character/miss_su/miss_su.tscn",
	"thief_0" : "res://character/thief/thief.tscn",
	"soldier" : "res://character/soldier/soldier_.tscn",
	"thief_1" : "res://character/thief/thief.tscn",
	"thief_2" : "res://character/thief/thief.tscn",
	"thief_3" : "res://character/thief/thief.tscn",
	"thief_4" : "res://character/thief/thief.tscn",
	"thief_5" : "res://character/thief/thief.tscn",
	"thief_6" : "res://character/thief/thief.tscn",
	"lizard_1" : "res://character/lizard/lizard_open.tscn",
	"thief_7" : "res://character/thief/thief.tscn",

}


const leave_pos = {

	"leave_shop_mirage": "door_shop_mirage",
	"leave_shop_forge": "door_shop_forge",
	"leave_shop_courtee": "door_shop_courtee"
}




