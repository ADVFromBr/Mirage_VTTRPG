extends Node


var next_spawn_pos_name : String 
var items_inventory_bag = []
var items_in_hand_ = []
var player_health := 100

var last_tempeture := 60
var distance_to_next := 0

var last_town := "dungeon"

func set_player_health(player_health_):
		 player_health = player_health_

func get_player_health():
		 return player_health


signal player_ran(number_of_enemies_left)
signal player_aqueried_coin(coin)
signal player_traveled(distance)
signal player_grabed_tem_from_item_ground(item)



var next_city := ""

var distance := 1
var curren_way_of := 111
var current_quest_ = []

var quest_completed = []


var deleted_npcs = []

