extends CharacterBody2D

class_name Enemy

#Variables
const SPEED = 100.0
var direction:Vector2=Vector2(0,0)
enum enemyType {melee,ranged,other}
@export var enemyBehavior:enemyType
var target:CharacterBody2D
#Onreadys
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D 
@onready var hitBox: CollisionShape2D = $CollisionShape2D 
@onready var wallCheck: RayCast2D = $WallCheck


func _ready():
	pickDir()

func pickDir():
	var randStart=randi_range(1,4)
	#Picks a random direction to walk in
	if randStart ==1:
		direction.x=1
	elif randStart ==2:
		direction.x=-1
	elif randStart ==3:
		direction.y=-1
	elif randStart ==4:
		direction.y=-1
	velocity=direction*SPEED

func _physics_process(delta: float) -> void:
	#Sets the direction variable
	direction=velocity/SPEED
	#Flips the sprite based on the velocity
	if velocity.x<0:
		animated_sprite_2d.flip_h=false
	elif velocity.x>0:
		animated_sprite_2d.flip_h=true
	
	#Sets the wall checking ray to the direction
	wallCheck.target_position=direction*30
	print(wallCheck.target_position)
	#Makes the enemy behave diffently when the target is close
	if target!=null:
		if enemyBehavior==enemyType.melee:
			var targetAngle=get_angle_to(target.global_position)
			#Sets the velocity based on the angle
			velocity=Vector2(cos(targetAngle)*SPEED,sin(targetAngle)*SPEED)
		elif enemyBehavior==enemyType.ranged:
			pass
	move_and_slide()


func _on_targeting_body_entered(body:Node2D) -> void:
	#Makes sure it can only track the player
	if body.name=="Player":
		#Sets the target varible to the body it sees(the player)
		target=body
		#Resets velocity in order to help with movement
		#velocity=Vector2.ZERO
		print("I SEE YOU")



func _on_targeting_body_exited(body:Node2D) -> void:
	#Makes sure it can only track the player
	if body.name=="Player":
		print("I DON'T SEE YOU")
