extends Control

signal opened
signal closed

#variable for is open
var isOpen: bool = false

@onready var inventory: Inventory = preload("res://Scenes/HUD/PlayerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	inventory.updated.connect(update)
	update()


#update all slots in the inventory
func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
