extends CharacterBody2D

class_name Enemy

#Variables
const SPEED = 100.0
var startingDir:Vector2=Vector2(0,0)
#Onreadys
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D 
@onready var hitBox: CollisionShape2D = $CollisionShape2D 

func _ready():
	pickDir()

func pickDir():
	var randStart=randi_range(1,4)
	print(randStart)
	#Picks a random direction to walk in
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
	if velocity.x<0:
		animated_sprite_2d.flip_h=false
	else:
		animated_sprite_2d.flip_h=true




	move_and_slide()


func _on_targeting_body_entered(body:Node2D) -> void:
	#Makes sure it can only track the player
	if body.name=="Player":
		print("I SEE YOU")



func _on_targeting_body_exited(body:Node2D) -> void:
	#Makes sure it can only track the player
	if body.name=="Player":
		print("I DON'T SEE YOU")
