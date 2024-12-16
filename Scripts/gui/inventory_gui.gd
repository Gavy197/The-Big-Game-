extends Control

signal opened
signal closed

#variable for is open
var isOpen: bool = false

@onready var inventory: Inventory = preload("res://Scenes/HUD/PlayerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var player:CharacterBody2D = $"../../Player"

func _ready():
	inventory.updated.connect(update)
	update()


#update all slots in the inventory
func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func open():
	#Prevents opening if dying
	if player.dying==false:
		visible = true
		isOpen = true
		get_tree().paused = true
		opened.emit()
	
func close():
	get_tree().paused = false
	visible = false
	isOpen = false
	closed.emit()


	
	
	
