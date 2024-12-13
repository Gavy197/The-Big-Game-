extends StaticBody2D

class_name projectile
#Varibales
var velocity:Vector2=Vector2(1,0)
var damage:int
var target:CharacterBody2D
var creator:CharacterBody2D
var canAttack:bool
#Export
@export var SPEED:int=100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if canAttack==false:
		queue_free()
		damage=0
	var targetAngle=get_angle_to(target.global_position)
	#Sets the velocity based on the target
	velocity=Vector2(cos(targetAngle),sin(targetAngle))
	global_rotation=targetAngle


func _physics_process(delta: float) -> void:
	var collide=move_and_collide(velocity*SPEED)
	#Deletes the projectile when it collides
	if collide:
		queue_free()
	
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	print(body)
	if body!=creator:
		body.takeDamage(damage,creator)
