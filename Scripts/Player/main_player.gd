extends CharacterBody2D

#signals
signal healthChanged


#Constants
const SPEED = 200.0

#Varibales
@export var currentHealth: int = 50
#Varibales
#@export var inventory: Inventory
@export var maxHealth: int = 100
@export var inventory: Inventory



var normalMove:bool =true
@export var dashDist:int=60
@export var dashCooldown=2
@export var effectCount:int=5

#Onreadys
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dashCD: Timer = $dashCD
@onready var dashCast:RayCast2D=$dashCast
@onready var lightAttackArea: CollisionShape2D = $lightAttackArea/CollisionShape2D

#Preloads
@onready var dashEffect=preload("res://Scenes/Players/dash_effect.tscn")

func _ready() -> void:
	dashCD.wait_time=dashCooldown
func _physics_process(delta: float) -> void:
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

#Detects inputs for all other actions (dashing, attacking,ect)
func _input(event: InputEvent) -> void:
	#Handles dashing
	if Input.is_action_just_pressed("Dash"):
		#Makes sure you are stopped to dash
		if velocity!=Vector2(0,0):
			#makes sure that the dashCD has expired
			if dashCD.time_left==0:
				dash()
	if Input.is_action_just_pressed("lightAttack"):
		lightAttack()
			
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
	#Sets the size of the dash ray to how far you are dashing
	dashCast.target_position==Vector2(dashDist*dashDirection.x,dashDist*dashDirection.y)
	#Makes sure the target area is clear of obstacles
	if dashCast.is_colliding()==false:
		#sets the direction of the dash 
		#Sets a starting position for use in the effect
		var startingPos=global_position
		#Sets a target end position for the dash, based on the strengh, and the direction you are moving
		var dashTarget = global_position+(Vector2(dashDist,dashDist)*dashDirection)
		print(global_position,dashTarget)
		#Stops the movement animations from overiding this one
		normalMove=false
		velocity=Vector2(0,0)
		animated_sprite_2d.play("Dash")
		global_position=dashTarget
		#Allows for normal player movement again
		for i in effectCount:
			var instance = dashEffect.instantiate()
			get_parent().add_child(instance)
			#Handles x
			instance.global_position.x=startingPos.x+((dashDist/effectCount)*(i)*dashDirection.x)
			#Handles y
			instance.global_position.y=startingPos.y+((dashDist/effectCount)*(i)*dashDirection.y)
			#Flips the sprite of the effect, if needed
			instance.flip_h=animated_sprite_2d.flip_h
			#Changes the color of the dash
			instance.modulate.r+=i
		#Restarts the cooldown
		dashCD.start()
		normalMove =true
func lightAttack():
	#Disables/stops movement
	normalMove=false
	velocity=Vector2(0,0)
	animated_sprite_2d.play("lightAttack")
	#lightAttackArea.monitoring==true
	lightAttackArea.disabled==true
	#Waits for the animation to finish before allowin for player movement again
	await(animated_sprite_2d.animation_finished)
	normalMove=true
	#Disables attack Area
	#lightAttackArea.monitoring==false
	lightAttackArea.disabled==false

	


func _on_light_attack_area_body_entered(body: Node2D) -> void:
	print("hit")
	#Enemy detection/damage code will come later



func _on_pickup_area_area_entered(area: Area2D) -> void:
	print("Pickup")
	if area.has_method("collect"):
		print("pickupin")
		area.collect(inventory)
	 
