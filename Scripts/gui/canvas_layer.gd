extends CanvasLayer

@onready var inventory = $InventoryGui

func _ready():
	inventory.close()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if inventory.isOpen:
			inventory.close()
			
		else:
			inventory.open()

#unpause when closed
func _on_inventory_gui_closed() -> void:
	get_tree().paused = false
	get_child(2).visible = false

#pause when open
func _on_inventory_gui_opened() -> void:
	get_tree().paused = true
	get_child(2).visible = true
