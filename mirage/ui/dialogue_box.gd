extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dialogue = []
var npc_ : RigidBody 

onready var my_style_box = load("res://ui/button_style.tres")
onready var inventory = get_parent().get_node("Inventory")


func set_style_button(button):
			button.add_stylebox_override("normal", my_style_box)
			button.add_stylebox_override("focus", my_style_box)
			button.add_stylebox_override("hover", my_style_box)
			button.add_stylebox_override("pressed",my_style_box)
var distance_offset_ := 32
func _init_dialogue(_npc_:  RigidBody, texture_set :  Texture, dialogue_):
	

	if	visible == false:
		get_node("TextureRect/HBoxContainer/TextureRect").set_texture(texture_set)
		var question_index := 0
		var quest_index := 0
		npc_ = _npc_
		visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		for buttons_ in get_node("TextureRect/talk_option").get_children():
			buttons_.queue_free()
		for buttons_ in get_node("TextureRect/questionieer").get_children():
			buttons_.queue_free()
		for buttons_ in get_node("TextureRect/quest").get_children():
			buttons_.queue_free()

		dialogue = dialogue_
		get_node("TextureRect/npc_speach").text = dialogue.sheets[0].lines[0].np_speech
		distance_offset_ = 12
		print(dialogue.sheets[0].lines[0].np_speech)
		if  OS.get_name == "Windows":	
			for  option_in_response in dialogue.sheets[0].lines[0].player_option[0].size():
				var button = Button.new()
				get_node("TextureRect/talk_option").add_child(button)
				button.size_flags_horizontal += SIZE_EXPAND
				button.text = dialogue.sheets[0].lines[0].player_option[0].get("option_" + str(option_in_response + 1))[0].text
				button.connect("pressed", self, "_on_Button_toggled", [option_in_response])
				set_style_button(button)
				
		else :	
			for  option_in_response in dialogue.sheets[0].lines[0].player_option[0].size():
						var button = TouchScreenButton.new()
						get_node("TextureRect/talk_option").add_child(button)
						var label_ = Label.new()
						button.add_child(label_)
						label_.size_flags_horizontal += SIZE_EXPAND
						button.set_shape(RectangleShape2D.new())
						button.get_shape().set_extents(Vector2(111,11))
						label_.text =  dialogue.sheets[0].lines[0].player_option[0].get("option_" + str(option_in_response + 1))[0].text
						button.connect("pressed", self, "_on_Button_toggled", [option_in_response])
						set_style_button(label_)
						var prexius_child = null
						if get_node("TextureRect/talk_option").get_children().size() >0:
							for i in get_node("TextureRect/talk_option").get_children():
									if !prexius_child:

													prexius_child =  i
									elif prexius_child:
											if i.name == button.name:
													i.global_transform.origin = prexius_child.global_transform.origin  + button.global_transform.y  *  distance_offset_ 
													prexius_child =  i
		for  option_question  in dialogue.sheets[0].lines[0]:
				if option_question.begins_with("question_"):	
					if  OS.get_name == "Windows":	
						var button = Button.new()
						get_node("TextureRect/questionieer").add_child(button)
						button.size_flags_horizontal += SIZE_EXPAND

						button.text = dialogue.sheets[0].lines[0].get("question_" + str( question_index + 1))[0].text
						button.connect("pressed", self, "_on_question_Button_toggled", [question_index])
						set_style_button(button)
						question_index+=1
						
					else :	
						var button = TouchScreenButton.new()
						get_node("TextureRect/questionieer").add_child(button)
						var label_ = Label.new()
						button.add_child(label_)
						label_.size_flags_horizontal += SIZE_EXPAND
						button.set_shape(RectangleShape2D.new())
						button.get_shape().set_extents(Vector2(111,11))
						label_.text =  dialogue.sheets[0].lines[0].get("question_" + str( question_index + 1))[0].text
						button.connect("pressed", self, "_on_question_Button_toggled", [question_index])
						set_style_button(label_)


						var prexius_child = null
						for i in get_node("TextureRect/questionieer").get_children():
								if !prexius_child:
												prexius_child =  i
												
								elif prexius_child:
											if i == button:
												i.global_transform.origin = prexius_child.global_transform.origin  + i.global_transform.y  *  distance_offset_ 
												prexius_child =  i
						question_index+=1

					
		for  option_quest in dialogue.sheets[0].lines[0]:
				if option_quest.begins_with("quest_"):	
					if PlayeerStat.quest_completed.find(dialogue.sheets[0].lines[0].get("quest_" + str( quest_index + 1))[0].name) == -1:
						if  OS.get_name == "Windows":	
							var button = Button.new()
							get_node("TextureRect/quest").add_child(button)
							button.size_flags_horizontal += SIZE_EXPAND

							button.text = dialogue.sheets[0].lines[0].get("quest_" + str( quest_index + 1))[0].name
							button.connect("pressed", self, "_on_quest_Button_toggled", [quest_index])
							set_style_button(button)
							
							quest_index+=1
						else :	
								
								var button = TouchScreenButton.new()
								get_node("TextureRect/quest").add_child(button)
								var label_ = Label.new()
								button.add_child(label_)
								label_.text = dialogue.sheets[0].lines[0].get("quest_" + str( quest_index + 1))[0].name
								set_style_button(button)
								
								button.set_shape(RectangleShape2D)
								button.get_shape().set_extents(Vector2(133,11))
						

								label_.size_flags_horizontal += SIZE_EXPAND

								label_.text = dialogue.sheets[0].lines[0].get("quest_" + str( quest_index + 1))[0].name
								button.connect("pressed", self, "_on_quest_Button_toggled", [quest_index])
								set_style_button(label_)
								var prexius_child = null
								if get_node("TextureRect/quest").get_children().size() >0:
										for i in get_node("TextureRect/quest").get_children():
											if !prexius_child:
															prexius_child =  i
															
											elif prexius_child:
														if i == button:
															i.global_transform.origin = prexius_child.global_transform.origin  + i.global_transform.y  *  distance_offset_ 
															prexius_child =  i
								quest_index+=1
								
		if  OS.get_name == "Windows":	
				var button = Button.new()
				get_node("TextureRect/talk_option").add_child(button)
				button.size_flags_horizontal += SIZE_EXPAND
				button.text = "Good bye!"
				button.connect("pressed", self, "_on_Button_exit_toggled", [button.get_index()])
				set_style_button(button)
		else:
				var button = TouchScreenButton.new()
				get_node("TextureRect/talk_option").add_child(button)
				button.set_shape(RectangleShape2D.new())
				button.get_shape().set_extents(Vector2(33,11))
				var label_ = Label.new()
				button.add_child(label_)
				label_.size_flags_horizontal += SIZE_EXPAND
				label_.text = "Good bye!"
				button.connect("pressed", self, "_on_Button_exit_toggled", [button.get_index()])
				set_style_button(label_)

				var prexius_child = null

				for i in get_node("TextureRect/talk_option").get_children():
									if !prexius_child:

													prexius_child =  i
	
									elif prexius_child:
											if i.name == button .name:
													i.global_transform.origin = prexius_child.global_transform.origin  + i.global_transform.y  *  distance_offset_ 


