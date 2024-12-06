extends Enemy

#exports
@export var attackDistance:int=200
#Onreadys
@onready var collision_shape_2d: CollisionShape2D = $AttackRange/CollisionShape2D
@onready var attackCooldown: Timer = $attackCooldown
#variables
var distanceTolerance=120
#Preloads
@onready var projectile=preload("res://Scenes/Enemies/golem_projectile.tscn")


func _ready() -> void:
	super._ready()
	enemyBehavior=enemyType.ranged
	collision_shape_2d.shape.radius=attackDistance

func _physics_process(delta: float) -> void:
	#Makes it have normal enemy behavior
	super._physics_process(delta)
	#Adds the ranged targeting movement
	if target!=null:
		if enemyBehavior==enemyType.ranged:
			#Stores the distance from the target
			var distance=sqrt((target.global_position.x-global_position.x)**2+(target.global_position.y-global_position.y)**2)
			var targetAngle=get_angle_to(target.global_position)
			if canMove==true:
				#If it's outside the attack range, it'll move closer
				if distance>=attackDistance:
					#Sets the velocity based on the angle
					velocity=Vector2(cos(targetAngle)*speed,sin(targetAngle)*speed)
				elif distance<attackDistance-distanceTolerance:
					#Makes it go away from the player
					velocity=Vector2(cos(targetAngle+PI)*speed,sin(targetAngle+PI)*speed)
					
				else:
					#Makes sure the cooldown is ready
					if attackCooldown.time_left==0:
						#Stop moveing and attack
						canMove=false
						velocity=Vector2.ZERO
						attack()
			#Sets the direction based on where it's trying to move
			direction=Vector2(cos(targetAngle),sin(targetAngle))
			
#Shoots a pojectile for the attack
func attack():
	#Makes sure it's not dead
	if health>0:
		print("attack")
		#Plays animation
		animated_sprite_2d.play("Attack")
		await(animated_sprite_2d.animation_finished)
		#Double check to make sure that the target is still in range
		if inRange==true:
			#Makes sure it's not dead
			if health>0:
				#Shoots a projectile
				var instance=projectile.instantiate()
				instance.target=target
				instance.global_position=global_position
				instance.creator=self
				instance.damage=damage
				add_sibling(instance)

		#Enables movement and plays animation
		canMove=true
		velocity=direction
		animated_sprite_2d.play("Walking")
		#Starts the cooldown
		attackCooldown.start()

func death():
	if dying==false:
		print("die")
		#locks movement
		canMove=false
		velocity=Vector2.ZERO
		animated_sprite_2d.play("Death")
		await(animated_sprite_2d.animation_finished)
		queue_free()

func takeDamage(amount:int,attacker:CharacterBody2D):
	#Creates a dmg indicator with the amout of damage taken
	var instance = dmgIndicator.instantiate()
	add_child(instance)
	instance.text=str(amount)
	#moves the text up a bit
	instance.position.y=-50
	health-=amount
	print("golem ",health)
	if health<=0:
		death()
		dying=true
