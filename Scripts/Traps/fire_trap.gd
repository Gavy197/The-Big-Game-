extends Trap
#Onreadys
@onready var dmg_interval: Timer = $dmgInterval

func activate():
	#Prevents the trap from being activated multiple times
	if active==false:
		active=true
		visible=true
		#Plays the startup animation
		animated_sprite_2d.play("activate")
		await(animated_sprite_2d.animation_finished)
		animated_sprite_2d.play("active")
		#While the player is touching, they will continue to be on fire
		while target is Player:
			target.takeDamage(damage,null)
			dmg_interval.start()
			await(dmg_interval.timeout)
		animated_sprite_2d.play("deactivate")
		await(animated_sprite_2d.animation_finished)
		active=false
