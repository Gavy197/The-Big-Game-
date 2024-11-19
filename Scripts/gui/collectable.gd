extends Area2D
class_name collectable

@export var itemRes: InventoryItem


func collect(inventory: Inventory):
	inventory.insert(itemRes)
	queue_free()