func _on_question_Button_toggled(index: int):
	get_node("TextureRect/npc_speach").text = dialogue.sheets[0].lines[0].get("question_" + str(index + 1))[0].answer

func _on_quest_Button_toggled(index: int):
	if PlayeerStat.quest_completed.find(dialogue.sheets[0].lines[0].get("quest_" + str( index + 1))[0].name) == -1:
		var index_option := 0
		if PlayeerStat.current_quest_.find(dialogue.sheets[0].lines[0].get("quest_" + str( index + 1))[0].name) == -1:
			get_node("TextureRect/npc_speach").text = dialogue.sheets[0].lines[0].get("quest_" + str(index + 1))[0].np_speech
			for  option_quest in dialogue.sheets[0].lines[0].get("quest_"+ str(index_option + 1))[0]:
				if option_quest.begins_with("option"):
					if !get_node("TextureRect/talk_option").has_node("quest_" + str(index + 1)):
						if  OS.get_name == "Windows":	
										var button = Button.new()
										get_node("TextureRect/talk_option").add_child(button)
										button.name = "quest_" + str(index + 1)
										button.size_flags_horizontal += SIZE_EXPAND
										
										button.text = dialogue.sheets[0].lines[0].get("quest_" + str(index + 1))[0].get("option_" + str(index_option + 1))[0].text
										button.connect("pressed", self, "_on_option_quest_toggled", [index,index_option])
										set_style_button(button)
										
										index_option += 1
						else:
							
										var button = TouchScreenButton.new()
										get_node("TextureRect/talk_option").add_child(button)
										button.name = "quest_" + str(index + 1)

										button.set_shape(RectangleShape2D.new())
										button.get_shape().set_extents(Vector2(33,11))
										var label_ = Label.new()
										button.add_child(label_)
										label_.size_flags_horizontal += SIZE_EXPAND
										label_.text = dialogue.sheets[0].lines[0].get("quest_" + str(index + 1))[0].get("option_" + str(index_option + 1))[0].text
										button.connect("pressed", self, "_on_option_quest_toggled", [index,index_option])
										set_style_button(label_)
										var prexius_child = null

										for i in get_node("TextureRect/talk_option").get_children():
													if !prexius_child:
																	prexius_child =  i
																	
													elif prexius_child:
																if i.name == button.name:
																	i.global_transform.origin = prexius_child.global_transform.origin  + i.global_transform.y  *  distance_offset_ 
																	prexius_child =  i

		else:
			if dialogue.sheets[0].lines[0].get("quest_"+ str(index + 1))[0].has("requirements_to_finish_quest"):
				if dialogue.sheets[0].lines[0].get("quest_" + str(index + 1))[0].requirements_to_finish_quest[0].has("item"):
							if inventory.has_node( dialogue.sheets[0].lines[0].get("quest_" + str(index + 1))[0].requirements_to_finish_quest[0].item):
									inventory.drop_from_grid(Item.get_item (dialogue.sheets[0].lines[0].get("quest_" + str(index + 1))[0].requirements_to_finish_quest[0].item))
									get_node("TextureRect/npc_speach").text = dialogue.sheets[0].lines[0].get("quest_" + str(index + 1))[0].np_speech_end
									PlayeerStat.quest_completed.append(dialogue.sheets[0].lines[0].get("quest_" + str( index + 1))[0].name)
									if dialogue.sheets[0].lines[0].get("quest_" + str( index + 1))[0].has("reward"):
																	inventory.pickup_item( dialogue.sheets[0].lines[0].get("quest_" + str(index + 1))[0].reward[0].item)


