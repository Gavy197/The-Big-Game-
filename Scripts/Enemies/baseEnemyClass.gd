extends CharacterBody2D

class_name Enemy

#Variables
var direction:Vector2=Vector2(0,0)
enum enemyType {melee,ranged,other}
var target:CharacterBody2D
var canMove:bool=true
var inRange:bool=false
var dying:bool=false
#Exported variables
@export var speed = 100.0
@export var enemyBehavior:enemyType
@export var damage:int=5
@export var health:int=50
#Onreadys
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D 
@onready var hitBox: CollisionShape2D = $CollisionShape2D 
@onready var wallCheck: RayCast2D = $WallCheck
@onready var attentionTimer: Timer = $attentionTimer
@onready var attackRange: Area2D = $AttackRange
#Preloads
@onready var dmgIndicator=preload("res://Scenes/Enemies/dmg_indicator.tscn")

func _ready():
	#Picks a starting direction
	pickDir()

func pickDir():
	#Resets velocity
	#velocity=Vector2.ZERO
	var randStart=randi_range(1,4)
	#Picks a random direction to walk in
	if randStart ==1:
		direction=Vector2(1,0)
	elif randStart ==2:
		direction=Vector2(-1,0)
	elif randStart ==3:
		direction=Vector2(0,-1)
	elif randStart ==4:
		direction=Vector2(0,1)
	velocity=direction*speed

func _physics_process(delta: float) -> void:
	if canMove==true:
		#Failsafe method for getting stuck
		if velocity==Vector2(0,0):
			pickDir()
			#Clears target
			target=null
		if target==null:
			if velocity.x!=0:
				direction.y=0
				#Sets the x direction variable
				direction.x=velocity.sign().x
			if velocity.y!=0:
				direction.x=0
				#Sets the y direction variable
				direction.y=velocity.sign().y
	#Flips the sprite based on the velocity
	if velocity.x<0:
		animated_sprite_2d.flip_h=false
	elif velocity.x>0:
		animated_sprite_2d.flip_h=true
	
	#Sets the wall checking ray to the direction
	wallCheck.target_position=direction*30
	#Makes the enemy behave diffently when the target is close
	if target!=null:
		if enemyBehavior==enemyType.melee:
			var targetAngle=get_angle_to(target.global_position)
			if canMove==true:
				#Sets the velocity based on the angle
				velocity=Vector2(cos(targetAngle)*speed,sin(targetAngle)*speed)
			#Sets the direction based on where it's trying to move
			direction=Vector2(cos(targetAngle),sin(targetAngle))
		
	move_and_slide()
	
	
#Abstract attack function
func attack():
	pass
#Abstract death function
func death():
	pass
#Abstract death function
func takeDamage(amount:int,attacker:CharacterBody2D):
	pass
	
func _on_targeting_body_entered(body:Node2D) -> void:
	#Makes sure it can only track the player
	if body.name=="Player":
		#Sets the target varible to the body it sees(the player)
		target=body
		#Stops the attention timer
		attentionTimer.stop()



func _on_targeting_body_exited(body:Node2D) -> void:
	#This is only here to prevent a werid error
	if health>0:
		#Makes sure it can only track the player
		if body==target:
			#Starts the attention timer, 
			#once it runs out the enemy losses intrests 
			#and picks a random direction again
			attentionTimer.start()


func _on_wall_check_is_colliding() -> void:
	#Instantly turns if it's not targeting something
	if target==null:
		pickDir()
	#Treats the player as out of range if it is targeting something
	else:
		attentionTimer.start()

func _on_wall_check_not_colliding() -> void:
	#If the it has started to lose intrest in the player
	#(the attention timer started), then it'll stop the timer
	if attentionTimer.time_left<3 and attentionTimer.time_left>0:
		attentionTimer.stop()

func _on_attention_timer_timeout() -> void:
	#Stops attempting to follow the player
	target=null
	pickDir()


func _on_attack_range_body_entered(body: Node2D) -> void:
	if target==body:
		attack()
		inRange=true
		


func _on_attack_range_body_exited(body: Node2D) -> void:
	if target==body:
		attack()
		inRange=false
