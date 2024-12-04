extends TextureProgressBar


@onready var player:CharacterBody2D = $"../../Player"

func _ready():
	player.healthChanged.connect(update)
	update()
	

func update():
	value = player.currentHealth * 100 / player.maxHealth
	
func _process(delta):
	update()
