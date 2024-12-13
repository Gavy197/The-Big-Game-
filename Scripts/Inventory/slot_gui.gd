extends Button

#chage slot from a panel to a button

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var amountLabel: Label = $CenterContainer/Panel/Label
@onready var main_player: CharacterBody2D = $"../../../../../Player"
@onready var emptySlot=preload("res://Scenes/HUD/inventory/slot_gui.tscn")
@onready var inventory: Inventory = preload("res://Scenes/HUD/PlayerInventory.tres")
@onready var POP: PackedScene = preload("res://Scenes/HUD/floating_text.tscn")
var selfSlot:InventorySlot
var slots: Array[InventorySlot]


func update(slot: InventorySlot):
	#Adds variables we need from other scenes
	selfSlot=slot
	
	#print(slot[index])
	#if the item is nulls
	if !slot.item:
		#replace background sprite to 0
		backgroundSprite.frame = 0
		itemSprite.visible = false
		amountLabel.visible = false
	#if there is an item
	else:
		backgroundSprite.frame = 1
		itemSprite.visible = true
		itemSprite.texture = slot.item.texture
		amountLabel.visible = true
		amountLabel.text = str(slot.amount)
		
		
#function for consuming items	
func remove():
	selfSlot.amount-=1
	update(selfSlot)
	if selfSlot.amount<=0:
		inventory.use_item(selfSlot)
		
		
#function for popup text when consumed
func popup(text):
	var instance = POP.instantiate()
	add_sibling(instance)
	instance.get_child(0).text = text
	instance.position = Vector2(60, -35)
	
	
func _on_pressed() -> void:
	if selfSlot.amount>0 and selfSlot:
		if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/GoldCoin.png"):
			if itemSprite.visible == true:
				popup("You can't eat a coin")
	#-----------------------------------------------------------------------
	#beef (food) + 5 hp
		if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/Beaf.png"):
			if itemSprite.visible == true and main_player.currentHealth <= main_player.maxHealth -5:
				main_player.currentHealth += 5
				popup("+5 HP")
				print(main_player.currentHealth)
				remove()
			else:
				popup("Too much HP to eat")
	#------------------------------------------------------------------------
	#calamri (food) + 10 hp
		if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/Calamari.png"):
			if itemSprite.visible == true and main_player.currentHealth <= main_player.maxHealth - 10:
				main_player.currentHealth += 10
				popup("+10 HP")
				print(main_player.currentHealth)
				remove()
			else:
				popup("Too much HP to eat")
	#-----------------------------------------------------------------------
	#medpack + 25 hp
		if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/Medipack.png"):
			if itemSprite.visible == true:
				main_player.maxHealth += 25
				popup("Max HP increasesd to " + str(main_player.maxHealth))
				print(main_player.maxHealth)
				remove()
			else:
				popup("Too much HP to eat")
	#-----------------------------------------------------------------------
	#fish (food) + 7 hp
		if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/Fish.png"):
			if itemSprite.visible == true and main_player.currentHealth <= main_player.maxHealth - 7:
				main_player.currentHealth += 7
				popup("+7 HP")
				remove()
				print(main_player.currentHealth)
			else:
				popup("Too much HP to eat")
				
			
			
