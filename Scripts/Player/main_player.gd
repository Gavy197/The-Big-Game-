extends CharacterBody2D

#Constants
const SPEED = 300.0

#Varibales
@export var health: int = 100
var normalMove:bool =true
@export var dashDist:int=40
#Adds a t varible for interpolation

#Onreadys
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dashCD: Timer = $dashCD
@onready var dashPart:CPUParticles2D=$dashPart


func _physics_process(delta: float) -> void:
	#Helps handle interpolation

	#Handles movement animations
	if normalMove==true:
		# Handles walking left/right.
		var hDirection := Input.get_axis("walkLeft", "walkRight")
		if hDirection:
			#Moves the player left or right based on the button you click
			velocity.x = hDirection * SPEED
		else:
			#Stops the player when you aren't clicking anything
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
		# Handles walking up/down.
		var vDirection := Input.get_axis("walkUp","walkDown")
		if vDirection:
			#Moves the player up or dwon based on the button you click
			velocity.y = vDirection*SPEED
		else:
			#Stops the player when you aren't clicking anything
			velocity.y= move_toward(velocity.y,0,SPEED)
		if hDirection!=0 or vDirection !=0:
			#Plays Walk if moving
			animated_sprite_2d.play("Walk")
		else:
			#Plays idle when not moving
			animated_sprite_2d.play("Idle")
		#Flips spirte when going left
		if hDirection<0:
			animated_sprite_2d.flip_h=true
		elif hDirection>0:
			animated_sprite_2d.flip_h=false
	move_and_slide()
	
	#Dashing
	if Input.is_action_just_pressed("Dash"):
		dash()
		
func dash():
	#Makes the dash direction start as 0,0
	var dashDirection:Vector2=Vector2(0,0)
	#Sets the current dash direction to which direction you are moving
	if(velocity.x>0):
		dashDirection.x=1
	elif(velocity.x<0):
		dashDirection.x=-1
	if(velocity.y>0):
		dashDirection.y=1
	elif(velocity.y<0):
		dashDirection.y=-1
	
	#Sets a target end position for the dash, based on the strengh, and the direction you are moving
	var dashTarget = global_position+(Vector2(dashDist,dashDist)*dashDirection)
	print(global_position,dashTarget)
	#Stops the movement animations from overiding this one
	normalMove=false
	velocity=Vector2(0,0)
	animated_sprite_2d.play("Dash")
	dashPart.emitting=true
	global_position=dashTarget
	#Allows for normal player movement again
	print("done")
	normalMove =true
	
