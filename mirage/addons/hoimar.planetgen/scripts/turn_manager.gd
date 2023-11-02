extends Node
class_name turn_manager

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _init(name_):
		name = name_

signal _mode_switched_combat_on_off(node_,size)
var turn_caracters_array  := []
var current_turn_caracter : RigidBody = null
func add_to_turn_caracters_array(next_character):
	if turn_caracters_array.find(next_character) <= -1:
			turn_caracters_array.append(next_character)
			emit_signal("_mode_switched_combat_on_off",current_turn_caracter,turn_caracters_array.size())

func set_turn_caracters_array(new_char):
	current_turn_caracter =  new_char
	emit_signal("_mode_switched_combat_on_off",current_turn_caracter,turn_caracters_array.size())
	
func switch_current_turn_caracter(previous_character):
			turn_caracters_array.sort()
			if previous_character == current_turn_caracter:

									if current_turn_caracter == null:
											sort_array()
											emit_signal("_mode_switched_combat_on_off",current_turn_caracter,turn_caracters_array.size())
									print(turn_caracters_array.find(previous_character) + 1)
									if turn_caracters_array.find(previous_character) + 1  <= turn_caracters_array.size() -1:
										current_turn_caracter = turn_caracters_array[turn_caracters_array.find(previous_character) + 1 ]
										emit_signal("_mode_switched_combat_on_off",current_turn_caracter,turn_caracters_array.size())
										return
									else:
											sort_array()
											emit_signal("_mode_switched_combat_on_off",current_turn_caracter,turn_caracters_array.size())
			else:
											sort_array()
											emit_signal("_mode_switched_combat_on_off",current_turn_caracter,turn_caracters_array.size())

func clear_turn_caracters_array():
	emit_signal("_mode_switched_combat_on_off",null,0)
	turn_caracters_array.resize(0)
	turn_caracters_array = []
	current_turn_caracter =  null
	print("turn_caracters_array cleared")
	emit_signal("_mode_switched_combat_on_off",null,0)

func sort_array():
			for i in turn_caracters_array:
					if i == null:
							turn_caracters_array.remove(turn_caracters_array.find(i))
							print("null removed")
					else:
							current_turn_caracter = turn_caracters_array[turn_caracters_array.find(i)]
							print("found new current")
							break

func get_current_turn_caracter():
	return current_turn_caracter
func get_turn_caracters_array():
	return turn_caracters_array


func remove_from_turn_caracters_array(	node_to_remove):
	print("array removed " + node_to_remove.name)
	print(turn_caracters_array.size())
	if turn_caracters_array.find(node_to_remove) > -1:
			turn_caracters_array.remove(turn_caracters_array.find(node_to_remove))
			turn_caracters_array.sort()
			print(turn_caracters_array.size())
			print("array removed " + node_to_remove.name)
			print("array removed " + node_to_remove.name)
			emit_signal("_mode_switched_combat_on_off",current_turn_caracter,turn_caracters_array.size())
			print(turn_caracters_array.size())
