extends StaticBody2D

#Varibales
var velocity:Vector2=Vector2(1,0)
var damage:int
var creator:CharacterBody2D
var targetAngle
#Exports
@export var SPEED:int=10
@export var dmgBoost=0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Sets the velocity
	velocity=Vector2(cos(targetAngle),sin(targetAngle))*SPEED


func _physics_process(delta: float) -> void:
	var collide=move_and_collide(velocity*SPEED)
	#Deletes the projectile when it collides
	if collide:
		queue_free()
	
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		print("slash hit")
		#dmg falloff is determined by the animation player
		body.takeDamage(damage+dmgBoost,creator)
		queue_free()


func _on_delete_timeout():
	queue_free()
