extends Button
#chaged slot from a panel to a button so you can now assign mouse clicks ont he slots

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var amountLabel: Label = $CenterContainer/Panel/Label
@onready var main_player: CharacterBody2D = $"../../../../../Player"


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
		

#coin  = <CompressedTexture2D#-9223372000397884039>
#consume items function
func _on_pressed() -> void:
	if main_player.currentHealth <= 90:
		if !itemSprite.texture == ResourceLoader.load("res://Assets/Pickups/GoldCoin.png"):
			#itemSlots[0].amount -= 1
			if itemSprite.visible == true:
				main_player.currentHealth += 10
				print(main_player.currentHealth)
