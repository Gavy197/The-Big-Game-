extends Button

#chaged slot from a panel to a button so you can now assign mouse clicks ont he slots

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var amountLabel: Label = $CenterContainer/Panel/Label
@onready var main_player: CharacterBody2D = $"../../../../../Player"
@onready var emptySlot=preload("res://Scenes/HUD/inventory/slot_gui.tscn")
@onready var inventory: Inventory = preload("res://Scenes/HUD/PlayerInventory.tres")
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
		
func remove():
	selfSlot.amount-=1
	update(selfSlot)
	if selfSlot.amount<=0:
		inventory.use_item(selfSlot)

func _on_pressed() -> void:
	if selfSlot.amount>0 and selfSlot:
		if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/GoldCoin.png"):
			if itemSprite.visible == true:
				print(main_player.currentHealth)
				remove()
	#-----------------------------------------------------------------------
	#beef (food) + 5 hp
		if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/Beaf.png"):
			if itemSprite.visible == true and main_player.currentHealth <= main_player.maxHealth -5:
				main_player.currentHealth += 5
				print(main_player.currentHealth)
				remove()
	#------------------------------------------------------------------------
	#calamri (food) + 10 hp
		if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/Calamari.png"):
			if itemSprite.visible == true and main_player.currentHealth <= main_player.maxHealth - 10:
				main_player.currentHealth += 10
				print(main_player.currentHealth)
				remove()
	#-----------------------------------------------------------------------
	#medpack + 25 hp
		if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/Medipack.png"):
			if itemSprite.visible == true:
				main_player.maxHealth += 25
				print(main_player.maxHealth)
				remove()
			
