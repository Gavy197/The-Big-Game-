extends CharacterBody2D

class_name Enemy

#Variables
const SPEED = 100.0
var startingDir:Vector2=Vector2(0,0)
#Onreadys
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D 

func _ready():
	var randStart=randi_range(1,4)
	print(randStart)
	#Picks a random direction to start walking in, until it finds a player, or a wall
	if randStart ==1:
		startingDir.x=1
	elif randStart ==2:
		startingDir.x=-1
	elif randStart ==3:
		startingDir.y=-1
	elif randStart ==4:
		startingDir.y=-1
	velocity=startingDir*Vector2(SPEED,SPEED)

func _physics_process(delta: float) -> void:
	if velocity.x>0:
		animated_sprite_2d.flip_h=true
	else:
		animated_sprite_2d.flip_h=false




	move_and_slide()
