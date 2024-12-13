extends Trap
#Onreadys
@onready var cooldown:Timer=$cooldown
#variables
var adjacentSpikes:Array=[]

func activate():
	#Prevents the trap from being activated multiple times
	if active==false:
		visible=true
		active=true
		#Plays the startup animation
		animated_sprite_2d.play("activate")
		await(animated_sprite_2d.animation_finished)
		animated_sprite_2d.play("active")
		#Activates adjacent spikes
		for i in adjacentSpikes:
			i.activate()
		#Checks if the player is still touching
		if target is Player:
			#Deals damage to the player
			target.takeDamage(damage,null)
		await(animated_sprite_2d.animation_finished)
		animated_sprite_2d.play("deactivate")
		#Starts the spike cooldown
		cooldown.start()
		await(cooldown.timeout)
		active=false
	


#Detects adjacent spikes
func _on_activate_area_area_entered(area: Area2D) -> void:
	adjacentSpikes.append(area.get_parent())
