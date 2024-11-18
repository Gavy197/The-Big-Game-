extends CharacterBody2D

class_name Enemy

const SPEED = 300.0


func _ready():
	pass

func _physics_process(delta: float) -> void:
	

	move_and_slide()
