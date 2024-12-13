extends StaticBody2D

#Varibales
var velocity:Vector2=Vector2(1,0)
var damage:int
var creator:CharacterBody2D
#Export
@export var SPEED:int=10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var targetAngle=get_angle_to(get_global_mouse_position())
	print(get_global_mouse_position())
	
	#Sets the velocity based on the target
	velocity=Vector2(cos(targetAngle),sin(targetAngle))
	global_rotation=targetAngle


func _physics_process(delta: float) -> void:
	#move_toward(get_global_mouse_position())
	var collide=move_and_collide(velocity*SPEED)
	#Deletes the projectile when it collides
	if collide:
		queue_free()
	
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body==Enemy:
		body.takeDamage(damage,creator)
