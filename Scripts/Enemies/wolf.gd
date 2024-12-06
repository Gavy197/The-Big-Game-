extends Enemy
#Makes it a wolf class for detection from other wolves
#Proably a better way to do this

class_name Wolf
#Onreadys
@onready var frenzyRange: Area2D = $FrenzyRange
#Variables
var frenzyTargets:Array=[]
var frenzyCount:int=0

func attack():
	#Makes sure it's not dead
	if health>0:
		#Prevents movement
		canMove=false
		#Freezes enemy
		velocity=Vector2.ZERO
		#print("attack")
		#Plays animation
		animated_sprite_2d.play("Attack")
		await(animated_sprite_2d.animation_finished)
		#Double check to make sure that the target is still in range
		if inRange==true:
			#Makes sure it's not dead
			if health>0:
				target.takeDamage(damage,self)
				#Since the target is still in range, it'll attempt to attack again
				attack()
		#If it's not in range, start chasing the player again
		else:
			#Fixes velocity for when movement is enabled
			var targetAngle=get_angle_to(target.global_position)
			#Sets the velocity based on the angle
			velocity=Vector2(cos(targetAngle)*speed,sin(targetAngle)*speed)
			#Enables movement and plays walk animation
			canMove=true
			animated_sprite_2d.play("Walking")


func death():
	if dying==false:
		print("die")
		#locks movement
		canMove=false
		velocity=Vector2.ZERO
		animated_sprite_2d.play("Death")
		await(animated_sprite_2d.animation_finished)
		for i in frenzyTargets:
			i.frenzy(target)
		#Prevents a error
		attentionTimer.queue_free()
		#Deletes the wolf
		queue_free()
	
func takeDamage(amount:int,attacker:CharacterBody2D):
	#Creates a dmg indicator with the amout of damage taken
	var instance = dmgIndicator.instantiate()
	add_child(instance)
	instance.text=str(amount)
	#moves the text up a bit
	instance.position.y=-50
	health-=amount
	print("wolf ",health)
	if health<=0:
		death()
		dying=true
	#Changes the target to whoever last attacked
	target=attacker

#This function runs when a nearby wolf dies
func frenzy(newTarget):
	#Prevents wolves from becoming too strong
	if frenzyCount<8:
		#Makes sure it's not dead
		if health>0:
			#Buffs health, speed, and damage
			health+=4
			speed+=12
			damage+=2
			#Makes the wolf attack the player(if it wasn't already)
			target=newTarget
			#Makes the wolf slightly larger(for a visible indicator)
			scale+=Vector2(.05,.05)
			frenzyCount+=1


func _on_frenzy_range_body_entered(body: Node2D) -> void:
	#If a wolf is entering range, add it to the list of frenzy targets
	if body is Wolf:
		#Makes sure it ignores itself
		if body !=self:
			frenzyTargets.append(body)
	


func _on_frenzy_range_body_exited(body: Node2D) -> void:
	#If a wolf dies or leaves range, it is removed from frenzy targets
	if body is Wolf:
		frenzyTargets.erase(body)
