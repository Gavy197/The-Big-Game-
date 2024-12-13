extends AnimatedSprite2D
#Controls the effect color
var rOffset:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	#Makes the dash fade a bit
	modulate.a8-=10
	if modulate.a8<=10:
		#Delete the effect after it fades a bit
		queue_free()
