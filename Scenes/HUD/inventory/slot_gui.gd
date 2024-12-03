extends Button
#chaged slot from a panel to a button so you can now assign mouse clicks ont he slots

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var amountLabel: Label = $CenterContainer/Panel/Label
@onready var main_player: CharacterBody2D = $"../../../../../Player"
@onready var HealthBar: TextureProgressBar = $HealthBar



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
		
func _ready():
	main_player.healthChanged.connect(update)

func _on_pressed() -> void:
	#inventory. remove()
	main_player.currentHealth += 20
	print(main_player.currentHealth)
	pass # Replace with function body.
