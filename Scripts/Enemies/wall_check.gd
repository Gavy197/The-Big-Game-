extends RayCast2D

signal isColliding
signal notColliding
var currentCollide:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_colliding():
		currentCollide=true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Creates a custom signal, which fires once when the ray collides, and then won't fire again until it uncollides first
	if currentCollide==false:
		if is_colliding()==true:
			currentCollide=true
			emit_signal("isColliding")
	elif currentCollide==true:
		if is_colliding()==false:
			currentCollide=false
			emit_signal("notColliding")
