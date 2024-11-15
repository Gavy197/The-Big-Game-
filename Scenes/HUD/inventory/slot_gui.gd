extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item

func update(item: InventoryItem):
	#if the item is null
	if !item:
		#replace backgground sprite to 0
		backgroundSprite.frame = 0
		itemSprite.visible = false
	#if there is an item
	else:
		backgroundSprite.frame = 1
		itemSprite.visible = true
		itemSprite.texture = item.texture
