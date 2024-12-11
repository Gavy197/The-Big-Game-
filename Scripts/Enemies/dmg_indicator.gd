extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Makes it fade out
	modulate.a8-=10
	if modulate.a8<=80:
		#Delete the effect after it fades a bit
		queue_free()
