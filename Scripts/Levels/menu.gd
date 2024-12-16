extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("MainScreen")


func _on_play_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file","res://Scenes/Levels/overworld.tscn")
	#get_tree().change_scene_to_file("res://Scenes/Levels/overworld.tscn")



func _on_exit_pressed() -> void:
	animation_player.play("HideAll")
	await(animation_player.animation_finished)
	animation_player.play("MainScreen")


func _on_controls_pressed() -> void:
	animation_player.play("HideAll")
	await(animation_player.animation_finished)
	animation_player.play("ControlScreen")


func _on_lore_pressed() -> void:
	animation_player.play("HideAll")
	await(animation_player.animation_finished)
	animation_player.play("LoreScreen")

func _on_objectives_pressed() -> void:
	animation_player.play("HideAll")
	await(animation_player.animation_finished)
	animation_player.play("ObjectiveScreen")
