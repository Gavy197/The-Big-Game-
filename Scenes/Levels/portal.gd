extends Area2D
@export var target:PackedScene
var exit_position:Vector2
@export var exit_offset:Vector2
@export var isexit=true

# Called when the node enters the scene tree for the first time.
func _ready():
	exit_position=global_position+exit_offset
	pass # Replace with function body.
func _on_body_entered(body: Node2D) -> void:
	if isexit:
		if body.name=="Player":
			get_tree().change_scene_to_file("res://Scenes/Levels/dungeon.tscn")
		isexit=false
	else:
		if body.name=="Player":
			get_tree().change_scene_to_file("res://Scenes/Levels/overworld.tscn")
		isexit=false
	if body.name==("Player"):
		pass
		#if isexit==true:
			#body.exit_position=exit_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
