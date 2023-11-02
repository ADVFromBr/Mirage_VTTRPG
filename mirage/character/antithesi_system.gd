extends Node






# Called when the node enters the scene tree for the first time.
func _ready():
		PlayeerStat.connect("player_ran",self,"player_ran_upadate",[])
		PlayeerStat.connect("player_aqueried_coin",self,"player_aqueried_coin_upadate",[])
		PlayeerStat.connect("player_traveled",self,"player_traveled_upadate",[])
		PlayeerStat.connect("player_grabed_tem_from_item_ground",self,"player_grabed_tem_from_item_ground_update",[])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var value_from_grabed_items_from_dropped_item_ground := 0


func player_grabed_tem_from_item_ground_update(item_):
		if item_ != null:
			if item_.has("value"):
				value_from_grabed_items_from_dropped_item_ground = value_from_grabed_items_from_dropped_item_ground + 55
		else:
				value_from_grabed_items_from_dropped_item_ground = value_from_grabed_items_from_dropped_item_ground - 155
				
		
		if value_from_grabed_items_from_dropped_item_ground < 0:
			value_from_grabed_items_from_dropped_item_ground = 0
		
		if value_from_grabed_items_from_dropped_item_ground > 555:
					is_player_able_to_trade = false



var items_that_cant_trade := []
var is_player_able_to_trade := true

var list_of_var_array_for_casuality_effect_= [is_player_able_to_trade,enable_rum_to_player_add,]


var number_of_player_ran_times := 0
var enable_rum_to_player_add := false

func player_ran_upadate(number_of_enemies_left_in_fight):
	number_of_player_ran_times = number_of_player_ran_times + number_of_enemies_left_in_fight
	
	if number_of_player_ran_times > 6:
		enable_rum_to_player_add = true


	elif number_of_player_ran_times <= 2:
		enable_rum_to_player_add = false


var current_distance_traveled_ := 0
var current_distance_traveled_additive_rng_ := 0

var number_of_ramdom_encounter_adding_ := 0




func player_aqueried_coin_upadate(coin):
	if coin.value > 1000:
		number_of_ramdom_encounter_adding_ = 4
		print(number_of_ramdom_encounter_adding_)
		
func player_traveled_upadate(distance):
		current_distance_traveled_ = distance
