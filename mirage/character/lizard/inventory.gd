extends inventory_


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
		var ramdom_key =  Item.ITEMS.keys()[randi() % Item.ITEMS.size() - 1]
		add_item(Item.ITEMS.get(ramdom_key).name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
