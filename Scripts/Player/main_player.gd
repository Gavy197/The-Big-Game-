extends CharacterBody2D
class_name Player
#signals
signal healthChanged

#Constants
const SPEED = 200.0

#Varibales
var dying:bool=false
var blocking:bool=false
var lockInput=false
@export var currentHealth: int = 90
var normalMove:bool =true
@export var maxHealth: int = 100
@export var inventory: Inventory
@export var dashDist:int=60
@export var dashCooldown=2
@export var effectCount:int=5
#Attacking Variables
@export var lightAttackDmg:int =3
@export var slashAttackDmg:int =1
@export var bubbleDmg:int =2
var dmgMultiplier=1
#Onreadys
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dashCD: Timer = $dashCD
@onready var dashCast:RayCast2D=$dashCast
@onready var lightAttackColision: CollisionShape2D = $lightAttackArea/CollisionShape2D
@onready var slashCD: Timer = $slashCD
@onready var bubbleCD: Timer = $bubbleCD



#Preloads
@onready var dashEffect=preload("res://Scenes/Players/dash_effect.tscn")
@onready var slash=preload("res://Scenes/Players/slash.tscn")
@onready var bubble=preload("res://Scenes/Players/bubble.tscn")

func _ready() -> void:
	dashCD.wait_time=dashCooldown
	#Sets the max health based on the global variable
	maxHealth=Global.maxHealth
	currentHealth=Global.currentHealth
	healthChanged.emit()
	print(maxHealth)
	#Allows for respawning with max health
	Global.currentHealth=maxHealth
	
func _physics_process(delta: float) -> void:
	#frequently updates dash checker
	if velocity!=Vector2(0,0):
		#Sets the size of the dash ray to how far you are dashing
		dashCast.target_position=Vector2(abs(dashDist*velocity.sign().x),dashDist*velocity.sign().y)

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
			#animated_sprite_2d.flip_h=true
			scale.x=-scale.y
		elif hDirection>0:
			#animated_sprite_2d.flip_h=false
			scale.x=scale.y
	move_and_slide()

#Detects inputs for all other actions (dashing, attacking,ect)
func _input(event: InputEvent) -> void:
	#Makes sure inputs are unlocked
	if lockInput==false:
		#Handles dashing
		if Input.is_action_just_pressed("Dash"):
			#Makes sure you are stopped to dash
			if velocity!=Vector2(0,0):
				#makes sure that the dashCD has expired
				if dashCD.time_left==0:
					dash()
		if Input.is_action_just_pressed("lightAttack"):
			lightAttack()
		if Input.is_action_just_pressed("slashAttack"):
			slashAttack()
		if Input.is_action_just_pressed("bubble"):
			bubbleAttack()
			
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
	#Makes sure the target area is clear of obstacles
	if dashCast.is_colliding()==false:
		#Sets a starting position for use in the effect
		var startingPos=global_position
		#Sets a target end position for the dash, based on the strengh, and the direction you are moving
		var dashTarget = global_position+(Vector2(dashDist,dashDist)*dashDirection)
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
			if dashDirection.x<0:
				instance.flip_h=true
			else:
				instance.flip_h=false
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
	lightAttackColision.disabled=false
	#Waits for the animation to finish before allowin for player movement again
	await(animated_sprite_2d.animation_finished)
	normalMove=true
	#Disables attack Area
	#lightAttackArea.monitoring==false
	lightAttackColision.disabled=true

func slashAttack():
	#Makes sure the cooldown is at 0
	if slashCD.time_left==0:
		#Makes the player face the right way
		#if mouse is to the left
		if get_global_mouse_position().x-global_position.x<0:
			scale.x=-scale.y
		#if mouse is to the left
		elif get_global_mouse_position().x-global_position.x>0:
			scale.x=scale.y
		#Plays animation
		animated_sprite_2d.play("heavyAttack")
		normalMove=false
		velocity=Vector2.ZERO
		#Creates an instance of the slash scene
		var instance=slash.instantiate()
		#Sets the position, rotation, damage and creator before adding it to the scene
		instance.global_position=global_position
		instance.damage= slashAttackDmg
		if scale.y<0:
			instance.targetAngle=get_angle_to(get_global_mouse_position())-PI
		elif scale.y>0:
			instance.targetAngle=get_angle_to(get_global_mouse_position())
		instance.creator=self
		instance.rotate(instance.targetAngle)
		add_sibling(instance)
		slashCD.start()
		#unlocks movement
		await(animated_sprite_2d.animation_finished)
		normalMove=true

func bubbleAttack():
	#Makes sure the cooldown is at 0
	if bubbleCD.time_left==0:
		#Freezes movement
		normalMove=false
		velocity=Vector2.ZERO
		#Plays animation
		animated_sprite_2d.play("Idle")
		#Adds the bubble to the scene and sets the position
		var instance=bubble.instantiate()
		instance.global_position=global_position
		instance.creator=self
		instance.damage=bubbleDmg
		add_sibling(instance)
		blocking=true
		await(instance.popped)
		bubbleCD.start()

func takeDamage(amount:int,attacker:CharacterBody2D):
	#Reduces damage if blocking
	if blocking==false:
		currentHealth-=amount
	else:
		currentHealth-= amount*.5
	if currentHealth<=0:
		death()
	print("player ",currentHealth)


func _on_light_attack_area_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		body.takeDamage(lightAttackDmg*dmgMultiplier,self)


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.has_method("collect"):
		area.collect(inventory)
	 
#Saves the player's current and max health when you go through the portal
func saveHealth():
	Global.maxHealth=maxHealth
	Global.currentHealth=currentHealth
#Kills the player
func death():
	#Prevents death from running multiple times
	if dying==false:
		dying=true
		#Disables the hurtbox to prevent more damage
		$Hurtbox.disabled=true
		print("dead")
		#Locks movement
		normalMove=false
		velocity=Vector2.ZERO
		#Locks input
		lockInput=true
		#Plays animation
		animated_sprite_2d.play("death")
		await(animated_sprite_2d.animation_finished)
		#Reloads the current Scene
		get_tree().call_deferred("reload_current_scene")
		
