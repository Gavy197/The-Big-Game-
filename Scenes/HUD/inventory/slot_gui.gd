extends Button
#chaged slot from a panel to a button so you can now assign mouse clicks ont he slots

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var amountLabel: Label = $CenterContainer/Panel/Label

func update(slot: InventorySlot):
	#if the item is null
	if !slot.item:
		#replace backgground sprite to 0
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




func onSlotClicked() -> void:
	pass # Replace with function body.
