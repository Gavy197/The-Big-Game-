extends Button

#chaged slot from a panel to a button so you can now assign mouse clicks ont he slots

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var amountLabel: Label = $CenterContainer/Panel/Label
@onready var main_player: CharacterBody2D = $"../../../../../Player"
@export var inventory: Inventory


func update(slot: InventorySlot):
	#if the item is null
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
		
func remove(inventory: Inventory,itemRes):
	inventory.remove(InventoryItem)
	queue_free()
#coin  = <CompressedTexture2D#-9223372000397884039>
#consume items function
func _on_pressed() -> void:
	if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/GoldCoin.png"):
		if itemSprite.visible == true:
			print(main_player.currentHealth)
			#remove(inventory,InventoryItem)
#-----------------------------------------------------------------------
#beef (food) + 5 hp
	if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/Beaf.png"):
		if itemSprite.visible == true and main_player.maxHealth <= 95:
			main_player.currentHealth += 5
			print(main_player.currentHealth)
#------------------------------------------------------------------------
#calamri (food) + 10 hp
	if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/Calamari.png"):
		if itemSprite.visible == true and main_player.maxHealth <= 90:
			main_player.currentHealth += 10
			print(main_player.currentHealth)
#-----------------------------------------------------------------------
#medpack + 25 hp
	if itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/Medipack.png"):
		if itemSprite.visible == true and main_player.maxhealth <= 75:
			main_player.maxHealth += 25
			print(main_player.maxHealth)
		
