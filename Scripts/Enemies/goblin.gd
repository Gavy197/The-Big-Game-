extends Enemy

func attack():
	#Prevents movement
	canMove=false
	#Freezes enemy
	velocity=Vector2.ZERO
	print("attack")
	#Plays animation
	animated_sprite_2d.play("Attack")
	await(animated_sprite_2d.animation_finished)
	#Double check to make sure that the target is still in range
	if inRange==true:
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
	print("die")
#Abstract death function
func takeDamage(amount:int):
	modulate=Color(1,0,0)
	health-=amount
	if health<=0:
		death()
	modulate=Color(1,1,1)
