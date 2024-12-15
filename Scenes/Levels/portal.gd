extends Area2D
#Exports
@export var target:PackedScene
@export var inventory: Inventory
@export var cost:int
#Variables
var unlocked:bool
var coin= preload("res://Scenes/HUD/inventory/Coin.tres")
var currentCoins:int=0
#onreadys
@onready var animation_player: AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _on_body_entered(body: Node2D) -> void:
	if body.name=="Player":
		if unlocked==true:
			get_tree().change_scene_to_file("res://Scenes/Levels/dungeon.tscn")
		

func _on_sensor_body_entered(body: Node2D) -> void:
	#Prevents reopening the portal
	if unlocked==false:
		if body is Player:
			#Looks for only coins in the inventory
			for i in inventory.slots:
				if i.item==coin:
					#Sets the amout of coins the player has equal to the amout of coins in the inventory
					currentCoins=i.amount
			#Activates the portal if you have enough coins
			if currentCoins>=cost:
				animation_player.play("portalWake")
				#If the player will still have coins afer this, subtract coins
				if currentCoins-cost>0:
					#Looks for only coins in the inventory
					for i in inventory.slots:
						if i.item==coin:
							#removes the coins from the inventory
							i.amount=currentCoins-cost
							inventory.updated.emit()
				#If the player won't have coins after this, delete the slot
				else:
					var coinSlot = inventory.slots.filter(func(slot): return slot.item == coin)
					var coinIndex = inventory.slots.find(coinSlot[0],0)
					inventory.remove_at_index(coinIndex)
				
				unlocked=true
