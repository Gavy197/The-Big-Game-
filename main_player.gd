extends CharacterBody2D

#signals
signal healthChanged
#Constants
const SPEED = 300.0

#Varibales
@export var currentHealth: int = 20
@export var maxHealth: int = 100

#Onreadys
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
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
		
	#Handles movement animations
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