func _on_Button_exit_toggled(index: int):

		var question_index := 0
		var quest_index := 0



		for buttons_ in get_node("TextureRect/talk_option").get_children():
			buttons_.queue_free()
		for buttons_ in get_node("TextureRect/questionieer").get_children():
			buttons_.queue_free()
		for buttons_ in get_node("TextureRect/quest").get_children():
			buttons_.queue_free()

		visible = false
		npc_.select_npc_actiion = npc_.on_ready_set_action

func _on_Button_toggled(index: int):

	for buttons_ in get_node("TextureRect/talk_option").get_children():
		buttons_.queue_free()
		
	get_node("TextureRect/npc_speach").text = dialogue.sheets[0].lines[0].player_option[0].get("option_" + str(index + 1))[0].np_speech
	if  OS.get_name == "Windows":	
			var button = Button.new()
			get_node("TextureRect/talk_option").add_child(button)
			button.size_flags_horizontal += SIZE_EXPAND
			button.text = "Good bye!"
			button.connect("pressed", self, "_on_Button_exit_toggled", [button.get_index()])
			set_style_button(button)
	else:
			var button = TouchScreenButton.new()
			get_node("TextureRect/talk_option").add_child(button)
			button.set_shape(RectangleShape2D.new())
			button.get_shape().set_extents(Vector2(33,11))
			var label_ = Label.new()
			button.add_child(label_)
			label_.size_flags_horizontal += SIZE_EXPAND
			label_.text = "Good bye!"
			button.connect("pressed", self, "_on_Button_exit_toggled", [button.get_index()])
			set_style_button(label_)
			var prexius_child = null
			for i in get_node("TextureRect/talk_option").get_children():
					if !prexius_child:
							prexius_child =  i

					elif prexius_child:
						if i.name == button.name:
								i.global_transform.origin = prexius_child.global_transform.origin  + i.global_transform.y  *  distance_offset_ 
								prexius_child =  i


func _on_option_quest_toggled(quest_index: int,index: int):
	if dialogue.sheets[0].lines[0].get("quest_" + str(quest_index + 1))[0].get("option_" + str(index + 1))[0].choice > 0:
		get_node("TextureRect/npc_speach").text = dialogue.sheets[0].lines[0].get("quest_" + str(quest_index + 1))[0].get("option_" + str(index + 1))[0].answer
		if dialogue.sheets[0].lines[0].get("quest_" + str(quest_index + 1))[0].get("option_" + str(index + 1))[0].has("add"):
				if not get_parent().get_node("Inventory").has_node(dialogue.sheets[0].lines[0].get("quest_" + str(quest_index + 1))[0].get("option_" + str(index + 1))[0].add):
					get_parent().get_node("Inventory").pickup_item( dialogue.sheets[0].lines[0].get("quest_" + str(quest_index + 1))[0].get("option_" + str(index + 1))[0].add)
		PlayeerStat.current_quest_.append(dialogue.sheets[0].lines[0].get("quest_" + str(quest_index + 1))[0].name)
