extends Enemy
#Variables
var generation:int=1
var canClone:bool=false
var isClone:bool=false
#Onreadys
@onready var attackTimer: Timer = $attackTimer
@onready var abilityTimer: Timer = $abilityTimer
#Preloads
@onready var slimeCopy=preload("res://Scenes/Enemies/slime.tscn")
#Exports
@export var firstAttackTime:float=.35
@export var attackTime:float=.3

func attack():
	#Makes sure it's not dead
	if health>0:
		#Starts a timer before it can attack
		attackTimer.start(firstAttackTime)
		await(attackTimer.timeout)
		#Makes sure the target is still in range
		if health>0 and inRange==true:
			#print("attack")
			target.takeDamage(damage,self)
			#Starts a cooldown before it can attack again
			attackTimer.start(attackTime)
			await(attackTimer.timeout)
			#If the target is still in range, it'll attack again
			if inRange==true:
				attack()
		



func death():
	if dying==false:
		#Prevent death cloning
		canClone=false
		#locks movement
		canMove=false
		velocity=Vector2.ZERO
		animated_sprite_2d.play("Death")
		await(animated_sprite_2d.animation_finished)
		queue_free()

func takeDamage(amount:int,attacker:CharacterBody2D):
	#Makes the slime take more damage if it's a clone
	if(isClone==true):
		amount+=2
	#Creates a dmg indicator with the amout of damage taken
	var instance = dmgIndicator.instantiate()
	add_child(instance)
	instance.text=str(amount)
	#moves the text up a bit
	instance.position.y=-50
	health-=amount
	print("slime",generation," ",health)
	if health<=0:
		death()
		dying=true


#Splits into 2 Slimes
func _on_ability_timer_timeout() -> void:
	#Makes sure the slime is allowed to make a clone
	if canClone==true:
		#Stops the slimes from making infinite clones
		if generation<=4:
			#Locks movement
			canMove=false
			velocity=Vector2.ZERO
			#Saves the starting point
			var startPos=global_position
			#Creates a copy of the slime
			var instance = slimeCopy.instantiate()
			#Plays the spliting animation
			animated_sprite_2d.play("Split")
			await(animated_sprite_2d.animation_finished)
			#Shift this slime over
			global_position.x+=4
			#Unlock movement/picks restarts movement
			canMove=true
			pickDir()
			animated_sprite_2d.play("Walking")
			#Adds the copy to the world
			add_sibling(instance)
			#Shifts this slime over to match with the animation
			instance.global_position=startPos+Vector2(4,-1)
			#Increases the generation variable to stop infinite clones
			generation+=1
			instance.generation=generation
			instance.isClone=true


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	#Allows the slime to start cloning once it's on screen
	canClone=true
	#Starts the ability timer
	abilityTimer.start()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#Prevents the slime from makinge clones now that it's off screen
	canClone=false
	#Stops the ability timer
	abilityTimer.stop()
