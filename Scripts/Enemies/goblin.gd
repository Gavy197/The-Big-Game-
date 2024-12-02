extends Enemy

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
				target.takeDamage(damage)
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
		queue_free()
#Abstract death function
func takeDamage(amount:int):
	#Creates a dmg indicator with the amout of damage taken
	var instance = dmgIndicator.instantiate()
	add_child(instance)
	instance.text=str(amount)
	#moves the text up a bit
	instance.position.y=-50
	health-=amount
	print("goblin ",health)
	if health<=0:
		death()
		dying=true