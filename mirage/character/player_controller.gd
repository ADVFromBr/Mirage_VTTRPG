extends Node
class_name player_controller


const input := preload("res://character/input.gd")
const attack := preload("res://character/attack.gd")
const inventory := preload("res://character/inventory_open_command.gd")
const interact := preload("res://character/interact_command.gd")



var parent : RigidBody
var _input_command = input_command.new()
var _book_open = book_open.new()
var _attack_command = attack_command.new()
var _inventory_command = open_inventory_command.new()
var _interact_command = interact_command.new()
 


		



