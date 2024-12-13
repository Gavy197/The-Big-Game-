extends Area2D

class_name Trap
#Exports
@export var damage=0
@export var stepThreshhold=0
#Onreadys
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#Variables
var active:bool=false
var target:Player
var stepCount:int=0
func _ready() -> void:
	visible=false

#Abstract Activate Function
func activate():
	pass
	
func _on_body_entered(body: Node2D) -> void:
	#Makes sure only a player can trigger
	if body is Player:
		#Increases the step Count
		stepCount+=1
		if stepCount>stepThreshhold:
			#Activates the trap 
			activate()
		#Sets the conflict
		target=body
		
		
		
func _on_body_exited(body: Node2D) -> void:
	#Removes the target
	target=null
